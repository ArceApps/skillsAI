# Flujo de Trabajo de Testing Android Nativo

Este documento describe el "Mega-Prompt" o flujo de orquestación para crear y validar tests en Android de forma autónoma.

## 🔄 El Ciclo de Creación de Tests

Para generar un test robusto, sigue estrictamente este orden de ejecución invocando a las skills correspondientes.

### Paso 1: Planificación (Planner)
**Skill:** `android-test-planner`
**Instrucción:**
> "Analiza el siguiente archivo de código [RUTA_ARCHIVO_FUENTE]. Actúa como `android-test-planner` y genera un plan de pruebas detallado en Español. Identifica si necesitamos Unit Tests o Instrumentation Tests, qué dependencias mockear y lista los casos de prueba incluyendo casos borde de Android."

### Paso 2: Generación (Generator)
**Skill:** `android-test-generator`
**Instrucción:**
> "Tomando como base el plan generado en el paso anterior y el código fuente original, actúa como `android-test-generator`. Escribe el código completo del test en Kotlin. Recuerda: código en Inglés, comentarios en Español. Usa Mockk y JUnit/Espresso según corresponda. Entrégame solo el bloque de código para guardar."

### Paso 3: Persistencia
**Acción Manual/Automática:**
> Guarda el código generado en la ruta correcta dentro de `src/test/java/...` o `src/androidTest/java/...` según el paquete del archivo original. Asegúrate de que el nombre del archivo termine en `Test.kt`.

### Paso 4: Ejecución y Verificación (Runner)
**Skill:** `android-test-runner`
**Instrucción:**
> "Actúa como `android-test-runner`. Ejecuta el test que acabamos de crear usando Gradle. El comando debe apuntar específicamente a esta clase (usa `--tests`). Analiza la salida y dame un reporte en Español. Si hay errores de compilación o fallos de aserción, explícalos detalladamente."

### Paso 5: Iteración (Si falla)
Si el Paso 4 reporta errores:
1.  Pide al `android-test-generator` que corrija el código basándose en el error del `runner`.
2.  Sobrescribe el archivo.
3.  Vuelve al Paso 4.

---

## Ejemplo de Prompt Integrado para el Usuario

"Quiero crear tests para `ProfileViewModel.kt`. Usa la suite `android-native-suite` para planificar, generar y ejecutar los tests automáticamente. Asegúrate de cubrir los casos de error de red."
