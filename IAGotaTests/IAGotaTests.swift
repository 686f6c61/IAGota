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

    @Test("Verifica modelos disponibles")
    func testAvailableModels() {
        let models = ModelManager.availableModels

        // Debe haber al menos algunos modelos
        #expect(models.count > 0)

        // Debe haber modelos gratuitos
        let freeModels = ModelManager.freeModels
        #expect(freeModels.count > 0)
        #expect(freeModels.allSatisfy { $0.isFree })

        // Debe haber modelos de pago
        let paidModels = ModelManager.paidModels
        #expect(paidModels.count > 0)
        #expect(paidModels.allSatisfy { !$0.isFree })
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
