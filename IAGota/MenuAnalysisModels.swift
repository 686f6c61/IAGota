//
//  MenuAnalysisModels.swift
//  IAGota
//
//  Modelos de datos para análisis de cartas por foto
//

import Foundation

// MARK: - DishAnalysis

/// Representa el análisis de un plato individual de la carta
struct DishAnalysis: Identifiable, Codable {
    let id: UUID
    let name: String
    let level: String // "verde", "amarillo", "rojo"
    let category: String // "Seguro", "Moderado", "Evitar"
    let reason: String
    let purinas: Int // mg/100g

    init(id: UUID = UUID(), name: String, level: String, category: String, reason: String, purinas: Int) {
        self.id = id
        self.name = name
        self.level = level
        self.category = category
        self.reason = reason
        self.purinas = purinas
    }

    /// Color del semáforo según el nivel
    var trafficLightColor: String {
        switch level.lowercased() {
        case "verde": return "🟢"
        case "amarillo": return "🟡"
        case "rojo": return "🔴"
        default: return "⚪️"
        }
    }
}

// MARK: - MenuAnalysisResult

/// Resultado completo del análisis de una carta
struct MenuAnalysisResult: Codable {
    let isValidMenu: Bool
    let errorMessage: String?
    let dishes: [DishAnalysis]

    init(isValidMenu: Bool, errorMessage: String? = nil, dishes: [DishAnalysis] = []) {
        self.isValidMenu = isValidMenu
        self.errorMessage = errorMessage
        self.dishes = dishes
    }

    /// Resultados agrupados por nivel
    var dishesByLevel: [String: [DishAnalysis]] {
        Dictionary(grouping: dishes) { $0.level }
    }

    /// Total de platos analizados
    var totalDishes: Int {
        dishes.count
    }
}

// MARK: - MenuValidationResponse (respuesta de IA)

/// Respuesta de la IA al validar si es una carta
struct MenuValidationResponse: Codable {
    let isMenu: Bool
    let reason: String?
}

// MARK: - DishesExtractionResponse (respuesta de IA)

/// Respuesta de la IA al extraer platos
struct DishesExtractionResponse: Codable {
    let dishes: [String] // Lista de nombres de platos
}
