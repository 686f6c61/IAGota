# POLÍTICA DE PRIVACIDAD / PRIVACY POLICY - IAGota

**Última actualización / Last updated:** 28 de octubre de 2025 / October 28, 2025

---

# 🇪🇸 VERSIÓN EN ESPAÑOL

## INTRODUCCIÓN

**IAGota** ("la Aplicación", "nosotros", "nuestro") es una herramienta educativa que respeta profundamente su privacidad y está comprometida con la máxima protección de sus datos personales. Esta Política de Privacidad ha sido diseñada para proporcionarle información completa y transparente sobre qué información recopilamos, cómo la utilizamos, con quién la compartimos y cuáles son sus derechos sobre sus datos.

---

## ⚠️ NATURALEZA DE LA APLICACIÓN: EDUCACIONAL, NO MÉDICA

**IAGota es una aplicación EDUCACIONAL**, no una aplicación médica ni un dispositivo médico.

### Importante sobre los datos de purinas:

- ❌ **NO proporciona datos exactos** de contenido de purinas en alimentos
- ✅ Ofrece **información orientativa y aproximada** basada en conocimiento general
- ⚠️ Las respuestas son generadas por Inteligencia Artificial que **puede o no conocer** el alimento específico consultado
- ⚠️ Los valores son **estimaciones generales** que pueden variar significativamente según:
  - Variedad específica del alimento
  - Método de preparación o cocción
  - Origen geográfico y estacionalidad
  - Parte específica del alimento (ejemplo: muslo vs. pechuga de pollo)

**Propósito:** La aplicación tiene como único objetivo ayudarle a tener una mejor orientación educativa sobre alimentos que puede o no conocer, pero **NUNCA** debe usarse como base única para decisiones médicas o dietéticas sin consultar a su médico o nutricionista profesional.

---

## INFORMACIÓN QUE RECOPILAMOS

### API KEY DE OPENROUTER

Su clave de API de OpenRouter es un elemento fundamental para el funcionamiento de la aplicación. Esta clave (que comienza con `sk-or-v1-`) es proporcionada voluntariamente por usted durante el proceso de configuración inicial de la aplicación.

La clave API se almacena **exclusivamente en su dispositivo** mediante el sistema UserDefaults de iOS, que es un mecanismo de almacenamiento local y seguro. Es importante destacar que esta clave nunca sale de su dispositivo excepto cuando se utiliza para autenticar solicitudes directas a OpenRouter. No tenemos acceso a ella, no la almacenamos en servidores remotos y no la compartimos con terceros más allá de su uso técnico necesario.

El propósito de almacenar su API key es permitir que la aplicación pueda autenticar y procesar sus consultas de alimentos a través de los servicios de inteligencia artificial de OpenRouter. Sin esta clave, la funcionalidad principal de la aplicación no podría operar.

### CONSULTAS DE ALIMENTOS

Cuando utiliza la aplicación para consultar información sobre alimentos, los nombres o descripciones de los alimentos que ingresa en el campo de texto se envían temporalmente a OpenRouter para su procesamiento mediante modelos de inteligencia artificial.

Es fundamental que comprenda que **NO almacenamos sus consultas** en ningún servidor bajo nuestro control. Las consultas existen únicamente en la memoria temporal de su dispositivo durante el procesamiento y se transmiten de forma segura (mediante HTTPS) a OpenRouter para obtener la respuesta. Una vez que recibe el resultado con la información sobre purinas, ni la consulta ni la respuesta se guardan de forma permanente.

Esta arquitectura de "cero almacenamiento" garantiza su privacidad máxima, ya que no mantenemos ningún historial de sus búsquedas ni de sus hábitos alimenticios.

---

## CÓMO USAMOS SU INFORMACIÓN

### USO DE LA API KEY

La API key de OpenRouter que proporciona tiene un único propósito: autenticar sus solicitudes cuando la aplicación se comunica con los servidores de OpenRouter para procesar sus consultas sobre alimentos. Esta clave permanece almacenada de forma segura en su dispositivo iOS en todo momento.

