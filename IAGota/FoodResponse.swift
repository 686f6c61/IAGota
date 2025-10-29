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

    // MARK: - Campos opcionales extendidos

    /// Score de seguridad de 0 a 100 (100 = más seguro)
    let score: Int?
    /// Alternativas más seguras (solo para nivel amarillo/rojo)
    let alternativas: [Alternativa]?
    /// Contexto sobre frecuencia de consumo segura
    let contextoTemporal: String?
    /// Consejos de preparación para reducir purinas (solo si aplica)
    let consejoPreparacion: String?
    /// Factores metabólicos especiales relacionados con ácido úrico
    let factoresMetabolicos: String?
    /// Información nutricional complementaria relevante
    let infoNutricional: InfoNutricional?
}

// MARK: - Alternativa

/// Alternativa alimentaria más segura
struct Alternativa: Codable, Equatable {
    /// Nombre del alimento alternativo
    let nombre: String
    /// Contenido de purinas en mg/100g
    let purinas: Int
    /// Nivel: "verde", "amarillo", "rojo"
    let nivel: String
}

// MARK: - InfoNutricional

/// Información nutricional relevante para el manejo del ácido úrico
struct InfoNutricional: Codable, Equatable {
    /// Proteínas en gramos por 100g
    let proteinas: Double?
    /// Fructosa en gramos por 100g (relevante: aumenta ácido úrico)
    let fructosa: Double?
    /// Vitamina C en miligramos por 100g (relevante: ayuda a reducir ácido úrico)
    let vitaminaC: Double?
    /// Contenido de Omega-3: "alto", "medio", "bajo", o nil
    let omega3: String?
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
