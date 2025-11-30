//
//  SettingsView.swift
//  IAGota
//
//  Vista de configuración para API key y selección de modelo de IA
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties

    @ObservedObject var apiKeyManager: APIKeyManager
    @ObservedObject var modelManager: ModelManager
    @State private var newAPIKey: String = ""
    @State private var showSuccessMessage: Bool = false
    @Environment(\.dismiss) private var dismiss

    // MARK: - Body

    var body: some View {
        NavigationView {
            Form {
                Section {
                    if apiKeyManager.hasAPIKey() {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("API Key configurada")
                                    .foregroundColor(.green)
                            }
                            .font(.caption)

                            Text(maskedAPIKey(apiKeyManager.apiKey))
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.secondary)
                                .padding(.top, 2)
                        }
                    } else {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                            Text("No tienes API Key configurada")
                                .foregroundColor(.orange)
                        }
                        .font(.caption)
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Cambiar API Key:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        TextField("sk-or-v1-...", text: $newAPIKey)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .font(.system(.body, design: .monospaced))
                            .textFieldStyle(.roundedBorder)

                        HStack(spacing: 4) {
                            Image(systemName: "info.circle.fill")
                                .font(.caption2)
                                .foregroundColor(.blue)
                            Text("Opcional: Puedes cambiar tu API key aquí")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }

                    Button {
                        saveAPIKey()
                    } label: {
                        Text("Guardar Nueva API Key")
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(newAPIKey.isEmpty)

                    if showSuccessMessage {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.caption)
                                .foregroundColor(.green)
                            Text("API Key guardada correctamente")
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                    }
                } header: {
                    Text("API Key de OpenRouter")
                }

                // Sección de eliminar API key
                if apiKeyManager.hasAPIKey() {
                    Section(header: Text("Zona de peligro")) {
                        Button(role: .destructive) {
                            resetKey()
                        } label: {
                            HStack {
                                Image(systemName: "trash.fill")
                                Text("Eliminar API Key")
                            }
                            .frame(maxWidth: .infinity)
                        }

                        Text("Esto eliminará tu API key y no podrás hacer consultas hasta que configures una nueva")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }

                // Selector de modelo de IA
                Section(header: Text("Modelo de IA")) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "cpu")
                                .foregroundColor(.blue)
                            Text("Modelo actual:")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Text(modelManager.selectedModel.displayName)
                            .font(.headline)

                        Text(modelManager.selectedModel.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    NavigationLink("Cambiar modelo") {
                        ModelSelectionView(modelManager: modelManager)
                    }
                }

                Section {
                    NavigationLink("¿Cómo obtener mi API Key?") {
                        HowToGetAPIKeyView()
                    }
                } header: {
                    Text("Información")
                } footer: {
                    Text("La API key se almacena de forma segura en tu dispositivo y solo se usa para consultas a OpenRouter.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Configuración")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cerrar")
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }

    // MARK: - Private Methods

    /// Guarda la nueva API key ingresada por el usuario
    private func saveAPIKey() {
        guard apiKeyManager.isValidAPIKey(newAPIKey) else {
            return
        }

        apiKeyManager.saveAPIKey(newAPIKey)
        newAPIKey = ""
        showSuccessMessage = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showSuccessMessage = false
        }
    }

    /// Elimina la API key configurada
    private func resetKey() {
        apiKeyManager.resetAPIKey()
        newAPIKey = ""
        showSuccessMessage = false
    }

    /// Muestra la API key parcialmente oculta (primeros 12 + últimos 4 caracteres)
    private func maskedAPIKey(_ key: String) -> String {
        guard key.count > 20 else { return key }

        let prefix = String(key.prefix(12))  // Primeros 12 caracteres (ej: "sk-or-v1-90a")
        let suffix = String(key.suffix(4))   // Últimos 4 caracteres (ej: "636e")

        return "\(prefix)••••••••\(suffix)"
    }
}

#Preview {
    SettingsView(apiKeyManager: APIKeyManager(), modelManager: ModelManager())
}