Nunca transmitimos su API key a servidores propios porque, sencillamente, no disponemos de ningún servidor backend. IAGota es una aplicación completamente client-side (del lado del cliente), lo que significa que toda la lógica se ejecuta en su dispositivo y las únicas comunicaciones externas son directamente con OpenRouter.

Usted mantiene el control total sobre su API key y puede eliminarla en cualquier momento accediendo a Configuración → Zona de Peligro → Eliminar API Key. Esta acción es irreversible desde nuestra perspectiva, ya que al estar almacenada localmente, su eliminación significa que no tenemos forma de recuperarla.

### PROCESAMIENTO DE CONSULTAS

El flujo de información cuando realiza una consulta es el siguiente: usted ingresa el nombre de un alimento, la aplicación toma ese texto junto con su API key, lo envía mediante una conexión HTTPS encriptada a OpenRouter, donde los modelos de IA (como GPT-4o, Claude 3.5 Sonnet o DeepSeek V3.1) analizan la consulta y devuelven información estructurada sobre el contenido de purinas.

Esta respuesta se muestra inmediatamente en su pantalla y no se guarda en ningún lugar. El próximo segundo que cierre la aplicación o realice otra búsqueda, esa información desaparece de la memoria.

---

## COMPARTIR INFORMACIÓN CON TERCEROS

### OPENROUTER - NUESTRO PROVEEDOR DE IA

OpenRouter es nuestro único socio tecnológico y el único tercero con el que se comparte información de sus consultas. OpenRouter actúa como intermediario que proporciona acceso unificado a múltiples proveedores de modelos de inteligencia artificial (OpenAI, Anthropic, DeepSeek, entre otros).

### ✅ CONSULTAS COMPLETAMENTE ANÓNIMAS

**⚠️ IMPORTANTE: NO enviamos ningún dato identificativo a OpenRouter.**

Cuando realiza una consulta, **únicamente se envía**:
- ✅ El texto del alimento, plato, ingredientes o descripción que usted escribe
- ✅ Su API key de OpenRouter (para autenticación técnica del servicio)

**❌ NO se envía bajo ninguna circunstancia:**
- ❌ Nombre, apellidos o identidad personal
- ❌ Dirección de correo electrónico
- ❌ Número de teléfono
- ❌ Ubicación geográfica (GPS, IP)
- ❌ Identificadores de dispositivo (IMEI, MAC address)
- ❌ Datos de salud o historial médico
- ❌ Historial de búsquedas anteriores
- ❌ Ningún otro dato personal

**Cada consulta es completamente independiente, anónima y desvinculada de su identidad.** OpenRouter recibe solo el texto de la consulta y no tiene forma de identificarle ni de asociar múltiples consultas con la misma persona.

#### ¿Qué información compartimos con OpenRouter?

- **Consulta de alimentos:** Únicamente el texto que ingresa (ejemplo: "pollo", "lentejas", "salmón"). Sin contexto adicional, sin identificadores personales.
- **API key:** Su clave de OpenRouter para autenticación técnica del servicio (esta clave la proporciona OpenRouter y está bajo su control).
- **Metadatos técnicos mínimos:** Información estrictamente necesaria para el funcionamiento del protocolo HTTPS (como cabeceras HTTP estándar), pero sin datos personales.

**Importante:** OpenRouter procesa esta información según sus propias políticas de privacidad y términos de servicio:
- Política de privacidad: https://openrouter.ai/privacy
- Términos de servicio: https://openrouter.ai/terms

### ✅ CUMPLIMIENTO NORMATIVO DE OPENROUTER

OpenRouter es una plataforma que cumple con las principales regulaciones internacionales de protección de datos:

- **SOC 2 Type II Compliant:** OpenRouter ha sido auditado y certificado bajo el estándar SOC 2 Type II, que verifica controles rigurosos sobre seguridad, disponibilidad, integridad de procesamiento, confidencialidad y privacidad.

