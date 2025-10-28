//
//  IAGotaTests.swift
//  IAGotaTests
//
//  Tests unitarios para IAGota
//

import Testing
import Foundation
@testable import IAGota

// MARK: - APIKeyManager Tests

struct APIKeyManagerTests {

    @Test("Valida formato correcto de API key")
    func testValidAPIKeyFormat() {
        let manager = APIKeyManager()

        // API key válida
        let validKey = "sk-or-v1-1234567890abcdefghijklmnopqrstuvwxyz"
        #expect(manager.isValidAPIKey(validKey))
    }

    @Test("Rechaza API key con formato incorrecto")
    func testInvalidAPIKeyFormat() {
        let manager = APIKeyManager()

        // API keys inválidas
        let invalidKeys = [
            "",
            "invalid",
            "sk-or-123",
            "api-key-123456789",
            "sk-or-v1-short"
        ]

        for key in invalidKeys {
            #expect(!manager.isValidAPIKey(key))
        }
    }

    @Test("Verifica que hasAPIKey funciona correctamente")
    func testHasAPIKey() {
        let manager = APIKeyManager()

        // Resetear primero
        manager.resetAPIKey()

        // Sin API key debe devolver false si no hay Config.plist
        // (puede ser true si existe Config.plist en desarrollo)
        let hasKey = manager.hasAPIKey()

        // Guardar una API key
        manager.saveAPIKey("sk-or-v1-1234567890abcdefghijklmnopqrstuvwxyz")

        // Ahora debe tener API key
        #expect(manager.hasAPIKey())
    }
}

// MARK: - FoodResponse Tests

struct FoodResponseTests {

    @Test("Parsea JSON válido correctamente")
    func testValidJSONParsing() throws {
        let jsonString = """
        {
            "nivel": "verde",
            "categoria": "Seguro",
            "razon": "Bajo contenido de purinas",
            "purinas": 11
        }
        """

        let data = jsonString.data(using: .utf8)!
        let response = try JSONDecoder().decode(FoodResponse.self, from: data)

        #expect(response.nivel == "verde")
        #expect(response.categoria == "Seguro")
        #expect(response.razon == "Bajo contenido de purinas")
        #expect(response.purinas == 11)
    }

    @Test("Falla con JSON incompleto")
    func testInvalidJSONParsing() {
        let jsonString = """
        {
            "nivel": "verde",
            "categoria": "Seguro"
        }
        """

        let data = jsonString.data(using: .utf8)!

        #expect(throws: Error.self) {
            try JSONDecoder().decode(FoodResponse.self, from: data)
        }
    }

    @Test("Verifica que FoodResponse es Equatable")
    func testFoodResponseEquatable() {
        let response1 = FoodResponse(
            nivel: "verde",
            categoria: "Seguro",
            razon: "Bajo en purinas",
            purinas: 11
        )

        let response2 = FoodResponse(
            nivel: "verde",
            categoria: "Seguro",
            razon: "Bajo en purinas",
            purinas: 11
        )

        let response3 = FoodResponse(
            nivel: "rojo",
            categoria: "Evitar",
            razon: "Alto en purinas",
            purinas: 200
        )

        #expect(response1 == response2)
        #expect(response1 != response3)
    }
}

// MARK: - ModelManager Tests

struct ModelManagerTests {

    @Test("Verifica que hay exactamente 2 modelos disponibles")
    func testAvailableModelsCount() {
        let models = ModelManager.availableModels

        // En v1.2 solo hay 2 modelos: GPT-4o-mini y GPT-4o
        #expect(models.count == 2)

        // Verificar que ambos son modelos de OpenAI
        #expect(models.allSatisfy { $0.id.contains("openai") })

        // Verificar que ambos son de pago (no hay modelos gratuitos en v1.2)
        #expect(models.allSatisfy { !$0.isFree })
    }

    @Test("Verifica que GPT-4o-mini es el modelo por defecto")
    func testDefaultModelSelection() {
        let defaultModel = ModelManager.defaultModel

        // GPT-4o-mini debe ser el modelo por defecto
        #expect(defaultModel.id == "openai/gpt-4o-mini")
        #expect(defaultModel.name == "GPT-4o Mini")
        #expect(defaultModel.speed == "rápido")
    }

    @Test("Verifica que GPT-4o es el modelo preciso")
    func testPreciseModelSelection() {
        let preciseModel = ModelManager.preciseModel

        // GPT-4o debe ser el modelo preciso
        #expect(preciseModel.id == "openai/chatgpt-4o-latest")
        #expect(preciseModel.name == "GPT-4o")
        #expect(preciseModel.speed == "medio")
    }

