//
//  FoodResponseComponents.swift
//  IAGota
//
//  Componentes de UI para mostrar información extendida de alimentos
//

import SwiftUI

// MARK: - ScoreView

/// Muestra el score de seguridad de 0 a 100 con diseño diferente al semáforo
struct ScoreView: View {
    let score: Int
    let nivel: String
    @State private var showInfoSheet: Bool = false

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: "chart.bar.fill")
                    .font(.title3)
                    .foregroundColor(.blue)
                Text("Índice de seguridad")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }

            // Número grande con estilo diferente
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("\(score)")
                    .font(.system(size: 48, weight: .heavy, design: .rounded))
                    .foregroundColor(colorForScore(score))
                Text("/ 100")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }

            // Barra de progreso con gradiente
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Fondo
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 12)

                    // Progreso con gradiente
                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            LinearGradient(
                                gradient: gradientForScore(score),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * CGFloat(score) / 100.0, height: 12)
                }
            }
            .frame(height: 12)

            // Etiqueta descriptiva con botón de información
            HStack(spacing: 6) {
                Text(descriptionForScore(score))
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(colorForScore(score))

                Button {
                    showInfoSheet = true
                } label: {
                    Image(systemName: "info.circle.fill")
                        .font(.caption)
                        .foregroundColor(.blue.opacity(0.6))
                }
            }
        }
        .padding()
        .background(Color.blue.opacity(0.05))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue.opacity(0.2), lineWidth: 1.5)
        )
        .sheet(isPresented: $showInfoSheet) {
            ScoreInfoSheet()
        }
    }

    // Usa colores diferentes al semáforo: azul-púrpura-naranja
    private func colorForScore(_ score: Int) -> Color {
        if score >= 75 {
            return Color.blue
        } else if score >= 50 {
            return Color.purple
        } else if score >= 25 {
            return Color.orange
        } else {
            return Color.pink
        }
    }

    private func gradientForScore(_ score: Int) -> Gradient {
        if score >= 75 {
            return Gradient(colors: [Color.cyan, Color.blue])
        } else if score >= 50 {
            return Gradient(colors: [Color.blue, Color.purple])
        } else if score >= 25 {
            return Gradient(colors: [Color.purple, Color.orange])
        } else {
            return Gradient(colors: [Color.orange, Color.pink])
        }
    }

    private func descriptionForScore(_ score: Int) -> String {
        if score >= 75 {
            return "Muy seguro para el control de purinas"
        } else if score >= 50 {
            return "Moderadamente seguro"
        } else if score >= 25 {
            return "Consumir con precaución"
        } else {
            return "Bajo índice de seguridad"
        }
    }
}

// MARK: - ScoreInfoSheet

