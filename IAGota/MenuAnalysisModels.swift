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

    // MARK: - Campos extendidos v1.2.0
    let score: Int?
    let alternativas: [Alternativa]?
    let contextoTemporal: String?
    let consejoPreparacion: String?
    let factoresMetabolicos: String?
    let infoNutricional: InfoNutricional?

    init(id: UUID = UUID(), name: String, level: String, category: String, reason: String, purinas: Int, score: Int? = nil, alternativas: [Alternativa]? = nil, contextoTemporal: String? = nil, consejoPreparacion: String? = nil, factoresMetabolicos: String? = nil, infoNutricional: InfoNutricional? = nil) {
        self.id = id
        self.name = name
        self.level = level
        self.category = category
        self.reason = reason
        self.purinas = purinas
        self.score = score
        self.alternativas = alternativas
        self.contextoTemporal = contextoTemporal
        self.consejoPreparacion = consejoPreparacion
        self.factoresMetabolicos = factoresMetabolicos
        self.infoNutricional = infoNutricional
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

    /// Número de alternativas disponibles
    var alternativasCount: Int {
        alternativas?.count ?? 0
    }

    /// Tiene información extendida disponible
    var hasExtendedInfo: Bool {
        score != nil || alternativas != nil || contextoTemporal != nil || consejoPreparacion != nil || factoresMetabolicos != nil || infoNutricional != nil
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
