---
name: android-test-runner
description: Guía maestra y ejecutor de tests Android. Maneja Gradle, ADB, variantes de build y reportes. Proporciona feedback en Español.
version: 1.2.0
---

# Android Test Runner

Esta skill es el experto en ejecución. Conoce a fondo el ciclo de vida de compilación de Android y cómo extraer resultados de las herramientas de línea de comandos.

## 📋 Prerrequisitos del Entorno
Antes de ejecutar, el agente debe validar o informar al usuario sobre:
1.  **JAVA_HOME:** Debe apuntar a la versión de Java compatible con el proyecto (ej: Java 17 para AGP 8.0+).
2.  **ANDROID_HOME:** Ruta al SDK de Android configurada.
3.  **Dispositivo:** Para tests de instrumentación, debe haber un emulador iniciado o un dispositivo físico conectado (`adb devices`).

## ⚙️ Guía de Comandos Gradle (Referencia Maestra)

### 1. Unit Tests (Corren en la JVM de la máquina local)
Son rápidos y no requieren emulador.
- **Todo el proyecto:** `./gradlew test`
- **Módulo específico:** `./gradlew :module_name:testDebugUnitTest`
- **Clase específica:** `./gradlew :app:testDebugUnitTest --tests "com.package.MyClassTest"`
- **Método específico:** `./gradlew :app:testDebugUnitTest --tests "com.package.MyClassTest.myMethod"`

### 2. Instrumentation Tests (Corren en dispositivo/emulador)
Requieren una APK de test y una APK de la app.
- **Todo el proyecto:** `./gradlew connectedAndroidTest`
- **Módulo específico:** `./gradlew :app:connectedDebugAndroidTest`
- **Clase específica:** `./gradlew :app:connectedDebugAndroidTest -Pandroid.testInstrumentationRunnerArguments.class=com.package.MyUITest`

### 3. Comandos de Utilidad
- **Limpiar y testear:** `./gradlew clean test`
- **Forzar ejecución (ignorar cache):** `./gradlew test --rerun-tasks`
- **Ver reporte detallado:** Los reportes HTML se generan en `app/build/reports/tests/testDebugUnitTest/index.html`.

## 🚀 Optimización de Tests de UI (ADB)
Para evitar que las animaciones hagan fallar los tests de Espresso, se recomienda ejecutar estos comandos antes de los tests de UI:
```bash
adb shell settings put global window_animation_scale 0
adb shell settings put global transition_animation_scale 0
adb shell settings put global animator_duration_scale 0
```

## 📥 Entrada Esperada
- Nombre de la clase o funcionalidad.
- Variante de build (por defecto `debug`).

## 📤 Salida Esperada (Reporte en Español)
1.  **Estado Global:** ✅ ÉXITO / ❌ FALLO.
2.  **Métricas:** Tiempo total, número de tests pasados/fallados.
3.  **Ubicación del Reporte:** Ruta local al archivo HTML para que el usuario lo abra.
4.  **Análisis de Errores:**
    *   Si es error de compilación: Mostrar el error de Kotlin.
    *   Si es fallo de test: Mostrar el `expected` vs `actual`.
    *   Si es error de dispositivo: Informar si el emulador se desconectó.

## 🛠️ Manejo de Variantes (Build Variants)
Si el proyecto tiene sabores (flavors), el comando cambia:
- Ejemplo: `./gradlew testProdDebugUnitTest` o `./gradlew testDevDebugUnitTest`.
- El agente debe usar `tasks --all` si no está seguro del nombre de la tarea de test.
