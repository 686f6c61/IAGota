//
//  LegalView.swift
//  IAGota
//
//  SPARRING
//

import SwiftUI

struct LegalView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Información Legal")
                    .font(.title)
                    .fontWeight(.bold)

                Divider()

                // NUEVO: Naturaleza EDUCACIONAL
                VStack(alignment: .leading, spacing: 10) {
                    Label("Aplicación EDUCACIONAL - NO Médica", systemImage: "exclamationmark.triangle.fill")
                        .font(.headline)
                        .foregroundColor(.orange)

                    Text("""
                    IAGota es una aplicación EDUCACIONAL, NO una aplicación médica ni un dispositivo médico.

                    ❌ NO proporciona datos EXACTOS de purinas
                    ✅ Solo información orientativa y aproximada
                    ⚠️ La IA puede o NO conocer el alimento consultado
                    ⚠️ Los valores varían según: variedad, preparación, origen, parte del alimento

                    Propósito: Orientación educativa. NUNCA usar como base única para decisiones médicas sin consultar a tu médico.
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)

                // Aviso médico
                VStack(alignment: .leading, spacing: 10) {
                    Label("Aviso Médico", systemImage: "cross.case.fill")
                        .font(.headline)
                        .foregroundColor(.red)

                    Text("""
                    Esta aplicación NO es un dispositivo médico ni proporciona consejo médico profesional.

                    La información proporcionada es únicamente con fines educativos y no debe usarse para:
                    • Diagnosticar condiciones médicas
                    • Tratar enfermedades
                    • Sustituir la consulta con profesionales de la salud
                    • Tomar decisiones médicas sin supervisión

                    Si tienes gota o problemas con el ácido úrico, SIEMPRE consulta a tu médico.
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(10)

                // Propiedad intelectual
                VStack(alignment: .leading, spacing: 10) {
                    Text("Propiedad Intelectual")
                        .font(.headline)

                    Text("""
                    © 2025 IAGota. Todos los derechos reservados.

                    El diseño, código y contenido de esta aplicación están protegidos por derechos de autor.
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }

                // Privacidad y Consultas Anónimas
                VStack(alignment: .leading, spacing: 10) {
                    Text("Privacidad y Consultas Anónimas")
                        .font(.headline)

                    Text("""
                    ✅ CONSULTAS COMPLETAMENTE ANÓNIMAS
                    • Solo enviamos el texto del alimento + tu API key
                    • NO enviamos: nombre, email, teléfono, ubicación, identificadores
                    • Cada consulta es independiente y anónima

                    🔒 TUS DATOS
                    • No recopilamos datos personales
                    • No almacenamos tus consultas (ni localmente ni en servidores)
                    • Tu API key se guarda solo en tu dispositivo
                    • Arquitectura zero-server: no tenemos servidores

                    🌐 OPENROUTER (Proveedor IA)
                    • SOC 2 Type II Compliant
                    • GDPR Compliant (EU)
                    • CCPA Compliant (California)
                    • Zero Data Retention (ZDR)
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)

                // Privacidad de Fotos
                VStack(alignment: .leading, spacing: 10) {
                    Text("Privacidad de Fotos de Cartas")
                        .font(.headline)

                    Text("""
                    📸 LAS FOTOS NO SE GUARDAN
                    • Las fotos de cartas NO se almacenan en tu dispositivo
                    • NO se guardan en ningún servidor nuestro (no tenemos servidores)
                    • Se convierten temporalmente a formato base64 en memoria
                    • Se envían a OpenRouter para análisis y se descartan
                    • OpenRouter no almacena las imágenes (Zero Data Retention)

                    🔒 PROCESAMIENTO:
                    • Foto → Base64 (en memoria) → OpenRouter → Análisis → Descarte
                    • Solo los resultados del análisis se muestran al usuario
                    • Los resultados NO se guardan ni localmente ni en servidores

                    ⚠️ IMPORTANTE:
                    • Asegúrate de no fotografiar información personal sensible
                    • Las fotos se procesan mediante modelos de IA con visión
                    • OpenRouter procesa las imágenes pero no las almacena
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.cyan.opacity(0.1))
                .cornerRadius(10)

                // Uso de IA
                VStack(alignment: .leading, spacing: 10) {
                    Text("Uso de Inteligencia Artificial")
                        .font(.headline)

                    Text("""
                    Esta app utiliza modelos de IA de OpenAI (GPT-4o y GPT-4o-mini) a través de OpenRouter.

                    MODELOS UTILIZADOS:
                    • GPT-4o-mini: Para consultas de texto (predeterminado)
                    • GPT-4o: Para análisis de fotos de cartas y consultas precisas

                    USO DE CÁMARA Y FOTOS:
                    • La app puede acceder a la cámara para fotografiar cartas de restaurante
                    • Las fotos NO se guardan en tu dispositivo ni en servidores
                    • Se procesan temporalmente con GPT-4o para análisis de OCR
                    • Se descartan inmediatamente después del análisis

                    Las respuestas son generadas por IA y pueden:
                    • Contener errores o imprecisiones
                    • Variar entre consultas
                    • No estar actualizadas con investigaciones recientes
                    • No considerar tu situación médica personal
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }

                // Limitación de responsabilidad
                VStack(alignment: .leading, spacing: 10) {
                    Text("Limitación de Responsabilidad")
                        .font(.headline)

                    Text("""
                    En la máxima medida permitida por la ley, los desarrolladores de esta aplicación no serán responsables por:

                    • Daños directos o indirectos
                    • Decisiones médicas basadas en la app
                    • Problemas de salud resultantes del uso
                    • Inexactitudes en las respuestas
                    • Interrupciones del servicio
                    • Costos de API incurridos
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }

                // Metodología y Fuentes de Datos
                VStack(alignment: .leading, spacing: 10) {
                    Text("Metodología y Fuentes de Datos")
                        .font(.headline)

                    Text("""
                    Los valores de purinas están basados en:
                    • Literatura médica y tablas nutricionales científicas
                    • Modelos de Inteligencia Artificial (OpenAI GPT-4o y GPT-4o-mini)
                    • Datos de investigaciones sobre hiperuricemia y gota

                    INFORMACIÓN PROPORCIONADA (v1.2.0+):
                    • Clasificación: <50mg (verde), 50-150mg (amarillo), >150mg (rojo)
                    • Índice de seguridad: Score 0-100 basado en purinas (70%), factores metabólicos (20%), beneficios nutricionales (10%)
                    • Alternativas más seguras: Solo para alimentos amarillos/rojos
                    • Contexto temporal: Frecuencia recomendada de consumo
                    • Consejos de preparación: Si cocinar puede reducir purinas
                    • Factores metabólicos: Efectos especiales en ácido úrico
                    • Info nutricional: Proteínas, fructosa, vitamina C, omega-3

                    ANÁLISIS DE FOTOS DE CARTAS:
                    • Utiliza GPT-4o para reconocimiento óptico de caracteres (OCR)
                    • Extrae automáticamente nombres de platos de la imagen
                    • Analiza el contenido de purinas de cada plato detectado

                    LIMITACIÓN: Los valores son estimaciones generales y pueden variar según preparación, origen del alimento y variedad específica.
                    """)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)

                // Contacto y Privacidad
                VStack(alignment: .leading, spacing: 10) {
                    Text("Contacto y Privacidad")
                        .font(.headline)

                    Text("Para consultas legales o reportar problemas:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Link("iagota@00b.tech", destination: URL(string: "mailto:iagota@00b.tech")!)
                        .font(.subheadline)

                    Link("Política de Privacidad completa", destination: URL(string: "https://686f6c61.github.io/IAGota/")!)
                        .font(.subheadline)
                        .padding(.top, 5)
                }

                Text("Versión 1.2.0")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        LegalView()
    }
}