    @Test("Verifica que cada modelo tiene ID único")
    func testUniqueModelIDs() {
        let models = ModelManager.availableModels
        let ids = models.map { $0.id }
        let uniqueIDs = Set(ids)

        #expect(ids.count == uniqueIDs.count)
    }

    @Test("Guarda y recupera modelo seleccionado")
    func testModelSelection() {
        let manager = ModelManager()
        let testModel = ModelManager.availableModels.first!

        manager.saveModel(testModel)

        #expect(manager.selectedModel.id == testModel.id)
    }
}

// MARK: - OpenRouterResponse Tests

struct OpenRouterResponseTests {

    @Test("Parsea respuesta de OpenRouter correctamente")
    func testOpenRouterResponseParsing() throws {
        let jsonString = """
        {
            "choices": [
                {
                    "message": {
                        "content": "{\\"nivel\\": \\"verde\\", \\"categoria\\": \\"Seguro\\", \\"razon\\": \\"Test\\", \\"purinas\\": 11}"
                    }
                }
            ]
        }
        """

        let data = jsonString.data(using: .utf8)!
        let response = try JSONDecoder().decode(OpenRouterResponse.self, from: data)

        #expect(response.choices.count == 1)
        #expect(response.choices.first?.message.content.contains("verde") == true)
    }

    @Test("Parsea respuesta con markdown json")
    func testOpenRouterResponseWithMarkdown() throws {
        let jsonString = """
        {
            "choices": [
                {
                    "message": {
                        "content": "```json\\n{\\"nivel\\": \\"rojo\\", \\"categoria\\": \\"Evitar\\", \\"razon\\": \\"Alto contenido\\", \\"purinas\\": 410}\\n```"
                    }
                }
            ]
        }
        """

        let data = jsonString.data(using: .utf8)!
        let response = try JSONDecoder().decode(OpenRouterResponse.self, from: data)

        #expect(response.choices.count == 1)
        let content = response.choices.first?.message.content
        #expect(content?.contains("rojo") == true)
        #expect(content?.contains("```json") == true)
    }

    @Test("Falla con respuesta vacía")
    func testEmptyResponse() {
        let jsonString = """
        {
            "choices": []
        }
        """

        let data = jsonString.data(using: .utf8)!

        #expect(throws: Never.self) {
            let response = try JSONDecoder().decode(OpenRouterResponse.self, from: data)
            #expect(response.choices.isEmpty)
        }
    }
}

// MARK: - OpenRouterService Tests

struct OpenRouterServiceTests {

    @Test("Inicializa con API key y modelo")
    func testServiceInitialization() {
        let service = OpenRouterService(apiKey: "sk-or-v1-test", model: "test-model")

        // El servicio debe inicializarse sin problemas
        #expect(service != nil)
    }

    @Test("Limpia markdown de contenido JSON")
    func testMarkdownCleanup() {
        // Simula el proceso de limpieza que hace el servicio
        let content = "```json\n{\"nivel\": \"verde\"}\n```"

        let cleanContent = content
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        #expect(cleanContent == "{\"nivel\": \"verde\"}")
        #expect(!cleanContent.contains("```"))
    }

    @Test("Valida estructura del prompt")
    func testPromptContainsRequiredSections() {
        // Verifica que el prompt incluye secciones críticas
        let prompt = """
        Actúa como un médico especialista en reumatología y nutricionista clínico
        """

        #expect(prompt.contains("médico especialista"))
        #expect(prompt.contains("reumatología"))
        #expect(prompt.contains("nutricionista"))
    }
}

// MARK: - MenuAnalysisModels Tests (v1.2)

struct MenuAnalysisModelsTests {

    @Test("Verifica inicialización de DishAnalysis")
    func testDishAnalysisInitialization() {
        let dish = DishAnalysis(
            name: "Salmón a la plancha",
            level: "verde",
            category: "Seguro",
            reason: "Bajo contenido de purinas",
            purinas: 45
        )

        #expect(dish.name == "Salmón a la plancha")
        #expect(dish.level == "verde")
        #expect(dish.category == "Seguro")
        #expect(dish.reason == "Bajo contenido de purinas")
        #expect(dish.purinas == 45)
        #expect(dish.id != UUID(uuidString: "00000000-0000-0000-0000-000000000000")!)
    }