- **GDPR Compliant:** Cumple totalmente con el Reglamento General de Protección de Datos de la Unión Europea. Para clientes enterprise, OpenRouter ofrece enrutamiento en región EU (EU in-region routing), garantizando que los datos nunca salen de la Unión Europea.

- **CCPA Compliant:** Cumple con la California Consumer Privacy Act y otras leyes estatales de privacidad de Estados Unidos.

- **Zero Data Retention (ZDR):** OpenRouter ofrece controles de retención cero de datos. Por defecto, NO registra (no logging) prompts ni respuestas a menos que el usuario opte explícitamente por el logging a cambio de un 1% de descuento.

- **Cláusulas Contractuales Estándar:** Para transferencias internacionales de datos, OpenRouter utiliza las cláusulas contractuales estándar aprobadas por la Comisión Europea bajo el Artículo 46 del GDPR.

### OTROS TERCEROS

Queremos ser absolutamente claros en este punto: **NO compartimos sus datos con ningún otro tercero** más allá de OpenRouter. Específicamente:

- ❌ NO vendemos sus datos a nadie
- ❌ NO utilizamos sus datos para publicidad dirigida
- ❌ NO enviamos sus datos a servidores propios (no tenemos servidores)
- ❌ NO compartimos información con redes publicitarias
- ❌ NO rastreamos su comportamiento con cookies o identificadores
- ❌ NO integramos analytics de terceros (Google Analytics, Facebook Pixel, etc.)

---

## DATOS QUE NO RECOPILAMOS

En el espíritu de máxima transparencia, consideramos importante especificar claramente qué tipos de datos **NO recopilamos bajo ninguna circunstancia:**

- ❌ Nombre completo, apellidos o alias
- ❌ Dirección de correo electrónico (excepto si nos contacta voluntariamente por email)
- ❌ Número de teléfono
- ❌ Dirección física o código postal
- ❌ Ubicación GPS o geolocalización
- ❌ Datos de salud, diagnósticos médicos o historial clínico
- ❌ Fotografías o imágenes: La app SÍ accede a la cámara para fotografiar cartas de restaurante, pero las fotos NO se guardan
- ❌ Contactos o agenda telefónica
- ❌ Micrófono o grabaciones de audio
- ❌ Calendarios o recordatorios
- ❌ Identificadores únicos de dispositivo (UDID, IMEI, número de serie)
- ❌ Dirección MAC de red
- ❌ Dirección IP (no tenemos servidores propios que la capturen)
- ❌ Historial de navegación
- ❌ Datos de uso o telemetría (no usamos analytics)

---

## ALMACENAMIENTO Y SEGURIDAD

### ALMACENAMIENTO LOCAL ÚNICAMENTE

Su API key se almacena exclusivamente en su dispositivo usando el mecanismo UserDefaults de iOS. Este sistema de almacenamiento:
- Es local al dispositivo (no sincroniza con iCloud)
- Está protegido por el sandbox de seguridad de iOS
- Solo es accesible por nuestra aplicación
- Permanece encriptado con las protecciones de iOS

### MEDIDAS DE SEGURIDAD

- ✅ Todas las comunicaciones con OpenRouter usan **HTTPS encriptado (TLS 1.3+)**
- ✅ Su API key nunca se transmite a servidores propios (no tenemos ninguno)
- ✅ No almacenamos logs de consultas
- ✅ Arquitectura zero-server: todo es client-side

**Su responsabilidad:** Proteja su dispositivo con contraseña, Face ID o Touch ID. La seguridad de su API key depende también de la seguridad física de su dispositivo.

### ELIMINACIÓN DE DATOS

Puede eliminar todos los datos almacenados por la aplicación en cualquier momento:

**Método 1 - Dentro de la app:**
1. Abrir IAGota
2. Ir a Configuración (icono ⚙️)
3. Scroll hasta "Zona de Peligro"
4. Pulsar "Eliminar API Key"
5. Confirmar acción

