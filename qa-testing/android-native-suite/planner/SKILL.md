---
name: android-test-planner
description: Diseña planes de test priorizando Unit Tests (JVM). Solo recomienda instrumentación si es estrictamente necesario para UI o navegación.
version: 1.2.0
---

# Android Test Planner

Esta skill actúa como el arquitecto de pruebas con un sesgo fuerte hacia la eficiencia y velocidad (Unit Testing).

## 🎯 Política "Unit Test First"
1.  **Por defecto:** Todo se prueba con **Unit Tests (JUnit + Mockk)** en la JVM local.
2.  **Instrumentation (Espresso):** Solo se recomienda si:
    *   El usuario lo pide expresamente.
    *   Se requiere validar visualmente la posición de elementos o colores.
    *   Se requiere probar flujos de navegación real entre Activities/Fragments.
    *   No hay forma de mockear una dependencia del SDK de Android.

## 📤 Salida Esperada (Formato Markdown)
Un documento en **Español** que contenga:

1.  **Tipo de Test:** (Priorizar Unit Test siempre que sea posible).
2.  **Justificación:** Por qué se elige Unit o Instrumentation (ej: "Se elige Unit Test para máxima velocidad de ejecución").
3.  **Ruta de Destino Sugerida:**
    *   `src/test/java/...` para Unit Tests.
    *   `src/androidTest/java/...` para Instrumentation.
4.  **Matriz de Casos de Prueba:** Enfocada en lógica, estados y flujos de datos.

## 🧠 Lógica de Decisión
- **Lógica de negocio / ViewModel / Repository:** 100% Unit Test.
- **Formateadores / Validadores / Utils:** 100% Unit Test.
- **UI básica / Mostrar datos:** Intentar Unit Test verificando el estado de la UI (StateFlow). Solo usar Espresso si hay interacciones táctiles complejas.
