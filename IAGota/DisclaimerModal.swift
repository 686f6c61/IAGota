//
//  DisclaimerModal.swift
//  IAGota
//
//  Modal de aviso médico que aparece en la primera ejecución de la app
//

import SwiftUI

struct DisclaimerModal: View {
    @Binding var isAccepted: Bool
    @State private var hasReadDisclaimer = false

    var body: some View {
        ZStack {
            // Fondo oscuro semi-transparente
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            // Modal
            VStack(spacing: 0) {
                // Header con icono de advertencia
                VStack(spacing: 15) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.orange)

                    Text("AVISO IMPORTANTE")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                .padding(.top, 30)
                .padding(.bottom, 20)

                Divider()

                // Contenido del disclaimer
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        DisclaimerPoint(
                            icon: "cross.case.fill",
                            color: .red,
                            title: "NO es un dispositivo médico",
                            description: "Esta aplicación NO proporciona diagnósticos, tratamientos ni consejo médico profesional."
                        )

                        DisclaimerPoint(
                            icon: "cpu",
                            color: .blue,
                            title: "Respuestas generadas por IA",
                            description: "Las respuestas son generadas por Inteligencia Artificial y pueden contener errores o imprecisiones."
                        )

                        DisclaimerPoint(
                            icon: "book.fill",
                            color: .green,
                            title: "Solo información educativa",
                            description: "La información es únicamente con fines educativos e informativos, no para decisiones médicas."
                        )

                        DisclaimerPoint(
                            icon: "person.fill.questionmark",
                            color: .purple,
                            title: "Consulta a tu médico",
                            description: "SIEMPRE consulta a tu médico antes de hacer cambios en tu dieta, especialmente si tienes gota o problemas con el ácido úrico."
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 25)
                }
                .frame(maxHeight: 350)

                Divider()

                // Checkbox de confirmación
                VStack(spacing: 15) {
                    Button {
                        hasReadDisclaimer.toggle()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: hasReadDisclaimer ? "checkmark.square.fill" : "square")
                                .font(.title2)
                                .foregroundColor(hasReadDisclaimer ? .blue : .gray)

                            Text("He leído y entendido este aviso")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.horizontal)

                    Button {
                        if hasReadDisclaimer {
                            isAccepted = true
                        }
                    } label: {
                        Text("Continuar")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(hasReadDisclaimer ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(!hasReadDisclaimer)
                    .padding(.horizontal)
                }
                .padding(.vertical, 20)
            }
            .frame(maxWidth: 500)
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
            .padding(30)
        }
    }
}

// MARK: - Disclaimer Point View

struct DisclaimerPoint: View {
    let icon: String
    let color: Color
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            // Icono
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 50, height: 50)

                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(color)
            }

            // Texto
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    DisclaimerModal(isAccepted: .constant(false))
}
