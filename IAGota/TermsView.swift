//
//  TermsView.swift
//  IAGota
//
//  SPARRING
//

import SwiftUI

struct TermsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Términos y Condiciones")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Última actualización: \(formattedDate())")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Divider()

                // NUEVO: Naturaleza EDUCACIONAL
                VStack(alignment: .leading, spacing: 10) {
                    Label("Aplicación EDUCACIONAL - NO Médica", systemImage: "exclamationmark.triangle.fill")
                        .font(.headline)
                        .foregroundColor(.orange)

                    Text("""
                    IAGota es una aplicación EDUCACIONAL, NO médica ni dispositivo médico.

                    ❌ NO proporciona datos EXACTOS de purinas
                    ✅ Solo información orientativa y aproximada
                    ⚠️ La IA puede o NO conocer el alimento consultado
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)

                // Sección 1
                SectionView(
                    title: "1. Uso de la Aplicación",
                    content: """
                    Esta aplicación proporciona información educativa extendida sobre alimentos y su relación con el ácido úrico (v1.2.0+): clasificación, purinas, índice de seguridad 0-100, alternativas, contexto temporal, consejos de preparación, factores metabólicos e información nutricional.

                    La información proporcionada NO sustituye el consejo médico profesional.

                    Al usar esta aplicación, aceptas que:
                    • La información es solo con fines educativos
                    • Los valores son estimaciones que varían según variedad, preparación, origen
                    • Siempre debes consultar a un profesional de la salud
                    • El uso es bajo tu propio riesgo
                    """
                )

                // Sección 2
                SectionView(
                    title: "2. API Key y Privacidad",
                    content: """
                    ✅ CONSULTAS ANÓNIMAS:
                    • Solo enviamos: texto del alimento + tu API key
                    • NO enviamos: nombre, email, ubicación, identificadores
                    • Cada consulta es independiente y anónima

                    🔒 TUS DATOS:
                    • Tu API key se almacena localmente en tu dispositivo
                    • No recopilamos ni almacenamos tus consultas
                    • Arquitectura zero-server: no tenemos servidores
                    • Eres responsable de los costos asociados a tu API key

                    🌐 OPENROUTER:
                    • SOC 2, GDPR, CCPA Compliant
                    • Zero Data Retention (ZDR)
                    """
                )

                // Sección 2.5: Costes de Análisis de Fotos
                VStack(alignment: .leading, spacing: 10) {
                    Text("2.5. Costes de Análisis de Fotos")
                        .font(.headline)

                    Text("""
                    📸 MODELOS PARA ANÁLISIS DE FOTOS:
                    La función de análisis de cartas usa modelos de IA con visión:

                    💰 COSTE POR CARTA (aproximado):

                    • GPT-4o-mini (predeterminado):
                      - Validar imagen: ~$0.00015
                      - Extraer platos: ~$0.00015
                      - Analizar 20 platos: ~$0.006
                      - TOTAL: ~$0.0063 (0.6 céntimos por carta)

                    • GPT-4o (más preciso, configurable):
                      - Validar imagen: ~$0.0025
                      - Extraer platos: ~$0.0025
                      - Analizar 20 platos: ~$0.012
                      - TOTAL: ~$0.017 (1.7 céntimos por carta)

                    ⚠️ IMPORTANTE:
                    • Los costes se cargan a tu cuenta de OpenRouter
                    • Los precios pueden cambiar sin previo aviso
                    • Eres responsable de controlar tu gasto
                    • Consulta precios actualizados en: openrouter.ai/models
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

                // Sección 3
                SectionView(
                    title: "3. Descargo de Responsabilidad",
                    content: """
                    Esta app NO proporciona diagnósticos médicos ni datos EXACTOS de purinas.

                    Las respuestas son generadas por IA y son estimaciones aproximadas que:
                    • Pueden contener errores o imprecisiones
                    • Varían según variedad, preparación y origen del alimento
                    • La IA puede o no conocer el alimento consultado

                    📸 SOBRE FOTOS DE CARTAS:
                    • Las fotos NO se guardan en tu dispositivo ni en servidores
                    • Se procesan mediante GPT-4o-mini o GPT-4o (OpenRouter)
                    • Los resultados pueden contener errores de OCR o análisis
                    • OpenRouter no almacena las imágenes (Zero Data Retention)

                    No nos hacemos responsables por:
                    • Decisiones tomadas basadas en la información de la app
                    • Problemas de salud derivados del uso de la app
                    • Inexactitudes en las estimaciones
                    • Variaciones en los valores reales de purinas
                    • Errores en el análisis de fotos de cartas
                    • Costes incurridos por análisis de fotos
                    """
                )

                // Sección 4
                SectionView(
                    title: "4. Modificaciones",
                    content: """
                    Nos reservamos el derecho de modificar estos términos en cualquier momento. El uso continuado de la app constituye aceptación de los nuevos términos.
                    """
                )

                // Sección 5: Contacto
                VStack(alignment: .leading, spacing: 10) {
                    Text("5. Contacto")
                        .font(.headline)

                    Text("Para consultas sobre estos términos:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Link("iagota@00b.tech", destination: URL(string: "mailto:iagota@00b.tech")!)
                        .font(.subheadline)

                    Link("Política de Privacidad completa", destination: URL(string: "https://686f6c61.github.io/IAGota/")!)
                        .font(.subheadline)
                        .padding(.top, 5)
                }

                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.headline)
                        .foregroundColor(.orange)
                    Text("IMPORTANTE: Consulta siempre a tu médico")
                        .font(.headline)
                        .foregroundColor(.orange)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: Date())
    }
}

struct SectionView: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            Text(content)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    NavigationView {
        TermsView()
    }
}