**Método 2 - Desinstalar la app:**
1. Mantener presionado el icono de IAGota
2. Seleccionar "Eliminar App"
3. Confirmar eliminación

**Efecto:** Esto eliminará permanentemente su API key de su dispositivo. No podemos recuperarla porque nunca la almacenamos en servidores.

---

## SUS DERECHOS

### DERECHOS GENERALES

Usted tiene derecho a:
- **Acceder:** Ver su API key almacenada (mostrada parcialmente en Configuración por seguridad)
- **Eliminar:** Borrar su API key en cualquier momento desde la app
- **Portabilidad:** Su API key es portable; puede copiarla y usarla en otras aplicaciones
- **Revocar:** Puede revocar o regenerar su API key desde el panel de OpenRouter

### DERECHOS BAJO GDPR (UNIÓN EUROPEA)

Si reside en la Unión Europea, tiene derechos adicionales bajo el GDPR:
- **Derecho al olvido:** Puede solicitar la eliminación de sus datos (aplicable a datos en OpenRouter)
- **Derecho a la portabilidad:** Puede exportar sus datos (en nuestro caso, solo su API key)
- **Derecho a restringir el procesamiento:** Puede limitar cómo se procesan sus datos
- **Derecho a oponerse:** Puede oponerse al procesamiento de sus datos (puede dejar de usar la app)
- **Derecho a no ser sujeto a decisiones automatizadas:** Aplicable si IA toma decisiones que le afectan legalmente

### DERECHOS BAJO CCPA (CALIFORNIA, EE.UU.)

Si reside en California, tiene derechos bajo la CCPA:
- **Derecho a saber:** Qué categorías de información personal recopilamos (descrito en esta política)
- **Derecho a eliminar:** Puede solicitar eliminación de información (use la función dentro de la app)
- **Derecho a optar por no participar en la venta:** NO aplicable - **NO vendemos sus datos**
- **Derecho a no discriminación:** No recibirá trato discriminatorio por ejercer sus derechos CCPA

---

## ARQUITECTURA DE PRIVACIDAD (DIAGRAMA TÉCNICO)

```
┌─────────────────────────────────────────────────────────────┐
│  SU DISPOSITIVO iOS                                         │
│                                                             │
│  ┌──────────────────────────────────────────────┐          │
│  │ IAGota App                                   │          │
│  │                                              │          │
│  │  • API Key (UserDefaults - local only)      │          │
│  │  • Consulta: "pollo"                        │          │
│  │                                              │          │
│  └──────────────────┬───────────────────────────┘          │
│                     │                                       │
│                     │ HTTPS Encriptado (TLS 1.3)          │
└─────────────────────┼───────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│  OPENROUTER API                                             │
│                                                             │
│  • Recibe: "pollo" + API Key                               │
│  • NO recibe: nombre, email, ubicación, etc.               │
│  • Procesa con IA (GPT-4o, Claude, DeepSeek)              │
│  • Devuelve: { purina: "bajo", mg: "~70" }                │
│  • Zero Data Retention (ZDR) activado                      │
│                                                             │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      │ HTTPS Encriptado
                      ▼
┌─────────────────────────────────────────────────────────────┐
│  SU DISPOSITIVO iOS                                         │
│                                                             │
│  ┌──────────────────────────────────────────────┐          │
│  │ IAGota App                                   │          │
│  │                                              │          │
│  │  • Muestra resultado en pantalla            │          │
│  │  • NO guarda consulta                       │          │
│  │  • NO guarda respuesta                      │          │
│  │                                              │          │
│  └──────────────────────────────────────────────┘          │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────┐
│  NUESTROS SERVIDORES        │
│                             │
│  ❌ NO EXISTEN              │
│  ❌ NO ALMACENAMOS NADA     │
└─────────────────────────────┘
```

---

## CAMBIOS A ESTA POLÍTICA

Nos reservamos el derecho de actualizar esta Política de Privacidad ocasionalmente para reflejar cambios en nuestras prácticas, requisitos legales o mejoras en la aplicación. Le notificaremos sobre cambios significativos mediante:

