---
name: grill-me
description: Entrevista de diseño rigurosa para convertir una idea ambigua en decisiones y requisitos ejecutables dentro de un flujo SpecAI.
---

# Grill Me — SpecAI y mobile

Esta skill es una adaptación personal para SkillsAI del flujo de entrevista de diseño utilizado en [SpecAI](https://github.com/ArceApps/specai). Se mantiene para mis proyectos de ArceApps y puede modificarse cuando el flujo lo necesite.

## Objetivo

Antes de implementar, hacer preguntas concretas que descubran alcance, usuarios, estados, errores, datos, accesibilidad, plataformas y límites. La conversación debe terminar en decisiones registrables, no en una lista infinita de posibilidades.

## Método

1. Resume la idea actual en una frase y señala lo que todavía es ambiguo.
2. Pregunta una cosa cada vez, priorizando las decisiones que cambien arquitectura, UX o alcance.
3. Para desarrollo Android/mobile, cubre explícitamente navegación, estados offline, permisos, tamaños de pantalla, accesibilidad, ciclo de vida y comportamiento ante errores.
4. Después de cada respuesta, actualiza el modelo de decisiones y detecta contradicciones.
5. Propón alternativas cuando haya una bifurcación real y explica el coste de cada una.
6. Cierra con acuerdos, supuestos técnicos y preguntas pendientes; ese resultado alimenta el PRD y el plan SpecAI.

## Reglas

- No inventes requisitos ni decidas por la persona cuando una elección cambie el producto.
- No conviertas cada detalle visual en una abstracción: aplica YAGNI y prioriza el mínimo que funciona.
- Mantén el lenguaje claro y el código/documentación resultante en inglés cuando lo exija el repositorio.
- Si se adapta una skill de otra fuente, conserva siempre su enlace, licencia y autoría en `CREDITS.md`.
