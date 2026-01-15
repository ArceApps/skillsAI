# Guía de Estilo de Documentación Android (Kotlin/Compose)

Esta guía define los estándares para documentar nuestro proyecto Android basado en Kotlin, Jetpack Compose, Hilt (DI) y MVVM Clean Architecture.

## Principios Generales

1.  **Idioma:** Español neutro y técnico.
2.  **Audiencia:** Otros desarrolladores del equipo (y tu "yo" del futuro).
3.  **Tono:** Directo, explicativo y centrado en el "Por qué".
4.  **Formato:** Markdown estándar para archivos `.md` y KDoc para código Kotlin.

## Estructura de la Documentación

### 1. Componentes UI (Jetpack Compose)

Al documentar funciones `@Composable`, enfócate en **qué hace** el componente y **qué estado necesita**.

*   **Nombre:** Debe ser un sustantivo (ej. `UserProfileScreen`, no `DrawUserProfile`).
*   **Parámetros:** Documenta los parámetros clave, especialmente los lambdas de eventos.
*   **Previews:** Menciona si el componente tiene `@Preview` y bajo qué condiciones (Light/Dark mode).

**Ejemplo:**
```markdown
### UserProfileCard

Tarjeta que muestra la información resumida del usuario.

**Uso:**
Se utiliza en el `DashboardScreen` y en listas de amigos.

**Estado:**
- Requiere un objeto `UserUiState` inmutable.
- No realiza llamadas de red internas; recibe datos por parámetros (State Hoisting).
```

### 2. ViewModels (MVVM)

Documenta la lógica de negocio y el flujo de datos.

*   **Responsabilidad:** ¿Qué pantalla o flujo controla?
*   **StateFlow:** Describe qué expone el `uiState`.
*   **Eventos:** Lista las acciones de usuario que procesa (ej. `onLoginClicked`).
*   **Inyección:** Menciona dependencias críticas inyectadas con Hilt (ej. `AuthRepository`).

**Plantilla:**
```markdown
## LoginViewModel

Gestiona el estado de la pantalla de inicio de sesión y la validación de formularios.

- **Scope:** `ViewModelScoped` (Hilt).
- **Dependencias:** `AuthRepository`, `AnalyticsTracker`.
- **Estado:** Expone `LoginUiState` (Loading, Success, Error).
```

### 3. Inyección de Dependencias (Hilt)

Para módulos (`@Module`), especifica el alcance y la provisión.

*   **InstallIn:** Aclara si es `SingletonComponent` (toda la app) o `ViewModelComponent`.
*   **Bindings:** Si usas `@Binds`, explica qué implementación concreta se está inyectando.

### 4. Persistencia (Room)

*   **Entities:** Describe las relaciones (`@Relation`) y claves foráneas.
*   **DAOs:** Explica si las consultas son síncronas (`suspend`) o reactivas (`Flow<>`).

## Reglas de Formato

*   **Negritas:** Usa **negrita** para nombres de elementos UI (ej. **Botón Aceptar**, **Pantalla de Ajustes**).
*   **Código:** Usa `backticks` para referencias a clases, variables o funciones (ej. `MainViewModel`, `onClick`).
*   **Notas:** Usa bloques de cita (`>`) para advertencias importantes o comportamientos edge-case.

## Malas Prácticas (Evitar)

*   ❌ **Describir el código línea por línea:** "Aquí declaramos una variable". (El código ya se lee solo).
*   ❌ **Anglicismos innecesarios:** "Hacer un fetch del request". (Mejor: "Obtener datos de la petición").
*   ❌ **Documentar Getters/Setters obvios.**

## Ejemplo de Documentación de Pull Request (PR)

```markdown
## Resumen
Se migró la pantalla de `SettingsActivity` (XML) a `SettingsScreen` (Compose).

## Cambios Clave
- **UI:** Nueva implementación con `LazyColumn` para las opciones.
- **ViewModel:** Se refactorizó `SettingsViewModel` para usar `Hilt` en lugar de factories manuales.
- **Nav:** Se agregó la ruta en `AppNavigation`.

## Verificación
- [ ] El switch de "Modo Oscuro" persiste la preferencia en DataStore.
- [ ] Probado en emulador Pixel 5 (API 33).
```