- Actualización de la fecha de "Última actualización" en la parte superior de este documento
- Un aviso destacado dentro de la aplicación para cambios materiales que afecten sus derechos
- Si es requerido por ley, solicitaremos su consentimiento renovado para los cambios

El uso continuado de la aplicación después de la publicación de cambios constituye su aceptación de la nueva Política de Privacidad actualizada. Le recomendamos revisar este documento periódicamente.

---

## MENORES DE EDAD

Esta aplicación no está diseñada ni dirigida a personas menores de 13 años de edad. No recopilamos intencionalmente información personal de menores de 13 años.

Si usted es padre, madre o tutor legal y descubre que su hijo menor de 13 años ha proporcionado información a través de la aplicación, por favor contáctenos inmediatamente a **iagota@00b.tech** para que podamos eliminar dicha información.

---

## CONTACTO

Si tiene preguntas, comentarios o inquietudes sobre esta Política de Privacidad, sobre cómo manejamos sus datos, o si desea ejercer cualquiera de sus derechos, puede contactarnos a través de:

- **Email principal:** iagota@00b.tech
- **Repositorio GitHub (issues):** https://github.com/686f6c61/IAGota/issues

**Tiempo de respuesta comprometido:** Nos esforzamos por responder a todas las consultas en un plazo máximo de 7 días hábiles. Para solicitudes urgentes relacionadas con la eliminación de datos o ejercicio de derechos bajo GDPR/CCPA, responderemos en un plazo de 72 horas.

---

## 💙 TRANSPARENCIA: CÓDIGO FUENTE ABIERTO

IAGota es una aplicación de código abierto. Esto significa que cualquier persona con conocimientos técnicos puede inspeccionar exactamente cómo funciona la aplicación, verificar que cumplimos con lo declarado en esta Política de Privacidad y auditar la seguridad del código.

**Código fuente completo:** https://github.com/686f6c61/IAGota

Esta transparencia es nuestra mejor garantía de que realmente respetamos su privacidad tal como lo declaramos.

---

**IAGota - Versión 1.0.0**
© 2025 - Desarrollado con ❤️ para la comunidad de personas que cuidan su ácido úrico
*Esta Política de Privacidad está sujeta a las leyes de España y la Unión Europea.*
🇪🇸 Aplicación desarrollada en España | 🇪🇺 GDPR & LOPD-GDD Compliant

---
---
---

# 🇬🇧 ENGLISH VERSION

## INTRODUCTION

**IAGota** ("the Application", "we", "our") is an educational tool that deeply respects your privacy and is committed to the highest protection of your personal data. This Privacy Policy is designed to provide you with complete and transparent information about what information we collect, how we use it, who we share it with, and what your rights are regarding your data.

---

## ⚠️ NATURE OF THE APPLICATION: EDUCATIONAL, NOT MEDICAL

**IAGota is an EDUCATIONAL application**, not a medical application or medical device.

### Important about purine data:

- ❌ **Does NOT provide exact data** on purine content in foods
- ✅ Offers **approximate and guidance information** based on general knowledge
- ⚠️ Responses are generated by Artificial Intelligence that **may or may not know** the specific food queried
- ⚠️ Values are **general estimates** that can vary significantly depending on:
  - Specific variety of the food
  - Preparation or cooking method
  - Geographic origin and seasonality
  - Specific part of the food (example: chicken thigh vs. breast)

**Purpose:** The application's sole purpose is to help you gain better educational guidance about foods you may or may not know, but should **NEVER** be used as the sole basis for medical or dietary decisions without consulting your doctor or professional nutritionist.

---

## INFORMATION WE COLLECT

### OPENROUTER API KEY

Your OpenRouter API key is a fundamental element for the application's functionality. This key (which begins with `sk-or-v1-`) is voluntarily provided by you during the initial configuration process of the application.

The API key is stored **exclusively on your device** using iOS's UserDefaults system, which is a local and secure storage mechanism. It's important to note that this key never leaves your device except when used to authenticate direct requests to OpenRouter. We don't have access to it, we don't store it on remote servers, and we don't share it with third parties beyond its necessary technical use.

