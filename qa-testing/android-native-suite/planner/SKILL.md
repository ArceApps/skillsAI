---
name: android-test-planner
description: Analiza código Kotlin Android y diseña una estrategia de pruebas detallada en Español, identificando casos de uso, casos borde y matriz de dispositivos.
version: 1.1.0
---

# Android Test Planner

Esta skill actúa como el arquitecto de pruebas. Su objetivo es analizar una clase o funcionalidad de Android y producir un plan de pruebas exhaustivo antes de escribir código.

## 🎯 Objetivo
Analizar el código fuente proporcionado (Activity, Fragment, ViewModel, UseCase, Repository, Utility) y diseñar un plan de pruebas unitarias o de instrumentación.

## 📥 Entrada Esperada
- Código fuente Kotlin de la clase a probar.
- Contexto opcional sobre la arquitectura (MVVM, Clean Architecture, etc.).

## 📤 Salida Esperada (Formato Markdown)
Un documento en **Español** que contenga:

1.  **Tipo de Test Recomendado:** Unit Test (JUnit/Mockk) vs Instrumentation Test (Espresso).
2.  **Dependencias a Mockear:** Lista de clases que necesitan ser simuladas (Mocks/Spies).
3.  **Matriz de Casos de Prueba:**
    *   **Camino Feliz (Happy Path):** Flujo normal y esperado.
    *   **Casos de Error:** Errores de red, datos nulos, excepciones lanzadas.
    *   **Casos Borde Android:**
        *   Rotación de pantalla y recreación de configuración.
        *   Modo Avión / Sin conexión.
        *   Permisos denegados.
        *   Modo Oscuro/Claro.
4.  **Estrategia de Dispositivos (Solo para Instrumentation):**
    *   Recomendación de API mínima y máxima para probar (ej: API 24 y API 34).
    *   Factores de forma relevantes (Tablet vs Phone).

## 🧠 Pautas de Análisis
- **ViewModel:** Priorizar Unit Tests. Verificar estados de UI (StateFlow/LiveData) y llamadas a repositorios.
- **Repository/UseCase:** Priorizar Unit Tests. Verificar lógica de negocio y mapeo de datos.
- **UI (Activity/Fragment):** Priorizar Instrumentation Tests (Espresso). Verificar visualización de elementos y navegación.
    *   *Sugerencia:* Si la UI es compleja, recomendar el **Robot Pattern**.
- **Utilidades:** Unit Tests exhaustivos de entradas/salidas.

## Ejemplo de Salida

```markdown
# Plan de Pruebas para: `LoginViewModel`

## Tipo: Unit Test
## Dependencias: `AuthRepository` (Mock), `AnalyticsTracker` (Mock)

## Casos de Prueba:
1.  **[Éxito]** `login(user, pass)` debe emitir estado `Loading` y luego `Success`.
2.  **[Error]** `login(user, pass)` debe emitir `Error` con mensaje "Credenciales inválidas".
3.  **[Borde]** `login` con red caída debe emitir `NetworkError` sin crashear.

## Estrategia de Dispositivos
No aplica (Unit Test corre en JVM local).
```