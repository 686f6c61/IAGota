//
//  HowItWorksView.swift
//  IAGota
//
//  SPARRING
//

import SwiftUI

struct HowItWorksView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Cómo Funciona")
                    .font(.title)
                    .fontWeight(.bold)

                Divider()

                // Sección 1: Modelos de IA
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 8) {
                        Image(systemName: "cpu")
                            .font(.title2)
                            .foregroundColor(.blue)
                        Text("Modelos de Inteligencia Artificial")
                            .font(.headline)
                    }

                    Text("""
                    Esta aplicación utiliza modelos de inteligencia artificial especializados en análisis nutricional de purinas.

                    El sistema está programado para proporcionar (v1.2.0+):
                    • Valores de purinas basados en literatura científica
                    • Índice de seguridad de 0 a 100 (considera purinas, factores metabólicos y beneficios nutricionales)
                    • Alternativas más seguras para alimentos amarillos/rojos
                    • Contexto temporal: frecuencia recomendada de consumo
                    • Consejos de preparación para reducir purinas (si aplica)
                    • Factores metabólicos especiales (ej: cerveza inhibe excreción)
                    • Información nutricional relevante (proteínas, fructosa, vitamina C, omega-3)

                    Los modelos disponibles para consultas de texto:
                    • GPT-4o-mini (predeterminado) - Rápido y económico
                    • GPT-4o - Más preciso
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

                // Sección 1.5: Análisis de Fotos de Cartas
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 8) {
                        Image(systemName: "camera.metering.multispot")
                            .font(.title2)
                            .foregroundColor(.green)
                        Text("Análisis de Fotos de Cartas")
                            .font(.headline)
                    }

                    Text("""
                    La app puede analizar fotos de cartas de restaurante usando modelos de IA con visión:

                    📸 MODELOS VISION:
                    • GPT-4o-mini (predeterminado) - Rápido y económico
                    • GPT-4o - Más preciso (configurable)

                    🔍 PROCESO:
                    1. Valida que la imagen sea una carta de restaurante
                    2. Extrae automáticamente los nombres de los platos (OCR)
                    3. Analiza el contenido de purinas de cada plato
                    4. Muestra resultados con semáforos 🟢🟡🔴 + valores numéricos

                    🔒 PRIVACIDAD:
                    • Las fotos NO se guardan en el dispositivo
                    • Se envían temporalmente a OpenRouter para análisis
                    • Se descartan inmediatamente después del procesamiento
                    • No se almacenan en ningún servidor
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)

                // Sección 2: Proceso
                VStack(alignment: .leading, spacing: 15) {
                    HStack(spacing: 8) {
                        Image(systemName: "gearshape.2")
                            .font(.title2)
                            .foregroundColor(.green)
                        Text("Proceso de Análisis")
                            .font(.headline)
                    }

                    ProcessStepView(
                        number: 1,
                        title: "Entrada",
                        description: "Introduces un alimento, ingrediente o plato"
                    )

                    ProcessStepView(
                        number: 2,
                        title: "Análisis Especializado",
                        description: "El modelo actúa como médico especialista, busca valores exactos de purinas en literatura médica, considera método de preparación y efectos metabólicos"
                    )

                    ProcessStepView(
                        number: 3,
                        title: "Resultado Detallado (v1.2.0+)",
                        description: "Recibes información extendida: clasificación (verde/amarillo/rojo), índice de seguridad 0-100, purinas en mg/100g, alternativas más seguras (si aplica), contexto temporal de consumo, consejos de preparación, factores metabólicos especiales e información nutricional relevante"
                    )
                }

                // Advertencia: Variabilidad
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.title2)
                            .foregroundColor(.orange)
                        Text("Los Resultados Pueden Variar")
                            .font(.headline)
                    }

                    Text("""
                    Diferentes modelos de IA pueden proporcionar respuestas ligeramente distintas para el mismo alimento debido a:

                    • Diferencias en los datos de entrenamiento
                    • Variaciones en la interpretación del modelo
                    • Actualizaciones y versiones del modelo
                    • Método de cálculo de purinas

                    Esto es normal y esperado en sistemas de IA.
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)

                // Advertencia: Precisión
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                        Text("Limitaciones de Precisión")
                            .font(.headline)
                    }

                    Text("""
                    La información proporcionada puede no ser 100% precisa porque:

                    • Los valores de purinas varían según el origen del alimento
                    • La preparación y cocción afectan el contenido
                    • Los datos nutricionales pueden estar desactualizados
                    • La IA puede cometer errores o aproximaciones
                    • No considera tu situación médica personal
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(10)

                // Propósito educacional
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 8) {
                        Image(systemName: "book.fill")
                            .font(.title2)
                            .foregroundColor(.purple)
                        Text("Solo Propósito Educacional")
                            .font(.headline)
                    }

                    Text("""
                    Esta aplicación está diseñada únicamente con fines educativos e informativos.

                    NO debe usarse como:
                    • Herramienta de diagnóstico médico
                    • Sustituto de consejo profesional
                    • Única fuente para decisiones dietéticas
                    • Guía definitiva sobre alimentos

                    Siempre consulta a tu médico o nutricionista antes de hacer cambios en tu dieta, especialmente si tienes gota o problemas con el ácido úrico.
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.purple.opacity(0.1))
                .cornerRadius(10)

                // Recomendación final
                HStack(spacing: 12) {
                    Image(systemName: "heart.text.square.fill")
                        .font(.title)
                        .foregroundColor(.blue)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Úsala como referencia")
                            .font(.headline)
                        Text("Complementa con información de tu médico y fuentes oficiales de nutrición")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProcessStepView: View {
    let number: Int
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 28, height: 28)
                Text("\(number)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.caption)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    NavigationView {
        HowItWorksView()
    }
}