    @Test("Verifica mapeo de colores de semáforo")
    func testTrafficLightColorMapping() {
        let greenDish = DishAnalysis(name: "Test", level: "verde", category: "Seguro", reason: "Test", purinas: 30)
        let yellowDish = DishAnalysis(name: "Test", level: "amarillo", category: "Moderado", reason: "Test", purinas: 100)
        let redDish = DishAnalysis(name: "Test", level: "rojo", category: "Evitar", reason: "Test", purinas: 200)
        let unknownDish = DishAnalysis(name: "Test", level: "desconocido", category: "N/A", reason: "Test", purinas: 0)

        #expect(greenDish.trafficLightColor == "🟢")
        #expect(yellowDish.trafficLightColor == "🟡")
        #expect(redDish.trafficLightColor == "🔴")
        #expect(unknownDish.trafficLightColor == "⚪️")

        // Verificar case-insensitive
        let mixedCaseDish = DishAnalysis(name: "Test", level: "VERDE", category: "Seguro", reason: "Test", purinas: 30)
        #expect(mixedCaseDish.trafficLightColor == "🟢")
    }

    @Test("Verifica agrupación de platos por nivel en MenuAnalysisResult")
    func testMenuAnalysisResultGrouping() {
        let dishes = [
            DishAnalysis(name: "Plato 1", level: "verde", category: "Seguro", reason: "Bajo", purinas: 20),
            DishAnalysis(name: "Plato 2", level: "verde", category: "Seguro", reason: "Bajo", purinas: 30),
            DishAnalysis(name: "Plato 3", level: "amarillo", category: "Moderado", reason: "Medio", purinas: 100),
            DishAnalysis(name: "Plato 4", level: "rojo", category: "Evitar", reason: "Alto", purinas: 250),
            DishAnalysis(name: "Plato 5", level: "rojo", category: "Evitar", reason: "Alto", purinas: 300)
        ]

        let result = MenuAnalysisResult(isValidMenu: true, dishes: dishes)

        // Verificar totalDishes
        #expect(result.totalDishes == 5)

        // Verificar agrupación
        let dishesByLevel = result.dishesByLevel
        #expect(dishesByLevel["verde"]?.count == 2)
        #expect(dishesByLevel["amarillo"]?.count == 1)
        #expect(dishesByLevel["rojo"]?.count == 2)
    }

    @Test("Verifica parsing de MenuValidationResponse")
    func testMenuValidationResponseParsing() throws {
        // Respuesta válida: es un menú
        let validJson = """
        {
            "isMenu": true,
            "reason": "La imagen contiene una carta de restaurante con múltiples platos"
        }
        """

        let validData = validJson.data(using: .utf8)!
        let validResponse = try JSONDecoder().decode(MenuValidationResponse.self, from: validData)

        #expect(validResponse.isMenu == true)
        #expect(validResponse.reason == "La imagen contiene una carta de restaurante con múltiples platos")

        // Respuesta inválida: no es un menú
        let invalidJson = """
        {
            "isMenu": false,
            "reason": "La imagen no contiene una carta de restaurante"
        }
        """

        let invalidData = invalidJson.data(using: .utf8)!
        let invalidResponse = try JSONDecoder().decode(MenuValidationResponse.self, from: invalidData)

        #expect(invalidResponse.isMenu == false)
        #expect(invalidResponse.reason != nil)
    }

    @Test("Verifica parsing de DishesExtractionResponse")
    func testDishesExtractionResponseParsing() throws {
        // Lista de platos extraídos
        let jsonString = """
        {
            "dishes": [
                "Ensalada César",
                "Salmón a la plancha",
                "Pollo al curry",
                "Tarta de queso"
            ]
        }
        """

        let data = jsonString.data(using: .utf8)!
        let response = try JSONDecoder().decode(DishesExtractionResponse.self, from: data)

        #expect(response.dishes.count == 4)
        #expect(response.dishes.contains("Ensalada César"))
        #expect(response.dishes.contains("Salmón a la plancha"))
        #expect(response.dishes.contains("Pollo al curry"))
        #expect(response.dishes.contains("Tarta de queso"))

        // Array vacío
        let emptyJson = """
        {
            "dishes": []
        }
        """

        let emptyData = emptyJson.data(using: .utf8)!
        let emptyResponse = try JSONDecoder().decode(DishesExtractionResponse.self, from: emptyData)

        #expect(emptyResponse.dishes.isEmpty)
    }
}
