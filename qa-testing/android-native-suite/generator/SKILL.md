---
name: android-test-generator
description: Genera código de test en Kotlin (JUnit, Mockk, Espresso) para Android basado en un plan de pruebas, usando Inglés para el código y Español para comentarios.
version: 1.0.0
---

# Android Test Generator

Esta skill es el programador experto. Transforma un plan de pruebas en código Kotlin ejecutable, siguiendo las mejores prácticas de Android Nativo.

## 🎯 Objetivo
Generar una clase de test completa y compilable basándose en el plan proporcionado.

## 📝 Reglas de Codificación
1.  **Idioma del Código:** Todo el código (variables, funciones, clases) debe estar en **Inglés**.
2.  **Idioma de Comentarios:** KDoc y comentarios explicativos deben estar en **Español**.
3.  **Frameworks:**
    *   **Unit Tests:** JUnit 4 o 5, Mockk (para mocking), Kotlin Coroutines Test (para `suspend functions`).
    *   **Instrumentation:** Espresso, AndroidX Test Core.
    *   **Aserciones:** Truth (Google) o JUnit Assertions estándar.
4.  **Nomenclatura:** Usar `nombreFuncion_condicion_resultadoEsperado` o usar backticks si usas JUnit 5 (ej: `login with valid credentials returns success`).
5.  **Estructura:** Seguir el patrón `Arrange` (Preparar), `Act` (Actuar), `Assert` (Verificar).

## 📥 Entrada Esperada
- Código fuente original (para referencia de tipos).
- Plan de pruebas generado por `android-test-planner`.

## 📤 Salida Esperada
Un bloque de código Kotlin listo para guardar en un archivo `.kt`.

## Ejemplo de Código Generado

```kotlin
/**
 * Pruebas unitarias para [LoginViewModel].
 * Verifica el flujo de autenticación y manejo de errores.
 */
@OptIn(ExperimentalCoroutinesApi::class)
class LoginViewModelTest {

    private lateinit var viewModel: LoginViewModel
    private val authRepository: AuthRepository = mockk()
    
    @get:Rule
    val mainDispatcherRule = MainDispatcherRule() // Regla personalizada para Corrutinas

    @Before
    fun setup() {
        viewModel = LoginViewModel(authRepository)
    }

    @Test
    fun `login success updates state to LoggedIn`() = runTest {
        // Arrange (Preparar)
        coEvery { authRepository.login(any(), any()) } returns Result.success(User("id", "Name"))

        // Act (Actuar)
        viewModel.login("user", "pass")

        // Assert (Verificar)
        val state = viewModel.uiState.value
        assertTrue(state is LoginState.Success)
    }
}
```

```