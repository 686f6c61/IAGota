//
//  IAGotaApp.swift
//  IAGota
//
//  Created by R on 27/10/25.
//

import SwiftUI

@main
struct IAGotaApp: App {
    @AppStorage("hasAcceptedDisclaimer") private var hasAcceptedDisclaimer = false
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashScreenView()
                        .transition(.opacity)
                        .zIndex(2)
                } else {
                    ContentView()
                        .transition(.opacity)
                        .zIndex(0)
                }

                // Modal de disclaimer (aparece después del splash si no se ha aceptado)
                if !showSplash && !hasAcceptedDisclaimer {
                    DisclaimerModal(isAccepted: $hasAcceptedDisclaimer)
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
            .onAppear {
                // Mostrar splash por 1.5 segundos
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showSplash = false
                    }
                }
            }
        }
    }
}
