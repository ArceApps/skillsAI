---
name: android-test-runner
description: Ejecuta tests de Android usando Gradle Wrapper, interpreta los resultados y genera un reporte en Español con sugerencias de corrección.
version: 1.0.0
---

# Android Test Runner

Esta skill se encarga de la ejecución y verificación. Lanza los comandos de Gradle apropiados y traduce la salida técnica en información útil.

## 🎯 Objetivo
Ejecutar los tests creados y proporcionar un veredicto claro sobre su éxito o fracaso.

## ⚙️ Capacidades
1.  **Detección de Comando:** Determina si ejecutar `./gradlew testDebugUnitTest` (Unit) o `./gradlew connectedDebugAndroidTest` (Instrumentation).
2.  **Ejecución Segura:** Utiliza el wrapper de Gradle (`./gradlew`) presente en el proyecto.
3.  **Análisis de Logs:** Lee la salida estándar (stdout) y de error (stderr) para encontrar StackTraces y fallos de aserción.

## 📥 Entrada Esperada
- Ruta del archivo de test o nombre de la clase de test a ejecutar.
- Directorio raíz del proyecto Android.

## 📤 Salida Esperada
Un reporte en **Español** que incluya:
1.  **Resumen:** Total ejecutados, Pasados, Fallados.
2.  **Detalle de Fallos:** Si hubo errores, explicar *por qué* falló (ej: "Se esperaba 'Success' pero se obtuvo 'Error'").
3.  **Sugerencia:** Si el fallo parece ser de lógica o de configuración del test, ofrecer una posible solución.

## Comandos Típicos
- Ejecutar todo el módulo: `./gradlew :app:testDebugUnitTest`
- Ejecutar clase específica: `./gradlew :app:testDebugUnitTest --tests "com.example.MyTestClass"`

## Manejo de Errores Comunes
- *ClassNotFound:* Verificar el paquete y la ruta del archivo.
- *No tests found:* Verificar anotaciones `@Test`.
- *Compilation Error:* Reportar el error de sintaxis al usuario para que solicite corrección al `generator`.
