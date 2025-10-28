//
//  MenuAnalysisView.swift
//  IAGota
//
//  Vista para mostrar resultados del análisis de carta
//

import SwiftUI

struct MenuAnalysisView: View {
    let result: MenuAnalysisResult
    let onAnalyzeAnother: () -> Void

    @State private var selectedDish: DishAnalysis? = nil

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                headerSection

                // Lista de platos
                dishesSection

                // Botón para analizar otra carta
                Button {
                    onAnalyzeAnother()
                } label: {
                    Label("Analizar otra carta", systemImage: "camera.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .padding(.vertical)
        }
        .sheet(item: $selectedDish) { dish in
            DishDetailModal(dish: dish)
        }
    }

    // MARK: - Header Section

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title2)
                Text("\(result.totalDishes) platos encontrados")
                    .font(.title3)
                    .fontWeight(.bold)
            }

            Text("Toca un plato para ver más detalles")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }

    // MARK: - Dishes Section

    private var dishesSection: some View {
        VStack(spacing: 12) {
            ForEach(result.dishes) { dish in
                DishRow(dish: dish)
                    .onTapGesture {
                        selectedDish = dish
                    }
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Dish Row

struct DishRow: View {
    let dish: DishAnalysis

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Semáforo
            Text(dish.trafficLightColor)
                .font(.title)

            // Info del plato
            VStack(alignment: .leading, spacing: 4) {
                Text(dish.name)
                    .font(.headline)
                    .foregroundColor(.primary)

                HStack {
                    Text("\(dish.purinas) mg/100g")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(levelColor(dish.level))

                    Text("•")
                        .foregroundColor(.secondary)

                    Text(dish.category)
                        .font(.subheadline)
                        .foregroundColor(levelColor(dish.level))
                }
            }

            Spacer()

            // Icono de flecha
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }

    private func levelColor(_ level: String) -> Color {
        switch level.lowercased() {
        case "verde": return .green
        case "amarillo": return .orange
        case "rojo": return .red
        default: return .gray
        }
    }
}

// MARK: - Dish Detail Modal

struct DishDetailModal: View {
    let dish: DishAnalysis
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Semáforo grande
                    Text(dish.trafficLightColor)
                        .font(.system(size: 80))

                    // Nombre del plato
                    Text(dish.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    // Categoría
                    Text(dish.category.uppercased())
                        .font(.headline)
                        .foregroundColor(levelColor(dish.level))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(levelColor(dish.level).opacity(0.1))
                        .cornerRadius(20)

                    Divider()
                        .padding(.horizontal)

                    // Contenido de purinas
                    VStack(spacing: 10) {
                        Text("Contenido de purinas:")
                            .font(.headline)
                            .foregroundColor(.secondary)

                        HStack(alignment: .firstTextBaseline, spacing: 5) {
                            Text("\(dish.purinas)")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(levelColor(dish.level))

                            Text("mg/100g")
                                .font(.title3)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 10)

                    Divider()
                        .padding(.horizontal)

                    // Explicación
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Explicación:")
                            .font(.headline)

                        Text(dish.reason)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal)

                    // Aviso médico
                    HStack(spacing: 8) {
                        Image(systemName: "stethoscope")
                            .foregroundColor(.blue)
                        Text("Consulta siempre a tu médico")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 10)

                    Spacer()
                }
                .padding(.vertical, 30)
            }
            .navigationTitle("Detalle")
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

    private func levelColor(_ level: String) -> Color {
        switch level.lowercased() {
        case "verde": return .green
        case "amarillo": return .orange
        case "rojo": return .red
        default: return .gray
        }
    }
}

#Preview {
    MenuAnalysisView(
        result: MenuAnalysisResult(
            isValidMenu: true,
            errorMessage: nil,
            dishes: [
                DishAnalysis(
                    name: "Ensalada mixta",
                    level: "verde",
                    category: "Seguro",
                    reason: "Las verduras tienen bajo contenido de purinas",
                    purinas: 12
                ),
                DishAnalysis(
                    name: "Pollo a la plancha",
                    level: "amarillo",
                    category: "Moderado",
                    reason: "El pollo tiene contenido moderado de purinas",
                    purinas: 110
                ),
                DishAnalysis(
                    name: "Anchoas en vinagre",
                    level: "rojo",
                    category: "Evitar",
                    reason: "Las anchoas son pescado azul con alto contenido de purinas",
                    purinas: 410
                )
            ]
        ),
        onAnalyzeAnother: {}
    )
}
