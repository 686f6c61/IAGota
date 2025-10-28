//
//  FoodResponse.swift
//  IAGota
//
//  Modelos de datos para respuestas de la API
//

import Foundation

// MARK: - FoodResponse

/// Respuesta estructurada del análisis de un alimento
struct FoodResponse: Codable, Equatable {
    /// Nivel de riesgo: "verde", "amarillo", "rojo"
    let nivel: String
    /// Categoría legible: "Seguro", "Moderado", "Evitar"
    let categoria: String
    /// Explicación del porqué de la categorización
    let razon: String
    /// Contenido de purinas en miligramos por cada 100 gramos
    let purinas: Int
}

// MARK: - OpenRouterResponse

/// Respuesta raw de la API de OpenRouter
struct OpenRouterResponse: Codable {
    let choices: [Choice]

    struct Choice: Codable {
        let message: Message
    }

    struct Message: Codable {
        let content: String
    }
}
