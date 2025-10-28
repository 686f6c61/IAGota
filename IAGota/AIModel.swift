//
//  AIModel.swift
//  IAGota
//
//  Gestión de modelos de IA disponibles en OpenRouter
//

import Foundation
import Combine

// MARK: - AIModel

/// Representa un modelo de IA disponible para consultas
struct AIModel: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let isFree: Bool // true si el modelo no tiene coste por uso
    let speed: String // "rápido", "medio", "lento"
    let infoURL: String // URL con información del modelo en OpenRouter

    var displayName: String {
        return name
    }
}

// MARK: - ModelManager

/// Gestiona la selección y persistencia del modelo de IA
class ModelManager: ObservableObject {
    @Published var selectedModel: AIModel

    private let userDefaultsKey = "selectedAIModel"

    // MARK: - Available Models
    static let availableModels: [AIModel] = [
        // GPT-4o-mini es el modelo predeterminado (más económico)
        AIModel(
            id: "openai/gpt-4o-mini",
            name: "GPT-4o Mini",
            description: "Rápido y económico (~$0.006/consulta) - Predeterminado",
            isFree: false,
            speed: "rápido",
            infoURL: "https://openrouter.ai/openai/gpt-4o-mini"
        ),
        // GPT-4o para mayor precisión
        AIModel(
            id: "openai/chatgpt-4o-latest",
            name: "GPT-4o",
            description: "Más preciso (~$0.10/consulta)",
            isFree: false,
            speed: "medio",
            infoURL: "https://openrouter.ai/openai/chatgpt-4o-latest"
        )
    ]

    // MARK: - Initialization

    init() {
        // Cargar modelo guardado o usar el primero por defecto
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedModel = try? JSONDecoder().decode(AIModel.self, from: savedData) {
            self.selectedModel = savedModel
        } else {
            self.selectedModel = ModelManager.availableModels[0]
        }
    }

    // MARK: - Model Management

    /// Guarda el modelo seleccionado en UserDefaults
    func saveModel(_ model: AIModel) {
        self.selectedModel = model
        if let encoded = try? JSONEncoder().encode(model) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }

    // MARK: - Computed Properties

    /// Obtener el modelo predeterminado (GPT-4o-mini)
    static var defaultModel: AIModel {
        return availableModels[0]
    }

    /// Obtener el modelo más preciso (GPT-4o)
    static var preciseModel: AIModel {
        return availableModels[1]
    }
}
