---
name: android-test-generator
description: Genera código de test en Kotlin para Android usando Robot Pattern, Mockk y Espresso. Código en Inglés, comentarios en Español.
version: 1.1.0
---

# Android Test Generator

Esta skill es el programador experto. Transforma un plan de pruebas en código Kotlin ejecutable, siguiendo las mejores prácticas de Android Nativo.

## 🎯 Objetivo
Generar una clase de test completa y compilable basándose en el plan proporcionado.

## 📝 Reglas de Codificación
1.  **Idioma:** Código (nombres variables/fun) en **Inglés**. KDoc/Comentarios en **Español**.
2.  **Patrones de Diseño:**
    *   Para **UI Tests (Espresso)** complejos, implementar el **Robot Pattern** (clases auxiliares para abstraer la interacción con la vista).
    *   Para **Unit Tests**, usar `Given-When-Then` o `Arrange-Act-Assert`.
3.  **Frameworks:**
    *   **Unit:** JUnit 4/5, Mockk, Kotlin Coroutines Test (`runTest`, `StandardTestDispatcher`).
    *   **UI:** Espresso, AndroidX Test (Core, Rules, Runner).
    *   **Aserciones:** Truth (Google) preferido, o JUnit Assert.

## 🧠 Snippets Recomendados (Casos Borde)

### Corrutinas (Main Dispatcher)
```kotlin
@get:Rule val mainDispatcherRule = MainDispatcherRule()
```

### Robot Pattern (Ejemplo)
```kotlin
fun login(func: LoginRobot.() -> Unit) = LoginRobot().apply(func)
class LoginRobot {
    fun typeEmail(email: String) { /* Espresso ViewAction */ }
    fun clickLogin() { /* Espresso ViewAction */ }
    fun matchError(text: String) { /* Espresso ViewAssertion */ }
}
```

## 📥 Entrada Esperada
- Código fuente original.
- Plan de pruebas de `android-test-planner`.

## 📤 Salida Esperada
Un bloque de código Kotlin listo para guardar. Si se usa Robot Pattern, incluir la clase Robot dentro del mismo archivo o indicar que se cree separada.

## Ejemplo de Código Generado

```kotlin
@Test
fun `login with invalid credentials shows error`() {
    login {
        typeEmail("bad@user.com")
        typePassword("wrong")
        clickLogin()
        matchError("Invalid credentials")
    }
}
```
