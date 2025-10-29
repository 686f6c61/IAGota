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
    @State private var selectedFilter: FilterOption = .all
    @State private var selectedSort: SortOption = .byScore

    enum FilterOption: String, CaseIterable {
        case all = "Todos"
        case verde = "Verde"
        case amarillo = "Amarillo"
        case rojo = "Rojo"
    }

    enum SortOption: String, CaseIterable {
        case byScore = "Por Score"
        case byPurinas = "Por Purinas"
        case byName = "Por Nombre"
    }

    // Computed property for filtered and sorted dishes
    var filteredAndSortedDishes: [DishAnalysis] {
        var dishes = result.dishes

        // Apply filter
        if selectedFilter != .all {
            dishes = dishes.filter { $0.level.lowercased() == selectedFilter.rawValue.lowercased() }
        }

        // Apply sort
        switch selectedSort {
        case .byScore:
            dishes.sort { ($0.score ?? 0) > ($1.score ?? 0) }
        case .byPurinas:
            dishes.sort { $0.purinas < $1.purinas }
        case .byName:
            dishes.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        }

        return dishes
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                headerSection

                // Filters and Sort
                filterAndSortSection

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

    // MARK: - Filter and Sort Section

    private var filterAndSortSection: some View {
        VStack(spacing: 12) {
            // Filter buttons
            HStack(spacing: 8) {
                Text("Filtrar:")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)

                ForEach(FilterOption.allCases, id: \.self) { option in
                    Button {
                        selectedFilter = option
                    } label: {
                        HStack(spacing: 4) {
                            if option != .all {
                                Text(filterEmoji(for: option))
                            }
                            Text(option.rawValue)
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(selectedFilter == option ? Color.blue : Color(.systemGray5))
                        .foregroundColor(selectedFilter == option ? .white : .primary)
                        .cornerRadius(8)
                    }
                }
            }

            // Sort picker
            HStack {
                Text("Ordenar:")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)

                Picker("Ordenar", selection: $selectedSort) {
                    ForEach(SortOption.allCases, id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        .padding(.horizontal)
    }

    private func filterEmoji(for option: FilterOption) -> String {
        switch option {
        case .verde: return "🟢"
        case .amarillo: return "🟡"
        case .rojo: return "🔴"
        case .all: return ""
        }
    }

    // MARK: - Dishes Section

    private var dishesSection: some View {
        VStack(spacing: 12) {
            ForEach(filteredAndSortedDishes) { dish in
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
            VStack(alignment: .leading, spacing: 6) {
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

                // Score (v1.2.0)
                if let score = dish.score {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.blue)
                        Text("\(score)/100")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                }

                // Indicador de alternativas
                if dish.alternativasCount > 0 {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.caption)
                            .foregroundColor(.orange)
                        Text("Ver \(dish.alternativasCount) alternativas")
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
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
                VStack(spacing: 20) {
                    // Header: Semáforo grande + Nombre + Categoría
                    VStack(spacing: 15) {
                        Text(dish.trafficLightColor)
                            .font(.system(size: 80))

                        Text(dish.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)

                        Text(dish.category.uppercased())
                            .font(.headline)
                            .foregroundColor(levelColor(dish.level))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(levelColor(dish.level).opacity(0.1))
                            .cornerRadius(20)
                    }
                    .padding(.vertical, 10)

                    // Score (v1.2.0)
                    if let score = dish.score {
                        ScoreView(score: score, nivel: dish.level)
                            .padding(.horizontal)
                    }

                    // Contenido de purinas con barra
                    VStack(spacing: 8) {
                        HStack(spacing: 6) {
                            Image(systemName: "drop.fill")
                                .font(.title3)
                                .foregroundColor(levelColor(dish.level))
                            Text("Contenido de purinas")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }

                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("\(dish.purinas)")
                                .font(.system(size: 42, weight: .bold, design: .rounded))
                                .foregroundColor(levelColor(dish.level))
                            Text("mg")
                                .font(.title3)
                                .foregroundColor(.secondary)
                            Text("/ 100g")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        // Indicador visual de nivel
                        PurinasBar(value: dish.purinas, nivel: dish.level)
                    }
                    .padding()
                    .background(levelColor(dish.level).opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Explicación
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Explicación:")
                            .font(.headline)
                            .foregroundColor(.primary)

                        Text(dish.reason)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                    // Alternativas (v1.2.0)
                    if let alternativas = dish.alternativas, !alternativas.isEmpty {
                        AlternativasView(alternativas: alternativas)
                            .padding(.horizontal)
                    }

                    // Contexto temporal (v1.2.0)
                    if let contextoTemporal = dish.contextoTemporal {
                        ContextoTemporalView(contexto: contextoTemporal)
                            .padding(.horizontal)
                    }

                    // Información nutricional (v1.2.0)
                    if let infoNutricional = dish.infoNutricional {
                        InfoNutricionalView(info: infoNutricional)
                            .padding(.horizontal)
                    }

                    // Factores metabólicos (v1.2.0)
                    if let factoresMetabolicos = dish.factoresMetabolicos {
                        FactoresMetabolicosView(factores: factoresMetabolicos)
                            .padding(.horizontal)
                    }

                    // Consejo de preparación (v1.2.0)
                    if let consejoPreparacion = dish.consejoPreparacion {
                        ConsejoPreparacionView(consejo: consejoPreparacion)
                            .padding(.horizontal)
                    }

                    // Aviso médico
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                        Text("Consulta siempre a tu médico")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    Spacer().frame(height: 20)
                }
                .padding(.vertical, 20)
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
