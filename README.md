# IAGota - CONSULTA DE PURINAS EN ALIMENTOS

Una aplicación iOS que utiliza inteligencia artificial para analizar alimentos y cartas de restaurante, proporcionando información sobre su contenido de purinas para ayudar a personas que cuidan sus niveles de ácido úrico.

## DEMOSTRACIÓN

![Demostración de IAGota v1.2.0](images/IA-Gota-v2.gif)

## AVISO IMPORTANTE

**Esta aplicación es solo con fines educativos e informativos.** No es un dispositivo médico y no debe usarse como sustituto del consejo médico profesional. Siempre consulta a tu médico o nutricionista antes de hacer cambios en tu dieta.

## CARACTERÍSTICAS

### Análisis de Alimentos
- **Consulta Individual**: Analiza cualquier alimento, ingrediente o plato completo
- **Sistema de Semáforo**: Clasificación visual (verde/amarillo/rojo) según contenido de purinas
- **Índice de Seguridad (v1.2.0)**: Score 0-100 basado en purinas (70%), factores metabólicos (20%) y beneficios nutricionales (10%)
- **Alternativas Inteligentes (v1.2.0)**: Sugerencias de alimentos más seguros para platos amarillos/rojos
- **Contexto Temporal (v1.2.0)**: Frecuencia recomendada de consumo (diario, semanal, ocasional)
- **Consejos de Preparación (v1.2.0)**: Tips de cocina para reducir purinas si es posible
- **Factores Metabólicos (v1.2.0)**: Efectos especiales en el ácido úrico (fructosa, purinas, alcohol)
- **Info Nutricional (v1.2.0)**: Proteínas, fructosa, vitamina C y omega-3

### Análisis de Cartas de Restaurante
- **Fotografía el Menú**: Usa la cámara o selecciona de galería
- **Extracción Automática**: OCR inteligente detecta todos los platos de la carta
- **Análisis Completo**: Cada plato incluye toda la información extendida v1.2.0
- **Progreso en Tiempo Real (v1.2.0)**: Barra de progreso, contador de platos y tiempo estimado
- **Filtros y Ordenación (v1.2.0)**: Filtra por nivel (verde/amarillo/rojo) y ordena por score, purinas o nombre
- **Detalle Expandido**: Toca cualquier plato para ver información completa con alternativas

### General
- **Modelos de IA OpenAI**: GPT-4o-mini (predeterminado, económico) y GPT-4o (mayor precisión)
- **Splash Screen**: Pantalla de bienvenida animada al iniciar la app
- **Privacidad Total**: Tu clave de API se almacena localmente, las fotos no se guardan
- **Naturaleza Educativa**: No es una app médica, sino educacional para mejorar hábitos alimenticios

## REQUISITOS

