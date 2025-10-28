//
//  MenuAnalysisService.swift
//  IAGota
//
//  Servicio para analizar fotos de cartas de restaurante
//

import UIKit
import Foundation

class MenuAnalysisService {
    private let apiKey: String
    private let visionModel: String
    private let apiURL = "https://openrouter.ai/api/v1/chat/completions"

    // MARK: - Initialization

    init(apiKey: String, visionModel: String = "openai/gpt-4o-mini") {
        self.apiKey = apiKey
        self.visionModel = visionModel
    }

    // MARK: - Main Analysis Method

    /// Analiza una foto de carta y devuelve los platos con sus niveles de purinas
    func analyzeMenu(image: UIImage) async throws -> MenuAnalysisResult {
        // Paso 1: Validar que es una carta
        print("📸 Paso 1: Validando que sea una carta...")
        let isValid = try await validateIsMenu(image: image)

        if !isValid {
            return MenuAnalysisResult(
                isValidMenu: false,
                errorMessage: "Esta imagen no parece ser una carta de restaurante. Por favor, fotografía un menú con lista de platos.",
                dishes: []
            )
        }

        // Paso 2: Extraer lista de platos
        print("📝 Paso 2: Extrayendo platos de la carta...")
        let dishNames = try await extractDishes(image: image)

        if dishNames.isEmpty {
            return MenuAnalysisResult(
                isValidMenu: true,
                errorMessage: "No se pudieron identificar platos en esta imagen. Asegúrate de que la foto sea clara y contenga texto legible.",
                dishes: []
            )
        }

        print("✅ Encontrados \(dishNames.count) platos")

        // Paso 3: Analizar cada plato (máximo 20 platos para no saturar)
        print("🔍 Paso 3: Analizando contenido de purinas de cada plato...")
        let limitedDishes = Array(dishNames.prefix(20))
        let dishes = try await analyzeDishes(limitedDishes)

        return MenuAnalysisResult(
            isValidMenu: true,
            errorMessage: nil,
            dishes: dishes
        )
    }

    // MARK: - Step 1: Validate Menu

    private func validateIsMenu(image: UIImage) async throws -> Bool {
        let base64Image = convertImageToBase64(image)

        let prompt = """
        Analiza esta imagen y determina si es una carta o menú de restaurante.

        Una carta válida contiene:
        - Lista de platos o comidas
        - Nombres de platos legibles
        - Puede tener precios, descripciones, secciones

        NO es válida si es:
        - Una foto de persona
        - Un documento no relacionado con comida
        - Un objeto o paisaje
        - Texto ilegible o borroso

        Responde ÚNICAMENTE en formato JSON:
        {
          "isMenu": true o false,
          "reason": "breve explicación"
        }
        """

        let response = try await sendVisionRequest(base64Image: base64Image, prompt: prompt)

        // Parsear respuesta
        let cleanContent = response
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard let data = cleanContent.data(using: .utf8) else {
            throw URLError(.cannotParseResponse)
        }

        let validation = try JSONDecoder().decode(MenuValidationResponse.self, from: data)
        return validation.isMenu
    }

    // MARK: - Step 2: Extract Dishes

    private func extractDishes(image: UIImage) async throws -> [String] {
        let base64Image = convertImageToBase64(image)

        let prompt = """
        Extrae ÚNICAMENTE los nombres de los platos de esta carta de restaurante.

        REGLAS ESTRICTAS:
        - Solo nombres de platos (NO precios, NO símbolos €, $)
        - NO incluir descripciones largas
        - NO incluir bebidas (solo platos de comida)
        - Si un plato tiene variaciones, lista solo el nombre base
        - Máximo 30 platos

        EJEMPLOS:
        ✅ "Pollo a la plancha"
        ✅ "Ensalada César"
        ✅ "Paella mixta"
        ❌ "Pollo a la plancha ........ 12€"
        ❌ "Coca-Cola"
        ❌ "Entrantes"

        Responde ÚNICAMENTE en formato JSON:
        {
          "dishes": ["Plato 1", "Plato 2", "Plato 3"]
        }
        """

        let response = try await sendVisionRequest(base64Image: base64Image, prompt: prompt)

        // Parsear respuesta
        let cleanContent = response
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard let data = cleanContent.data(using: .utf8) else {
            throw URLError(.cannotParseResponse)
        }

        let extraction = try JSONDecoder().decode(DishesExtractionResponse.self, from: data)
        return extraction.dishes
    }

