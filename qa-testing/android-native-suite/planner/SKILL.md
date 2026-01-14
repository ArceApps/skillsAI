---
name: android-test-planner
description: Analiza código Kotlin Android y diseña una estrategia de pruebas detallada en Español, identificando casos de uso, casos borde y dependencias.
version: 1.0.0
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
    *   **Casos Borde Android:** Rotación de pantalla (si aplica), recreación de proceso, modo oscuro, ciclo de vida.
4.  **Estrategia de Datos:** Qué datos de prueba (fixtures) se necesitan preparar.

## 🧠 Pautas de Análisis
- **ViewModel:** Priorizar Unit Tests. Verificar estados de UI (StateFlow/LiveData) y llamadas a repositorios.
- **Repository/UseCase:** Priorizar Unit Tests. Verificar lógica de negocio y mapeo de datos.
- **UI (Activity/Fragment):** Priorizar Instrumentation Tests (Espresso). Verificar visualización de elementos y navegación.
- **Utilidades:** Unit Tests exhaustivos de entradas/salidas.

## Ejemplo de Salida

```markdown
# Plan de Pruebas para: `LoginViewModel`

## Tipo: Unit Test
## Dependencias: `AuthRepository` (Mock), `AnalyticsTracker` (Mock)

## Casos de Prueba:
1.  **[Éxito]** `login(user, pass)` debe emitir estado `Loading` y luego `Success` cuando el repo responde OK.
2.  **[Error]** `login(user, pass)` debe emitir `Error` con mensaje "Credenciales inválidas" cuando el repo lanza `AuthException`.
3.  **[Validación]** `login("", "")` no debe llamar al repo y debe emitir estado `ValidationError`.
```
