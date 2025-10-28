//
//  ContentView.swift
//  IAGota
//
//  Created by R on 27/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var apiKeyManager = APIKeyManager()
    @StateObject private var modelManager = ModelManager()
    @State private var alimento: String = ""
    @State private var resultado: FoodResponse?
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    @State private var showSettings: Bool = false
    @State private var showPhotoMenu: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 30) {
                        // Logo o título
                        VStack(spacing: 12) {
                            Image(systemName: "heart.text.square.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.blue)

                            Text("CONSULTA DE ALIMENTOS")
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text("para el cuidado del ácido úrico")
                                .font(.title3)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 40)
                        .padding(.horizontal)

                        // Alerta si no hay API key
                        if !apiKeyManager.hasAPIKey() {
                            Button {
                                showSettings = true
                            } label: {
                                VStack(spacing: 10) {
                                    HStack {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .font(.title2)
                                            .foregroundColor(.orange)
                                        Text("Configura tu API Key")
                                            .fontWeight(.semibold)
                                    }
                                    VStack(spacing: 4) {
                                        HStack(spacing: 4) {
                                            Text("Toca aquí o el ícono")
                                            Image(systemName: "gearshape.fill")
                                            Text("arriba")
                                        }
                                        .font(.caption)
                                        .foregroundColor(.secondary)

                                        Text("La cuenta de OpenRouter es gratis")
                                            .font(.caption2)
                                            .foregroundColor(.blue)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange.opacity(0.1))
                                .cornerRadius(10)
                            }
                            .padding(.horizontal)
                        }

                        Spacer().frame(height: 20)

                // Campo de entrada
                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: "fork.knife")
                            .foregroundColor(.gray)
                            .font(.title3)

                        TextField("Ej: pizza carbonara, tomate, cerveza...", text: $alimento)
                            .font(.title3)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    Button {
                        consultar()
                    } label: {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            }
                            Text(isLoading ? "Consultando..." : "Consultar")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(alimento.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(alimento.isEmpty || isLoading)
                    .padding(.horizontal)

                    // Botón para analizar carta completa
                    Button {
                        showPhotoMenu = true
                    } label: {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("O analiza una carta completa")
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }

                // Resultado
                if let error = errorMessage {
                    VStack(spacing: 15) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.red)

                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .font(.body)
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                } else if let resultado = resultado {
                    VStack(spacing: 20) {
                        // Semáforo con icono
                        ZStack {
                            Circle()
                                .fill(colorForNivel(resultado.nivel))
                                .frame(width: 120, height: 120)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 5)
                                )
                                .shadow(color: colorForNivel(resultado.nivel).opacity(0.3), radius: 15, x: 0, y: 5)

                            Image(systemName: iconForNivel(resultado.nivel))
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }

                        // Categoría
                        Text(resultado.categoria.uppercased())
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(colorForNivel(resultado.nivel))

                        // Purinas - Información destacada
                        VStack(spacing: 8) {
                            HStack(spacing: 6) {
                                Image(systemName: "drop.fill")
                                    .font(.title3)
                                    .foregroundColor(colorForNivel(resultado.nivel))
                                Text("Contenido de purinas")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }

                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text("\(resultado.purinas)")
                                    .font(.system(size: 42, weight: .bold, design: .rounded))
                                    .foregroundColor(colorForNivel(resultado.nivel))
                                Text("mg")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                                Text("/ 100g")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            // Indicador visual de nivel
                            PurinasBar(value: resultado.purinas, nivel: resultado.nivel)
                        }
                        .padding()
                        .background(colorForNivel(resultado.nivel).opacity(0.1))
                        .cornerRadius(12)

                        // Razón
                        Text(resultado.razon)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .id("resultado") // ID para scroll automático
                }

                        Spacer().frame(height: 40)
                    }
                }
                .onChange(of: resultado) { oldValue, newValue in
                    // Scroll automático al resultado cuando aparece
                    if newValue != nil {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            proxy.scrollTo("resultado", anchor: .center)
                        }
                    }
                }
                }

                // Footer
                FooterView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView(apiKeyManager: apiKeyManager, modelManager: modelManager)
            }
            .sheet(isPresented: $showPhotoMenu) {
                PhotoMenuView()
            }
        }
    }

    // MARK: - Funciones

    private func consultar() {
        guard !alimento.isEmpty else { return }

        // Todos los modelos requieren API key de OpenRouter
        if !apiKeyManager.hasAPIKey() {
            errorMessage = "Necesitas configurar tu API Key de OpenRouter. Ve a Configuración (⚙️)"
            return
        }

        isLoading = true
        errorMessage = nil
        resultado = nil

        Task {
            do {
                let service = OpenRouterService(apiKey: apiKeyManager.apiKey, model: modelManager.selectedModel.id)
                let response = try await service.consultarAlimento(alimento)
                await MainActor.run {
                    self.resultado = response
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    let errorMsg: String
                    if modelManager.selectedModel.isFree {
                        errorMsg = "Error al consultar. Verifica tu conexión a Internet y que tu API Key de OpenRouter sea válida."
                    } else {
                        errorMsg = "Error al consultar. Verifica tu conexión, que tu API Key sea válida y que tengas créditos en OpenRouter."
                    }
                    self.errorMessage = errorMsg
                    self.isLoading = false
                }
            }
        }
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

    private func iconForNivel(_ nivel: String) -> String {
        switch nivel.lowercased() {
        case "verde":
            return "checkmark"
        case "amarillo":
            return "exclamationmark"
        case "rojo":
            return "xmark"
        default:
            return "questionmark"
        }
    }
}

