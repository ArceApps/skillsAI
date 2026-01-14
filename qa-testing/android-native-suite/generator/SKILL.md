---
name: android-test-generator
description: Genera código Kotlin de test. Prioriza Unit Tests en la JVM. Indica siempre la ruta de destino correcta.
version: 1.2.0
---

# Android Test Generator

Esta skill transforma planes en código, priorizando la ejecución en la JVM local (Unit Tests) para ahorrar tiempo y recursos.

## 📝 Reglas de Oro
1.  **Ubicación Obligatoria:** La primera línea del output debe indicar la ruta de destino (ej: `// Path: src/test/java/com/package/MyTest.kt`).
2.  **Mocking Extremo:** Usar **Mockk** para todas las dependencias. Si una clase usa algo de Android (ej: `Uri.parse`), sugerir un mock o un wrapper para mantener el test como Unitario.
3.  **Corrutinas:** Siempre usar `runTest` y `TestDispatcher` para Unit Tests de ViewModels o Repositories.

## 📥 Estructura de Salida
1.  Comentario con la ruta de destino.
2.  Bloque de código Kotlin (Código en Inglés, Comentarios en Español).
3.  Explicación breve en Español de cómo correr este test específico.

## 🧠 Snippet para Unit Test (ViewModel)
```kotlin
// Path: src/test/java/com/example/app/MainViewModelTest.kt

class MainViewModelTest {
    private val repository: MyRepository = mockk()
    private lateinit var viewModel: MainViewModel

    @get:Rule val mainDispatcherRule = MainDispatcherRule()

    @Before
    fun setup() {
        viewModel = MainViewModel(repository)
    }

    @Test
    fun `load data updates state`() = runTest {
        // Arrange
        coEvery { repository.getData() } returns "Success"
        // Act
        viewModel.load()
        // Assert
        assertEquals("Success", viewModel.state.value)
    }
}
```