/// Sheet informativo que explica los niveles del índice de seguridad
struct ScoreInfoSheet: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Encabezado
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "chart.bar.fill")
                                .font(.title)
                                .foregroundColor(.blue)

                            Text("Índice de seguridad")
                                .font(.title2)
                                .fontWeight(.bold)
                        }

                        Text("El índice de seguridad es una puntuación de 0 a 100 que indica qué tan seguro es un alimento para personas que controlan sus niveles de purinas.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.bottom, 8)

                    Divider()

                    // Niveles explicados
                    VStack(spacing: 20) {
                        ScoreInfoRow(
                            range: "75 - 100",
                            color: .blue,
                            gradient: Gradient(colors: [.cyan, .blue]),
                            title: "Muy seguro",
                            description: "Alimentos con bajo contenido de purinas (< 50 mg/100g) y sin factores metabólicos adversos. Aptos para consumo regular en una dieta de control de ácido úrico."
                        )

                        ScoreInfoRow(
                            range: "50 - 74",
                            color: .purple,
                            gradient: Gradient(colors: [.blue, .purple]),
                            title: "Moderadamente seguro",
                            description: "Alimentos con contenido moderado de purinas (50-150 mg/100g). Se pueden consumir ocasionalmente como parte de una dieta equilibrada, especialmente si el resto de comidas del día son bajas en purinas."
                        )

                        ScoreInfoRow(
                            range: "25 - 49",
                            color: .orange,
                            gradient: Gradient(colors: [.purple, .orange]),
                            title: "Consumir con precaución",
                            description: "Alimentos con alto contenido de purinas (> 150 mg/100g) o con factores metabólicos que pueden afectar los niveles de ácido úrico. Se recomienda limitar su consumo a ocasiones especiales."
                        )

                        ScoreInfoRow(
                            range: "0 - 24",
                            color: .pink,
                            gradient: Gradient(colors: [.orange, .pink]),
                            title: "Bajo índice de seguridad",
                            description: "Alimentos con muy alto contenido de purinas y/o efectos metabólicos significativos sobre el ácido úrico. Considerar alternativas más seguras para mantener buenos hábitos alimenticios."
                        )
                    }

                    Divider()

                    // Nota final
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Image(systemName: "lightbulb.fill")
                                .foregroundColor(.yellow)
                            Text("¿Cómo se calcula?")
                                .font(.headline)
                        }

                        Text("El índice se calcula considerando:\n• Contenido de purinas (70%)\n• Factores metabólicos especiales (20%)\n• Beneficios nutricionales relevantes (10%)")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(12)

                    // Disclaimer
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                            .font(.caption)
                        Text("Esta es información educativa nutricional. Consulta siempre a tu médico para obtener asesoramiento personalizado.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle("Información")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - ScoreInfoRow

/// Fila individual que explica cada nivel del score
struct ScoreInfoRow: View {
    let range: String
    let color: Color
    let gradient: Gradient
    let title: String
    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                // Barra con gradiente
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        LinearGradient(
                            gradient: gradient,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 60, height: 8)

                Text(range)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)

                Spacer()
            }

            Text(title)
                .font(.headline)
                .foregroundColor(color)

            Text(description)
                .font(.body)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(color.opacity(0.08))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
}

// MARK: - AlternativasView

/// Muestra alternativas más seguras (solo para amarillo/rojo)
struct AlternativasView: View {
    let alternativas: [Alternativa]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.title3)
                    .foregroundColor(.blue)
                Text("Alternativas más seguras")
                    .font(.headline)
                    .foregroundColor(.primary)
            }

            VStack(alignment: .leading, spacing: 10) {
                ForEach(alternativas, id: \.nombre) { alternativa in
                    HStack {
                        // Icono de nivel
                        Circle()
                            .fill(colorForNivel(alternativa.nivel))
                            .frame(width: 12, height: 12)

                        Text(alternativa.nombre)
                            .font(.body)
                            .foregroundColor(.primary)

                        Spacer()

                        Text("\(alternativa.purinas) mg")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(6)
                    }
                }
            }
        }
        .padding()
        .background(Color.blue.opacity(0.05))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
        )
    }

    private func colorForNivel(_ nivel: String) -> Color {
        switch nivel.lowercased() {
        case "verde":
            return .green
        case "amarillo":
            return .yellow
        case "rojo":
            return .red
        default:
            return .gray
        }
    }
}

// MARK: - ContextoTemporalView

/// Muestra el contexto temporal de consumo
struct ContextoTemporalView: View {
    let contexto: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "clock.fill")
                .font(.title3)
                .foregroundColor(.orange)

            Text(contexto)
                .font(.body)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - ConsejoPreparacionView

/// Muestra consejos de preparación (colapsable)
struct ConsejoPreparacionView: View {
    let consejo: String
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            // Botón para expandir/colapsar
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))

                    Image(systemName: "fork.knife")
                        .font(.body)
                        .foregroundColor(.blue)

                    Text("Ver consejo de preparación")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)

                    Spacer()
                }
                .padding()
                .background(Color.blue.opacity(0.05))
                .cornerRadius(12)
            }

            // Contenido expandible
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    Divider()
                        .padding(.horizontal)

                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "lightbulb.fill")
                            .font(.title3)
                            .foregroundColor(.yellow)

                        Text(consejo)
                            .font(.body)
                            .foregroundColor(.primary)
                            .fixedSize(horizontal: false, vertical: true)

                        Spacer()
                    }
                    .padding()
                }
                .background(Color.blue.opacity(0.05))
                .cornerRadius(12)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}

