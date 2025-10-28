//
//  HowToGetAPIKeyView.swift
//  IAGota
//
//  SPARRING
//

import SwiftUI

struct HowToGetAPIKeyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("¿Cómo obtener tu API Key?")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)

                // Paso 1
                StepView(
                    number: 1,
                    title: "Crear cuenta en OpenRouter",
                    description: "Visita openrouter.ai y crea una cuenta gratuita usando tu email o cuenta de Google."
                )

                // Paso 2
                StepView(
                    number: 2,
                    title: "Acceder a tu panel",
                    description: "Una vez dentro, ve a tu perfil haciendo clic en tu avatar en la esquina superior derecha."
                )

                // Paso 3
                StepView(
                    number: 3,
                    title: "Ir a 'Keys'",
                    description: "En el menú lateral, selecciona 'Keys' para ver tus claves de API."
                )

                // Paso 4
                StepView(
                    number: 4,
                    title: "Crear nueva clave",
                    description: "Haz clic en 'Create Key'. Dale un nombre descriptivo (ej: 'IAGota App') y confirma."
                )

                // Paso 5
                StepView(
                    number: 5,
                    title: "Copiar la clave",
                    description: "Copia la clave que comienza con 'sk-or-v1-'. ¡Guárdala en un lugar seguro!"
                )

                // Paso 6
                StepView(
                    number: 6,
                    title: "Añadir créditos",
                    description: "Ve a 'Credits' y añade fondos (mínimo 5€). OpenRouter cobra por uso: ~0.15€ por 1M tokens con GPT-4o-mini."
                )

                // Información importante
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 6) {
                        Image(systemName: "info.circle.fill")
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text("Información importante")
                            .font(.headline)
                    }
                    .padding(.top)

                    InfoItem(icon: "checkmark.circle.fill", text: "La API key es personal y no debe compartirse")
                    InfoItem(icon: "lock.fill", text: "Se almacena de forma segura solo en tu dispositivo")
                    InfoItem(icon: "eurosign.circle.fill", text: "Solo pagas por las consultas que hagas")
                    InfoItem(icon: "bolt.fill", text: "GPT-4o-mini es muy económico (~0.0001€ por consulta)")
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

                // Link directo
                Link(destination: URL(string: "https://openrouter.ai/keys")!) {
                    HStack {
                        Image(systemName: "arrow.up.right.square.fill")
                        Text("Ir a OpenRouter")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Obtener API Key")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StepView: View {
    let number: Int
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                Text("\(number)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.caption)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct InfoItem: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            Text(text)
                .font(.subheadline)
        }
    }
}

#Preview {
    NavigationView {
        HowToGetAPIKeyView()
    }
}
