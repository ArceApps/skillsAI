---
name: test-android
description: Genera y ejecuta tests unitarios/instrumentales para Android usando la suite nativa.
usage: /test-android [NombreClase o Funcionalidad]
author: Gemini Agent
version: 1.0
---

# Instrucción para el Agente

Cuando el usuario ejecute este comando, debes realizar las siguientes acciones secuenciales sin esperar confirmación entre pasos intermedios, a menos que ocurra un error crítico:

1.  **Leer Objetivo:** Identifica la clase o funcionalidad especificada en `$ARGUMENTS`. Si es un nombre de archivo, léelo.
2.  **Orquestar:** Inicia el flujo de trabajo definido en `qa-testing/android-native-suite/ORCHESTRATION_PROMPT.md`.
    *   Invoca `android-test-planner` para crear la estrategia.
    *   Invoca `android-test-generator` para crear el código.
    *   Guarda el archivo de test generado (`write_file`).
    *   Invoca `android-test-runner` para validar.
3.  **Reportar:** Presenta el resultado final al usuario.