    // MARK: - Step 3: Analyze Purines for Each Dish

    private func analyzeDishes(_ dishNames: [String]) async throws -> [DishAnalysis] {
        var results: [DishAnalysis] = []

        // Usar el servicio existente de OpenRouter para analizar cada plato
        let service = OpenRouterService(apiKey: apiKey, model: "openai/gpt-4o-mini")

        for dishName in dishNames {
            do {
                print("  Analizando: \(dishName)")
                let foodResponse = try await service.consultarAlimento(dishName)

                let dish = DishAnalysis(
                    name: dishName,
                    level: foodResponse.nivel,
                    category: foodResponse.categoria,
                    reason: foodResponse.razon,
                    purinas: foodResponse.purinas
                )

                results.append(dish)

                // Pequeño delay para no saturar la API
                try await Task.sleep(nanoseconds: 300_000_000) // 0.3 segundos
            } catch {
                print("⚠️ Error analizando \(dishName): \(error.localizedDescription)")
                // Continuar con el siguiente plato
            }
        }

        return results
    }

    // MARK: - Helper: Send Vision Request

    private func sendVisionRequest(base64Image: String, prompt: String) async throws -> String {
        let body: [String: Any] = [
            "model": visionModel,
            "messages": [
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "text",
                            "text": prompt
                        ],
                        [
                            "type": "image_url",
                            "image_url": [
                                "url": "data:image/jpeg;base64,\(base64Image)"
                            ]
                        ]
                    ]
                ]
            ],
            "temperature": 0.2
        ]

        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            if let errorMessage = String(data: data, encoding: .utf8) {
                print("Error de OpenRouter (código \(httpResponse.statusCode)): \(errorMessage)")

                // Crear error más descriptivo según código
                if httpResponse.statusCode == 429 {
                    throw NSError(domain: "OpenRouter", code: 429, userInfo: [NSLocalizedDescriptionKey: "El servicio de análisis de imágenes está temporalmente saturado. Por favor, inténtalo de nuevo en unos minutos."])
                } else if httpResponse.statusCode == 401 {
                    throw NSError(domain: "OpenRouter", code: 401, userInfo: [NSLocalizedDescriptionKey: "API Key inválida. Verifica tu configuración."])
                } else if httpResponse.statusCode == 402 {
                    throw NSError(domain: "OpenRouter", code: 402, userInfo: [NSLocalizedDescriptionKey: "Créditos insuficientes en OpenRouter. Recarga tu cuenta."])
                }
            }
            throw NSError(domain: "OpenRouter", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Error al analizar la imagen"])
        }

        let openRouterResponse = try JSONDecoder().decode(OpenRouterResponse.self, from: data)

        guard let content = openRouterResponse.choices.first?.message.content else {
            throw URLError(.cannotParseResponse)
        }

        return content
    }

    // MARK: - Helper: Convert Image to Base64

    private func convertImageToBase64(_ image: UIImage) -> String {
        // Redimensionar imagen para optimizar tamaño (max 1024px)
        let maxSize: CGFloat = 1024
        let resized = resizeImage(image, maxSize: maxSize)

        // Convertir a JPEG con compresión
        guard let imageData = resized.jpegData(compressionQuality: 0.8) else {
            return ""
        }

        return imageData.base64EncodedString()
    }

    private func resizeImage(_ image: UIImage, maxSize: CGFloat) -> UIImage {
        let size = image.size
        let ratio = size.width / size.height

        var newSize: CGSize
        if size.width > size.height {
            newSize = CGSize(width: maxSize, height: maxSize / ratio)
        } else {
            newSize = CGSize(width: maxSize * ratio, height: maxSize)
        }

        if size.width <= maxSize && size.height <= maxSize {
            return image
        }

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? image
    }
}