- iOS 17.0 o superior
- Xcode 15.0 o superior
- Swift 5.9 o superior
- Cuenta gratuita en [OpenRouter](https://openrouter.ai)

## INSTALACIÓN

### 1. Clonar el repositorio

```bash
git clone https://github.com/686f6c61/IAGota.git
cd IAGota
```

### 2. Configurar clave de API para desarrollo (opcional)

Si quieres probar la aplicación sin configurar la clave de API cada vez:

```bash
# Copiar la plantilla de configuración
cp IAGota/Config.plist.example IAGota/Config.plist

# Editar Config.plist y añadir tu clave de API
# Reemplaza "TU_API_KEY_DE_DESARROLLO_AQUI" con tu clave real
```

**Nota:** `Config.plist` está en `.gitignore` y nunca se subirá a GitHub por seguridad.

### 3. Abrir en Xcode

```bash
open IAGota.xcodeproj
```

### 4. Compilar y ejecutar

- Selecciona tu dispositivo o simulador
- Presiona `⌘ + R` para compilar y ejecutar

## OBTENER CLAVE DE API DE OPENROUTER

1. Crea una cuenta gratuita en [openrouter.ai](https://openrouter.ai)
2. Ve a tu perfil → **Keys**
3. Haz clic en **Create Key**
4. Copia la clave que comienza con `sk-or-v1-`
5. Pégala en la aplicación en **Configuración** ⚙️

### Modelos disponibles

Cada modelo incluye un botón de información (ℹ️) que abre su página en OpenRouter con detalles completos.

- **GPT-4o-mini** (predeterminado): ~$0.006 por consulta de texto, ~$0.0063 por análisis de carta. Rápido y muy económico
- **GPT-4o**: ~$0.10 por consulta de texto, ~$0.017 por análisis de carta. Máxima precisión

## USO

### 1. Configuración Inicial
- Toca el ícono ⚙️ en la esquina superior derecha
- Pega tu clave de API de OpenRouter
- Opcionalmente, selecciona tu modelo de IA preferido (GPT-4o-mini o GPT-4o)

### 2. Consulta de Alimentos Individuales

**Realizar consulta:**
- Escribe el nombre del alimento, ingrediente o plato
- Ejemplos: «tomate», «cerveza», «pizza carbonara»
- Presiona «Consultar» o Enter

**Resultado extendido (v1.2.0):**
- **Semáforo**: 🟢 Verde / 🟡 Amarillo / 🔴 Rojo
- **Contenido**: mg de purinas por 100g
- **Índice de Seguridad**: Score 0-100 con barra visual colorida
- **Explicación**: Razonamiento del nivel asignado
- **Alternativas**: Opciones más seguras (solo si es amarillo/rojo)
- **Contexto Temporal**: Frecuencia recomendada de consumo
- **Info Nutricional**: Proteínas, fructosa, vitamina C, omega-3
- **Factores Metabólicos**: Efectos especiales (si aplica)
- **Consejos de Preparación**: Tips de cocina para reducir purinas (si aplica)

### 3. Análisis de Cartas de Restaurante

**Capturar carta:**
- Toca el botón 📸 «Semáforo de purinas»
- Toma una foto de la carta o selecciona de galería
- Presiona «Analizar esta carta»

**Durante el análisis:**
- ⏰ Aviso: proceso puede tardar 30-60 segundos
- 📊 Barra de progreso visual en tiempo real
- 🔢 Contador: "X de Y platos analizados"
- ⏱️ Tiempo estimado restante
- 📝 Nombre del plato actual en análisis

**Resultados:**
- Lista completa con todos los platos detectados
- Cada plato muestra: semáforo, score (⭐ X/100), purinas e indicador de alternativas
- **Filtros**: Botones para ver solo 🟢 Verde / 🟡 Amarillo / 🔴 Rojo / Todos
- **Ordenación**: Por Score / Por Purinas / Por Nombre
- Toca cualquier plato para ver detalle completo con toda la info extendida

**Privacidad:**
- Las fotos NO se guardan en tu dispositivo ni en servidores
- Se procesan temporalmente y se descartan inmediatamente

### 4. Interpretación del Semáforo

- 🟢 **Verde (< 50 mg/100 g)**: Seguro para consumo regular
- 🟡 **Amarillo (50-150 mg/100 g)**: Consumo moderado
- 🔴 **Rojo (> 150 mg/100 g)**: Evitar o consumir con precaución

**Score 0-100:**
- 🟢 **90-100**: Excelente (muy seguro)
- 💙 **70-89**: Seguro
- 🟡 **50-69**: Moderadamente seguro
- 🔴 **0-49**: Precaución requerida

## SEGURIDAD

- **Config.plist**: solo para desarrollo local, nunca se sube a GitHub
- **Claves de API**: se almacenan localmente en el dispositivo con UserDefaults
- **Sin rastreo**: no recopilamos ni enviamos datos a servidores propios
- **OpenRouter**: las consultas se envían solo a OpenRouter según sus términos

## DESARROLLO

### Configuración para desarrollo

```bash
# 1. Copiar plantilla de configuración
cp IAGota/Config.plist.example IAGota/Config.plist

# 2. Editar Config.plist con tu clave de API de desarrollo
# (Este archivo está en .gitignore)

# 3. Compilar
xcodebuild -scheme IAGota -configuration Debug
```

### Estructura del proyecto

```
IAGota/
├── IAGota/
│   ├── IAGotaApp.swift                  # Punto de entrada
│   ├── SplashScreenView.swift           # Pantalla de bienvenida animada
│   │
│   ├── # Vista principal y análisis
│   ├── ContentView.swift                # Vista principal de consulta (con info v1.2.0)
│   ├── OpenRouterService.swift          # Cliente HTTP para consultas de texto
│   ├── FoodResponse.swift               # Modelos de datos (extendido v1.2.0)
│   ├── FoodResponseComponents.swift     # Componentes UI extendidos v1.2.0
│   │
│   ├── # Análisis de cartas por foto
│   ├── PhotoMenuView.swift              # Vista de análisis de cartas v1.2.0
│   ├── PhotoPicker.swift                # Selector de fotos (cámara/galería)
│   ├── MenuAnalysisView.swift           # Resultados con filtros y ordenación v1.2.0
│   ├── MenuAnalysisService.swift        # Servicio OCR con callback de progreso v1.2.0
│   ├── MenuAnalysisModels.swift         # Modelos extendidos para menús v1.2.0
│   │
│   ├── # Configuración y gestión
│   ├── SettingsView.swift               # Configuración de app
│   ├── APIKeyManager.swift              # Gestión de clave de API
│   ├── AIModel.swift                    # Modelos disponibles (GPT-4o, GPT-4o-mini)
│   ├── ModelManager.swift               # Gestión de selección de modelo
│   ├── ModelSelectionView.swift         # Selector de modelos
│   │
│   ├── # Información y legal
│   ├── HowItWorksView.swift             # Explicación de uso (actualizado v1.2.0)
│   ├── LegalView.swift                  # Aviso legal (actualizado v1.2.0)
│   ├── TermsView.swift                  # Términos y condiciones (actualizado v1.2.0)
│   ├── HowToGetAPIKeyView.swift         # Guía de clave de API
│   │
│   ├── # Configuración
│   ├── Config.plist                     # ⚠️ No subir a Git
│   └── Config.plist.example             # Plantilla para desarrollo
│
├── docs/
│   ├── index.html                       # Política de privacidad (web) - v1.2.0
│   └── privacy-policy.md                # Política de privacidad (markdown) - v1.2.0
│
├── README.md                            # Este archivo
├── TESTS_COVERAGE.md                    # Cobertura de tests
├── LICENSE
└── .gitignore
```

### Nuevos archivos v1.2.0

- **FoodResponseComponents.swift**: Componentes UI reutilizables
  - `ScoreView`: Índice de seguridad 0-100 con gradiente
  - `AlternativasView`: Lista de alternativas más seguras
  - `ContextoTemporalView`: Frecuencia de consumo
  - `ConsejoPreparacionView`: Tips de preparación colapsables
  - `FactoresMetabolicosView`: Efectos metabólicos
  - `InfoNutricionalView`: Datos nutricionales
  - `ScoreInfoSheet`: Popup explicativo de niveles

- **MenuAnalysisView.swift**: Resultados de análisis de carta
  - Filtros por nivel (verde/amarillo/rojo)
  - Ordenación (score/purinas/nombre)
  - Modal de detalle con info extendida

- **Progreso en tiempo real**: Sistema de callbacks para mostrar avance durante análisis de cartas

### Arquitectura

- **SwiftUI**: Framework de UI
- **Combine**: Gestión de estado reactivo
- **async/await**: Llamadas asíncronas a la API
- **MVVM**: Patrón de arquitectura

### Tests

El proyecto incluye cobertura de tests completa:
- **17 tests implementados** (10 unitarios + 7 UI)
- **100% de cobertura** en componentes críticos
- Ver [TESTS_COVERAGE.md](TESTS_COVERAGE.md) para detalles completos

Ejecutar tests:
```bash
# Todos los tests
⌘ + U en Xcode

# Desde terminal
xcodebuild test -scheme IAGota -destination 'platform=iOS Simulator,name=iPhone 17'
```

## LICENCIA

Este proyecto está bajo la licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

## CONTRIBUCIONES

Las contribuciones son bienvenidas. Por favor:

1. Haz fork del proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add: nueva característica'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## CONTACTO

Para reportar problemas o sugerencias:
- Abre un [Issue](https://github.com/686f6c61/IAGota/issues)

## LIMITACIÓN DE RESPONSABILIDAD

Esta aplicación no proporciona consejo médico. Las respuestas son generadas por IA y pueden contener errores. Los desarrolladores no se hacen responsables por decisiones tomadas basadas en la información de la aplicación.

**Siempre consulta a tu médico antes de hacer cambios en tu dieta, especialmente si tienes gota o problemas con el ácido úrico.**

---

**Versión**: 1.2.0
**Última actualización**: octubre de 2025