The purpose of storing your API key is to allow the application to authenticate and process your food queries through OpenRouter's artificial intelligence services. Without this key, the application's main functionality could not operate.

### FOOD QUERIES

When you use the application to query information about foods, the names or descriptions of foods you enter in the text field are temporarily sent to OpenRouter for processing through artificial intelligence models.

It's essential that you understand we **DO NOT store your queries** on any server under our control. Queries exist only in your device's temporary memory during processing and are securely transmitted (via HTTPS) to OpenRouter to obtain the response. Once you receive the result with purine information, neither the query nor the response is permanently saved.

This "zero storage" architecture guarantees your maximum privacy, as we don't maintain any history of your searches or eating habits.

---

## HOW WE USE YOUR INFORMATION

### USE OF API KEY

The OpenRouter API key you provide has a single purpose: to authenticate your requests when the application communicates with OpenRouter servers to process your food queries. This key remains securely stored on your iOS device at all times.

We never transmit your API key to our own servers because, simply put, we don't have any backend servers. IAGota is a completely client-side application, meaning all logic runs on your device and the only external communications are directly with OpenRouter.

You maintain complete control over your API key and can delete it at any time by accessing Settings → Danger Zone → Delete API Key. This action is irreversible from our perspective, as being stored locally, its deletion means we have no way to recover it.

### QUERY PROCESSING

The information flow when you make a query is as follows: you enter a food name, the application takes that text along with your API key, sends it via an encrypted HTTPS connection to OpenRouter, where AI models (such as GPT-4o y GPT-4o-mini) analyze the query and return structured information about purine content.

This response is immediately displayed on your screen and is not saved anywhere. The next second you close the application or perform another search, that information disappears from memory.

---

## SHARING INFORMATION WITH THIRD PARTIES

### OPENROUTER - OUR AI PROVIDER

OpenRouter is our only technology partner and the only third party with whom your query information is shared. OpenRouter acts as an intermediary providing unified access to multiple artificial intelligence model providers (OpenAI, Anthropic, DeepSeek, among others).

### ✅ COMPLETELY ANONYMOUS QUERIES

**⚠️ IMPORTANT: We DO NOT send any identifying data to OpenRouter.**

When you make a query, **only the following is sent**:
- ✅ The text of the food, dish, ingredients, or description you write
- ✅ Your OpenRouter API key (for technical service authentication)

**❌ NEVER sent under any circumstances:**
- ❌ Name, surname, or personal identity
- ❌ Email address
- ❌ Phone number
- ❌ Geographic location (GPS, IP)
- ❌ Device identifiers (IMEI, MAC address)
- ❌ Health data or medical history
- ❌ Previous search history
- ❌ Any other personal data

**Each query is completely independent, anonymous, and disconnected from your identity.** OpenRouter receives only the query text and has no way to identify you or associate multiple queries with the same person.

#### What information do we share with OpenRouter?

- **Food query:** Only the text you enter (example: "chicken", "lentils", "salmon"). No additional context, no personal identifiers.
- **API key:** Your OpenRouter key for technical service authentication (this key is provided by OpenRouter and is under your control).
- **Minimal technical metadata:** Information strictly necessary for HTTPS protocol operation (such as standard HTTP headers), but without personal data.

**Important:** OpenRouter processes this information according to its own privacy policies and terms of service:
- Privacy Policy: https://openrouter.ai/privacy
- Terms of Service: https://openrouter.ai/terms

### ✅ OPENROUTER REGULATORY COMPLIANCE

OpenRouter is a platform that complies with major international data protection regulations:

- **SOC 2 Type II Compliant:** OpenRouter has been audited and certified under the SOC 2 Type II standard, which verifies rigorous controls over security, availability, processing integrity, confidentiality, and privacy.

- **GDPR Compliant:** Fully complies with the European Union's General Data Protection Regulation. For enterprise clients, OpenRouter offers EU in-region routing, ensuring data never leaves the European Union.

