//
//  APIKeyManager.swift
//  IAGota
//
//  SPARRING
//

import Foundation
import Combine

class APIKeyManager: ObservableObject {
    @Published var apiKey: String = ""

    private let userDefaultsKey = "openRouterAPIKey"

    init() {
        loadAPIKey()
    }

    // MARK: - API Key Loading

    /// Cargar la API key del usuario
    /// Prioridad: 1) UserDefaults (usuario configuró), 2) Config.plist (desarrollo), 3) Vacío (producción)
    func loadAPIKey() {
        // 1. Intentar cargar la API key que el usuario guardó en Settings
        if let savedKey = UserDefaults.standard.string(forKey: userDefaultsKey), !savedKey.isEmpty {
            self.apiKey = savedKey
            return
        }

        // 2. Si no hay API key guardada, intentar cargar desde Config.plist (solo desarrollo)
        if let devKey = loadDevelopmentAPIKey(), !devKey.isEmpty {
            self.apiKey = devKey
            // NO guardar automáticamente en UserDefaults - solo usar para testing
            return
        }

        // 3. Si no existe Config.plist (producción), dejar vacío
        self.apiKey = ""
    }

    /// Lee la API key desde Config.plist si existe (solo desarrollo)
    /// - Returns: API key de desarrollo o nil si no existe el archivo
    private func loadDevelopmentAPIKey() -> String? {
        // Intentar leer Config.plist del bundle (solo existe en desarrollo)
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path),
              let apiKey = config["OpenRouterAPIKey"] as? String,
              !apiKey.isEmpty,
              apiKey != "TU_API_KEY_DE_DESARROLLO_AQUI" else {
            return nil
        }
        return apiKey
    }

    // MARK: - API Key Management

    /// Guardar la API key del usuario en UserDefaults
    func saveAPIKey(_ key: String) {
        UserDefaults.standard.set(key, forKey: userDefaultsKey)
        self.apiKey = key
    }

    /// Eliminar la API key del usuario
    func resetAPIKey() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        self.apiKey = ""
    }

    // MARK: - Validation

    /// Verificar si tiene API key configurada
    func hasAPIKey() -> Bool {
        return !apiKey.isEmpty
    }

    /// Verificar si la API key tiene formato válido de OpenRouter
    func isValidAPIKey(_ key: String) -> Bool {
        return key.hasPrefix("sk-or-v1-") && key.count > 20
    }
}
