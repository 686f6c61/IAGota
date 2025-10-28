//
//  ModelSelectionView.swift
//  IAGota
//
//  SPARRING
//

import SwiftUI

struct ModelSelectionView: View {
    @ObservedObject var modelManager: ModelManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            // Todos los modelos (solo GPT-4o y GPT-4o-mini)
            Section(header: HStack {
                Image(systemName: "cpu")
                    .foregroundColor(.blue)
                Text("Modelos de OpenAI")
            }) {
                ForEach(ModelManager.availableModels) { model in
                    ModelRow(
                        model: model,
                        isSelected: modelManager.selectedModel.id == model.id,
                        action: {
                            modelManager.saveModel(model)
                            dismiss()
                        },
                        onInfoTap: {
                            if let url = URL(string: model.infoURL) {
                                UIApplication.shared.open(url)
                            }
                        }
                    )
                }

                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption2)
                            .foregroundColor(.green)
                        Text("GPT-4o-mini: Rápido y muy económico (~$0.006/consulta)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption2)
                            .foregroundColor(.blue)
                        Text("GPT-4o: Máxima precisión (~$0.10/consulta)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "key.fill")
                            .font(.caption2)
                            .foregroundColor(.orange)
                        Text("Requieren API key con créditos en OpenRouter")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 4)
            }
        }
        .navigationTitle("Seleccionar Modelo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ModelRow: View {
    let model: AIModel
    let isSelected: Bool
    let action: () -> Void
    let onInfoTap: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            Button(action: action) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(model.name)
                            .font(.headline)
                            .foregroundColor(.primary)

                        Text(model.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        HStack(spacing: 4) {
                            Image(systemName: speedIcon(for: model.speed))
                                .font(.caption2)
                                .foregroundColor(.blue)
                            Text("Velocidad: \(model.speed)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }

                    Spacer()

                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            // Botón de información separado
            Button(action: { onInfoTap() }) {
                Image(systemName: "info.circle")
                    .font(.title3)
                    .foregroundColor(.blue)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
    }

    private func speedIcon(for speed: String) -> String {
        switch speed {
        case "rápido":
            return "hare.fill"
        case "medio":
            return "tortoise.fill"
        case "lento":
            return "moon.fill"
        default:
            return "circle.fill"
        }
    }
}

#Preview {
    NavigationView {
        ModelSelectionView(modelManager: ModelManager())
    }
}