// MARK: - FactoresMetabolicosView

/// Muestra factores metabólicos especiales
struct FactoresMetabolicosView: View {
    let factores: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.title3)
                .foregroundColor(.orange)

            VStack(alignment: .leading, spacing: 4) {
                Text("Nota importante")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Text(factores)
                    .font(.body)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.orange.opacity(0.3), lineWidth: 1)
        )
    }
}

// MARK: - InfoNutricionalView

/// Muestra información nutricional complementaria
struct InfoNutricionalView: View {
    let info: InfoNutricional

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: "list.bullet.clipboard.fill")
                    .font(.title3)
                    .foregroundColor(.green)
                Text("Información nutricional relevante")
                    .font(.headline)
                    .foregroundColor(.primary)
            }

            VStack(alignment: .leading, spacing: 8) {
                if let proteinas = info.proteinas {
                    InfoRow(icon: "p.circle.fill", label: "Proteínas", value: "\(String(format: "%.1f", proteinas))g / 100g", color: .blue, showIndicator: false)
                }

                if let fructosa = info.fructosa {
                    InfoRow(icon: "f.circle.fill", label: "Fructosa", value: "\(String(format: "%.1f", fructosa))g / 100g", color: .orange, showIndicator: fructosa > 5, indicatorIcon: "arrow.up.circle.fill")
                }

                if let vitaminaC = info.vitaminaC {
                    InfoRow(icon: "c.circle.fill", label: "Vitamina C", value: "\(String(format: "%.0f", vitaminaC))mg / 100g", color: .green, showIndicator: vitaminaC > 30, indicatorIcon: "checkmark.circle.fill")
                }

                if let omega3 = info.omega3 {
                    InfoRow(icon: "3.circle.fill", label: "Omega-3", value: omega3.capitalized, color: .cyan, showIndicator: omega3.lowercased() == "alto", indicatorIcon: "checkmark.circle.fill")
                }
            }
        }
        .padding()
        .background(Color.green.opacity(0.05))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.green.opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - InfoRow

/// Fila individual de información nutricional
struct InfoRow: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    let showIndicator: Bool
    let indicatorIcon: String

    init(icon: String, label: String, value: String, color: Color, showIndicator: Bool = false, indicatorIcon: String = "") {
        self.icon = icon
        self.label = label
        self.value = value
        self.color = color
        self.showIndicator = showIndicator
        self.indicatorIcon = indicatorIcon
    }

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)

            Text(label)
                .font(.body)
                .foregroundColor(.primary)

            Spacer()

            if showIndicator && !indicatorIcon.isEmpty {
                Image(systemName: indicatorIcon)
                    .font(.caption)
                    .foregroundColor(color)
            }

            Text(value)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview

#Preview {
    ScrollView {
        VStack(spacing: 20) {
            ScoreView(score: 85, nivel: "verde")

            AlternativasView(alternativas: [
                Alternativa(nombre: "Pollo sin piel", purinas: 110, nivel: "amarillo"),
                Alternativa(nombre: "Pescado blanco", purinas: 70, nivel: "verde"),
                Alternativa(nombre: "Lentejas", purinas: 75, nivel: "amarillo")
            ])

            ContextoTemporalView(contexto: "Consumir máximo 1 vez por semana si el resto de la dieta es baja en purinas")

            ConsejoPreparacionView(consejo: "Hervir este alimento reduce sus purinas en 30-50%. Prefiere cocción en agua y descarta el caldo.")

            FactoresMetabolicosView(factores: "La cerveza inhibe la excreción de ácido úrico, aumentando los niveles en sangre independientemente de su contenido de purinas.")

            InfoNutricionalView(info: InfoNutricional(
                proteinas: 25.0,
                fructosa: 8.0,
                vitaminaC: 50.0,
                omega3: "alto"
            ))
        }
        .padding()
    }
}