- **CCPA Compliant:** Complies with the California Consumer Privacy Act and other U.S. state privacy laws.

- **Zero Data Retention (ZDR):** OpenRouter offers zero data retention controls. By default, it does NOT log prompts or responses unless the user explicitly opts into logging in exchange for a 1% discount.

- **Standard Contractual Clauses:** For international data transfers, OpenRouter uses standard contractual clauses approved by the European Commission under Article 46 of GDPR.

### OTHER THIRD PARTIES

We want to be absolutely clear on this point: **We DO NOT share your data with any other third party** beyond OpenRouter. Specifically:

- ❌ We DO NOT sell your data to anyone
- ❌ We DO NOT use your data for targeted advertising
- ❌ We DO NOT send your data to our own servers (we have no servers)
- ❌ We DO NOT share information with advertising networks
- ❌ We DO NOT track your behavior with cookies or identifiers
- ❌ We DO NOT integrate third-party analytics (Google Analytics, Facebook Pixel, etc.)

---

## DATA WE DO NOT COLLECT

In the spirit of maximum transparency, we consider it important to clearly specify what types of data **we DO NOT collect under any circumstances:**

- ❌ Full name, surnames, or aliases
- ❌ Email address (except if you voluntarily contact us by email)
- ❌ Phone number
- ❌ Physical address or postal code
- ❌ GPS location or geolocation
- ❌ Health data, medical diagnoses, or clinical history
- ❌ Photographs or images (app currently has no camera functionality)
- ❌ Contacts or phone book
- ❌ Microphone or audio recordings
- ❌ Calendars or reminders
- ❌ Unique device identifiers (UDID, IMEI, serial number)
- ❌ Network MAC address
- ❌ IP address (we have no servers to capture it)
- ❌ Browsing history
- ❌ Usage data or telemetry (we don't use analytics)

---

## STORAGE AND SECURITY

### LOCAL STORAGE ONLY

Your API key is stored exclusively on your device using iOS's UserDefaults mechanism. This storage system:
- Is local to the device (doesn't sync with iCloud)
- Is protected by iOS's security sandbox
- Is only accessible by our application
- Remains encrypted with iOS protections

### SECURITY MEASURES

- ✅ All communications with OpenRouter use **encrypted HTTPS (TLS 1.3+)**
- ✅ Your API key is never transmitted to our own servers (we have none)
- ✅ We don't store query logs
- ✅ Zero-server architecture: everything is client-side

**Your responsibility:** Protect your device with a password, Face ID, or Touch ID. The security of your API key also depends on the physical security of your device.

### DATA DELETION

You can delete all data stored by the application at any time:

**Method 1 - Within the app:**
1. Open IAGota
2. Go to Settings (⚙️ icon)
3. Scroll to "Danger Zone"
4. Tap "Delete API Key"
5. Confirm action

**Method 2 - Uninstall the app:**
1. Long-press the IAGota icon
2. Select "Remove App"
3. Confirm deletion

**Effect:** This will permanently delete your API key from your device. We cannot recover it because we never store it on servers.

---

## YOUR RIGHTS

### GENERAL RIGHTS

You have the right to:
- **Access:** View your stored API key (shown partially in Settings for security)
- **Delete:** Remove your API key at any time from the app
- **Portability:** Your API key is portable; you can copy and use it in other applications
- **Revoke:** You can revoke or regenerate your API key from the OpenRouter dashboard

### RIGHTS UNDER GDPR (EUROPEAN UNION)

If you reside in the European Union, you have additional rights under GDPR:
- **Right to be forgotten:** You can request deletion of your data (applicable to data on OpenRouter)
- **Right to data portability:** You can export your data (in our case, only your API key)
- **Right to restrict processing:** You can limit how your data is processed
- **Right to object:** You can object to processing of your data (you can stop using the app)
- **Right not to be subject to automated decisions:** Applicable if AI makes decisions that legally affect you

### RIGHTS UNDER CCPA (CALIFORNIA, USA)

If you reside in California, you have rights under CCPA:
- **Right to know:** What categories of personal information we collect (described in this policy)
- **Right to delete:** You can request deletion of information (use in-app feature)
- **Right to opt-out of sale:** NOT applicable - **We DO NOT sell your data**
- **Right to non-discrimination:** You won't receive discriminatory treatment for exercising your CCPA rights

---

## PRIVACY ARCHITECTURE (TECHNICAL DIAGRAM)

```
┌─────────────────────────────────────────────────────────────┐
│  YOUR iOS DEVICE                                            │
│                                                             │
│  ┌──────────────────────────────────────────────┐          │
│  │ IAGota App                                   │          │
│  │                                              │          │
│  │  • API Key (UserDefaults - local only)      │          │
│  │  • Query: "chicken"                         │          │
│  │                                              │          │
│  └──────────────────┬───────────────────────────┘          │
│                     │                                       │
│                     │ Encrypted HTTPS (TLS 1.3)            │
└─────────────────────┼───────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│  OPENROUTER API                                             │
│                                                             │
│  • Receives: "chicken" + API Key                           │
│  • Does NOT receive: name, email, location, etc.           │
│  • Processes with AI (GPT-4o, Claude, DeepSeek)           │
│  • Returns: { purine: "low", mg: "~70" }                  │
│  • Zero Data Retention (ZDR) enabled                       │
│                                                             │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      │ Encrypted HTTPS
                      ▼
┌─────────────────────────────────────────────────────────────┐
│  YOUR iOS DEVICE                                            │
│                                                             │
│  ┌──────────────────────────────────────────────┐          │
│  │ IAGota App                                   │          │
│  │                                              │          │
│  │  • Displays result on screen                │          │
│  │  • Does NOT save query                      │          │
│  │  • Does NOT save response                   │          │
│  │                                              │          │
│  └──────────────────────────────────────────────┘          │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────┐
│  OUR SERVERS                │
│                             │
│  ❌ DO NOT EXIST            │
│  ❌ WE STORE NOTHING        │
└─────────────────────────────┘
```

---

## CHANGES TO THIS POLICY

We reserve the right to occasionally update this Privacy Policy to reflect changes in our practices, legal requirements, or application improvements. We will notify you of significant changes through:

- Updating the "Last updated" date at the top of this document
- A prominent notice within the application for material changes affecting your rights
- If required by law, we will request your renewed consent for changes

Continued use of the application after publication of changes constitutes your acceptance of the updated Privacy Policy. We recommend reviewing this document periodically.

---

## MINORS

This application is not designed or directed at persons under 13 years of age. We do not intentionally collect personal information from minors under 13.

If you are a parent or legal guardian and discover that your child under 13 has provided information through the application, please contact us immediately at **iagota@00b.tech** so we can delete such information.

---

## CONTACT

If you have questions, comments, or concerns about this Privacy Policy, how we handle your data, or if you wish to exercise any of your rights, you can contact us through:

- **Primary email:** iagota@00b.tech
- **GitHub repository (issues):** https://github.com/686f6c61/IAGota/issues

**Committed response time:** We strive to respond to all inquiries within a maximum of 7 business days. For urgent requests related to data deletion or exercise of rights under GDPR/CCPA, we will respond within 72 hours.

---

## 💙 TRANSPARENCY: OPEN SOURCE CODE

IAGota is an open-source application. This means anyone with technical knowledge can inspect exactly how the application works, verify that we comply with what is stated in this Privacy Policy, and audit the code's security.

**Complete source code:** https://github.com/686f6c61/IAGota

This transparency is our best guarantee that we truly respect your privacy as we declare.

---

**IAGota - Version 1.0.0**
© 2025 - Developed with ❤️ for the community of people who care about their uric acid
*This Privacy Policy is subject to the laws of Spain and the European Union.*
🇪🇸 Application developed in Spain | 🇪🇺 GDPR & LOPD-GDD Compliant