// MARK: - Purinas Bar View
struct PurinasBar: View {
    let value: Int
    let nivel: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 0) {
                // Barra verde (0-50)
                Rectangle()
                    .fill(colorForZone(0))
                    .frame(height: 8)

                // Barra amarilla (50-150)
                Rectangle()
                    .fill(colorForZone(1))
                    .frame(height: 8)

                // Barra roja (150+)
                Rectangle()
                    .fill(colorForZone(2))
                    .frame(height: 8)
            }
            .cornerRadius(4)
            .overlay(
                GeometryReader { geometry in
                    Circle()
                        .fill(Color.white)
                        .frame(width: 16, height: 16)
                        .overlay(
                            Circle()
                                .stroke(colorForNivel(nivel), lineWidth: 3)
                        )
                        .position(x: calculatePosition(in: geometry.size.width), y: 4)
                }
            )

            // Etiquetas
            HStack {
                Text("0")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
                Text("50")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
                Text("150")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
                Text("300+")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }

    private func colorForZone(_ zone: Int) -> Color {
        switch zone {
        case 0:
            return .green.opacity(0.6)
        case 1:
            return .yellow.opacity(0.6)
        case 2:
            return .red.opacity(0.6)
        default:
            return .gray
        }
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

    private func calculatePosition(in width: CGFloat) -> CGFloat {
        let maxValue: CGFloat = 300 // Valor máximo de la escala
        let clampedValue = min(CGFloat(value), maxValue)
        return (clampedValue / maxValue) * width
    }
}

// MARK: - Footer View
struct FooterView: View {
    var body: some View {
        VStack(spacing: 10) {
            Divider()

            HStack(spacing: 15) {
                NavigationLink("Cómo funciona") {
                    HowItWorksView()
                }
                .font(.caption)

                Text("•")
                    .foregroundColor(.secondary)

                NavigationLink("Legal") {
                    LegalView()
                }
                .font(.caption)

                Text("•")
                    .foregroundColor(.secondary)

                NavigationLink("Términos") {
                    TermsView()
                }
                .font(.caption)

                Text("•")
                    .foregroundColor(.secondary)

                NavigationLink("API Key") {
                    HowToGetAPIKeyView()
                }
                .font(.caption)
            }
            .foregroundColor(.blue)

            HStack(spacing: 4) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.caption2)
                    .foregroundColor(.orange)
                Text("Consulta siempre a tu médico")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 5)
        }
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
    }
}

#Preview {
    ContentView()
}
