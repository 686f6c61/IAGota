//
//  PhotoMenuView.swift
//  IAGota
//
//  Vista para capturar o seleccionar foto de carta
//

import SwiftUI

struct PhotoMenuView: View {
    @StateObject private var apiKeyManager = APIKeyManager()
    @StateObject private var modelManager = ModelManager()

    @State private var showCamera = false
    @State private var showGallery = false
    @State private var selectedImage: UIImage? = nil
    @State private var isAnalyzing = false
    @State private var analysisResult: MenuAnalysisResult? = nil
    @State private var errorMessage: String? = nil

    // Progress tracking
    @State private var progressMessage: String = "Iniciando análisis..."
    @State private var currentDish: Int = 0
    @State private var totalDishes: Int = 0

    var body: some View {
        NavigationView {
            ZStack {
                if selectedImage == nil {
                    // Vista inicial: Sin foto seleccionada
                    initialView
                } else if analysisResult == nil {
                    // Vista de preview: Foto seleccionada, esperando análisis
                    previewView
                } else if let result = analysisResult, result.isValidMenu, !result.dishes.isEmpty {
                    // Vista de resultados: Análisis completado
                    MenuAnalysisView(result: result, onAnalyzeAnother: resetView)
                } else if let result = analysisResult, !result.isValidMenu {
                    // Error: No es una carta válida
                    errorView(message: result.errorMessage ?? "Error desconocido")
                } else if let result = analysisResult, result.dishes.isEmpty {
                    // Error: No se encontraron platos
                    errorView(message: result.errorMessage ?? "No se encontraron platos")
                }
            }
            .navigationTitle("Semáforo de purinas")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showCamera) {
                PhotoPicker(selectedImage: $selectedImage, sourceType: .camera)
            }
            .sheet(isPresented: $showGallery) {
                PhotoPicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
            }
        }
    }

    // MARK: - Initial View

    private var initialView: some View {
        VStack(spacing: 30) {
            Spacer()

            // Icono grande
            Image(systemName: "camera.metering.multispot")
                .font(.system(size: 80))
                .foregroundColor(.blue)
                .padding(.bottom, 20)

            // Título
            Text("Analiza una Carta")
                .font(.title2)
                .fontWeight(.bold)

            // Descripción
            Text("Fotografía o selecciona una carta de restaurante para analizar los platos")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()

            // Botones
            VStack(spacing: 15) {
                Button {
                    showCamera = true
                } label: {
                    Label("Tomar Foto", systemImage: "camera.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                Button {
                    showGallery = true
                } label: {
                    Label("Seleccionar de Galería", systemImage: "photo.on.rectangle")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .foregroundColor(.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }

            // Aviso de privacidad
            HStack(spacing: 8) {
                Image(systemName: "lock.shield.fill")
                    .foregroundColor(.green)
                Text("Las fotos no se guardan")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 10)

            Spacer()
        }
        .padding()
    }

    // MARK: - Preview View

    private var previewView: some View {
        VStack(spacing: 20) {
            // Preview de la imagen
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding()
            }

            if isAnalyzing {
                VStack(spacing: 15) {
                    // Animación de semáforos girando
                    AnimatedTrafficLights()

                    Text(progressMessage)
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    // Progress bar y contador si estamos analizando platos
                    if totalDishes > 0 {
                        VStack(spacing: 8) {
                            // Barra de progreso
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    // Background
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.systemGray5))
                                        .frame(height: 8)

                                    // Progress
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.blue)
                                        .frame(width: geometry.size.width * CGFloat(currentDish) / CGFloat(totalDishes), height: 8)
                                        .animation(.easeInOut(duration: 0.3), value: currentDish)
                                }
                            }
                            .frame(height: 8)
                            .padding(.horizontal)

                            // Contador
                            Text("\(currentDish) de \(totalDishes) platos analizados")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            // Tiempo estimado
                            let remainingDishes = totalDishes - currentDish
                            let estimatedSeconds = remainingDishes * 1  // ~1 segundo por plato aproximadamente
                            if estimatedSeconds > 0 {
                                Text("Tiempo estimado: ~\(estimatedSeconds)s")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.top, 10)
                    } else {
                        // Mensaje inicial
                        Text("Esto puede tardar 30-60 segundos dependiendo del número de platos")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
                .padding()
            } else {
                VStack(spacing: 15) {
                    // Aviso de tiempo
                    HStack(spacing: 8) {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.orange)
                        Text("El análisis puede tardar 30-60 segundos")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)

                    // Botón principal
                    Button {
                        analyzeMenu()
                    } label: {
                        Text("Analizar esta carta")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    // Botón secundario
                    Button {
                        selectedImage = nil
                    } label: {
                        Text("Cambiar foto")
                            .foregroundColor(.blue)
                    }
                }
            }

            Spacer()
        }
        .padding()
    }

    // MARK: - Error View

    private func errorView(message: String) -> some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundColor(.orange)

            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Button {
                resetView()
            } label: {
                Text("Intentar de nuevo")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }

    // MARK: - Actions

    private func analyzeMenu() {
        guard let image = selectedImage else { return }

        // Verificar API Key
        let apiKey = apiKeyManager.apiKey
        guard !apiKey.isEmpty else {
            errorMessage = "Necesitas configurar tu API Key de OpenRouter para usar esta función."
            analysisResult = MenuAnalysisResult(
                isValidMenu: false,
                errorMessage: errorMessage,
                dishes: []
            )
            return
        }

        isAnalyzing = true
        progressMessage = "Iniciando análisis..."
        currentDish = 0
        totalDishes = 0

        Task {
            do {
                // Usar modelo vision (GPT-4o-mini - más confiable)
                let visionModel = "openai/gpt-4o-mini"
                let service = MenuAnalysisService(apiKey: apiKey, visionModel: visionModel)

                let result = try await service.analyzeMenu(image: image) { message, current, total in
                    // Callback de progreso
                    self.progressMessage = message
                    self.currentDish = current
                    self.totalDishes = total
                }

                await MainActor.run {
                    self.analysisResult = result
                    self.isAnalyzing = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Error al analizar la carta: \(error.localizedDescription)"
                    self.analysisResult = MenuAnalysisResult(
                        isValidMenu: false,
                        errorMessage: errorMessage,
                        dishes: []
                    )
                    self.isAnalyzing = false
                }
            }
        }
    }

    private func resetView() {
        selectedImage = nil
        analysisResult = nil
        errorMessage = nil
        isAnalyzing = false
        progressMessage = "Iniciando análisis..."
        currentDish = 0
        totalDishes = 0
    }
}

// MARK: - Animated Traffic Lights

struct AnimatedTrafficLights: View {
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0

    var body: some View {
        HStack(spacing: 15) {
            Text("🟢")
                .font(.system(size: 40))
                .scaleEffect(scale)
            Text("🟡")
                .font(.system(size: 40))
                .scaleEffect(scale)
            Text("🔴")
                .font(.system(size: 40))
                .scaleEffect(scale)
        }
        .rotationEffect(.degrees(rotation))
        .onAppear {
            withAnimation(
                Animation.linear(duration: 2.0)
                    .repeatForever(autoreverses: false)
            ) {
                rotation = 360
            }

            withAnimation(
                Animation.easeInOut(duration: 0.8)
                    .repeatForever(autoreverses: true)
            ) {
                scale = 1.2
            }
        }
    }
}

#Preview {
    PhotoMenuView()
}
