//
//  OpenRouterService.swift
//  IAGota
//
//  Servicio para consultar la API de OpenRouter y obtener información de alimentos
//

import Foundation

// MARK: - OpenRouterService

/// Cliente HTTP para comunicarse con la API de OpenRouter
class OpenRouterService {
    // MARK: - Properties

    private let apiKey: String
    private let model: String
    private let apiURL = "https://openrouter.ai/api/v1/chat/completions"

    // MARK: - Initialization

    init(apiKey: String, model: String = "openai/gpt-4o-mini") {
        self.apiKey = apiKey
        self.model = model
    }

    // MARK: - API Methods

    /// Consulta un alimento o plato y obtiene su información nutricional respecto al ácido úrico
    /// - Parameter alimento: Nombre del alimento, ingredientes o plato a consultar
    /// - Returns: Respuesta estructurada con nivel, categoría, razón y contenido de purinas
    func consultarAlimento(_ alimento: String) async throws -> FoodResponse {
        // Crear el prompt
        let prompt = """
        Eres un asistente educativo nutricional especializado en el análisis de purinas en alimentos. Tu objetivo es proporcionar información precisa y extendida sobre el contenido de purinas para ayudar a las personas a tomar mejores decisiones alimenticias.

        CONTEXTO NUTRICIONAL:
        - Las purinas se metabolizan en ácido úrico
        - Una dieta baja en purinas generalmente limita la ingesta a < 150 mg/día
        - La cocción puede reducir purinas en un 30-50% (purinas solubles en agua)
        - Los valores deben ser lo más exactos posible basándose en literatura científica

        CLASIFICACIÓN ESTRICTA:
        - BAJO (verde): < 50 mg/100g → Consumo libre
        - MODERADO (amarillo): 50-150 mg/100g → Consumo ocasional limitado
        - ALTO (rojo): > 150 mg/100g → Evitar completamente

        TIPO DE CONSULTA:
        - Alimento simple: proporciona valor exacto de purinas
        - Múltiples ingredientes: calcula el promedio ponderado
        - Plato completo: analiza los ingredientes principales y estima el contenido total

        INSTRUCCIONES:
        1. Identifica TODOS los ingredientes del alimento/plato
        2. Busca en tu base de conocimiento médico el contenido EXACTO de purinas
        3. Si es un plato cocinado, considera la preparación (hervido reduce purinas)
        4. Proporciona el valor más preciso posible
        5. La explicación debe ser técnica pero comprensible

        EJEMPLOS DE REFERENCIA:
        - Anchoas/sardinas: ~410 mg/100g
        - Hígado/vísceras: ~300 mg/100g
        - Cerveza: ~15 mg/100ml (pero inhibe excreción de ácido úrico)
        - Espárragos: ~23 mg/100g
        - Tomate: ~11 mg/100g
        - Pollo (sin piel): ~110 mg/100g

        Responde ÚNICAMENTE en formato JSON válido con esta estructura exacta:
        {
          "nivel": "verde o amarillo o rojo",
          "categoria": "Seguro o Moderado o Evitar",
          "razon": "explicación técnica pero clara del porqué, mencionando el contenido específico y efectos metabólicos (máximo 3 líneas)",
          "purinas": número_entero (contenido en mg por 100g, debe ser PRECISO),
          "score": número_entero de 0 a 100 (100 = más seguro para ácido úrico, basado en purinas y otros factores),
          "alternativas": [solo si nivel es amarillo o rojo, array de 2-3 objetos con {nombre: string, purinas: número, nivel: string}],
          "contextoTemporal": "string opcional con frecuencia segura de consumo (ej: 'Consumir máximo 1 vez por semana si el resto de la dieta es baja en purinas')",
          "consejoPreparacion": "string opcional SOLO si existe una forma de cocinar que reduzca significativamente las purinas (ej: 'Hervir este alimento reduce sus purinas en 30-50%')",
          "factoresMetabolicos": "string opcional SOLO si el alimento tiene efectos especiales en el metabolismo del ácido úrico más allá de su contenido de purinas (ej: cerveza inhibe excreción, fructosa alta aumenta producción)",
          "infoNutricional": {objeto opcional con datos relevantes: proteinas (double), fructosa (double), vitaminaC (double), omega3 (string: 'alto'/'medio'/'bajo')}
        }

        CRITERIOS PARA CAMPOS OPCIONALES:
        - score: Calcula basándote en purinas (peso 70%), factores metabólicos (20%), y beneficios nutricionales (10%)
        - alternativas: Solo para amarillo/rojo. Sugiere 2-3 alimentos similares pero más seguros
        - contextoTemporal: Proporciona siempre si nivel es amarillo o rojo
        - consejoPreparacion: Solo si hervir/cocinar reduce purinas significativamente
        - factoresMetabolicos: Solo si hay efectos especiales (cerveza, alcohol, fructosa alta, etc.)
        - infoNutricional: Incluye solo datos relevantes para ácido úrico (vitamina C ayuda, fructosa aumenta, omega-3 antiinflamatorio)

        IMPORTANTE - RESTRICCIONES LEGALES:
        - NO uses lenguaje prescriptivo como "debes", "tienes que", "recomendamos"
        - USA lenguaje informativo: "contiene", "este alimento presenta", "se caracteriza por"
        - Esta es información nutricional educativa, NO recomendación médica
        - NO uses términos como "paciente", "médico", "diagnóstico", "tratamiento"
        - USA lenguaje educativo: "personas que controlan purinas", "hábitos alimenticios saludables"
        - Usa castellano neutro (no regionalismos)
        - Sé EXACTO con los números de purinas

        CONSULTA: \(alimento)
        """

        // Crear el body de la petición
        let body: [String: Any] = [
            "model": model,
            "messages": [
                [
                    "role": "user",
                    "content": prompt
                ]
            ],
            "temperature": 0.2
        ]

        // Crear la request
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        // Hacer la petición
        let (data, response) = try await URLSession.shared.data(for: request)

        // Verificar status code
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        // Manejar diferentes códigos de error
        guard (200...299).contains(httpResponse.statusCode) else {
            // Intentar leer el mensaje de error de OpenRouter
            if let errorMessage = String(data: data, encoding: .utf8) {
                print("Error de OpenRouter (código \(httpResponse.statusCode)): \(errorMessage)")

                // Crear error más descriptivo
                if httpResponse.statusCode == 401 {
                    throw NSError(domain: "OpenRouter", code: 401, userInfo: [NSLocalizedDescriptionKey: "API Key inválida o sin permisos para este modelo"])
                } else if httpResponse.statusCode == 403 {
                    throw NSError(domain: "OpenRouter", code: 403, userInfo: [NSLocalizedDescriptionKey: "No tienes acceso a este modelo. Verifica tu cuenta en OpenRouter."])
                } else if httpResponse.statusCode == 429 {
                    throw NSError(domain: "OpenRouter", code: 429, userInfo: [NSLocalizedDescriptionKey: "Límite de consultas alcanzado. Espera unos minutos."])
                } else {
                    throw NSError(domain: "OpenRouter", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Error del servidor: \(errorMessage)"])
                }
            }
            throw URLError(.badServerResponse)
        }

        // Decodificar la respuesta de OpenRouter
        let openRouterResponse = try JSONDecoder().decode(OpenRouterResponse.self, from: data)

        // Extraer el contenido JSON de la respuesta
        guard let content = openRouterResponse.choices.first?.message.content else {
            throw URLError(.cannotParseResponse)
        }

        // Limpiar el contenido (remover markdown si existe)
        let cleanContent = content
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        // Decodificar el JSON de la comida
        guard let contentData = cleanContent.data(using: .utf8) else {
            throw URLError(.cannotParseResponse)
        }

        let foodResponse = try JSONDecoder().decode(FoodResponse.self, from: contentData)
        return foodResponse
    }
}
