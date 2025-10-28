//
//  SplashScreenView.swift
//  IAGota
//
//  Pantalla de bienvenida con animación al inicio de la app
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isAnimating = false
    @State private var opacity = 0.0

    var body: some View {
        ZStack {
            // Fondo con gradiente
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.2, green: 0.6, blue: 0.9),  // Azul salud
                    Color(red: 0.3, green: 0.8, blue: 0.7)   // Verde nutrición
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // Icono de la app con animación
                Image(systemName: "drop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .scaleEffect(isAnimating ? 1.0 : 0.5)
                    .opacity(opacity)

                // Nombre de la app
                Text("IAGota")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .opacity(opacity)

                // Subtítulo
                Text("Cuidado del ácido úrico")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                    .opacity(opacity)
            }
        }
        .onAppear {
            // Animación de entrada
            withAnimation(.easeOut(duration: 0.6)) {
                isAnimating = true
                opacity = 1.0
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
