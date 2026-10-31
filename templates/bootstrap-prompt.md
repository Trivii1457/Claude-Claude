Eres el asistente de este proyecto. Analiza el repositorio del directorio actual
y crea los archivos de memoria para Claude Code. Sigue estos pasos:

1. **Explora primero.** Lista los archivos y lee los que describan el proyecto
   (README, package.json, pyproject.toml, go.mod, Cargo.toml, composer.json,
   docker-compose.yml, Makefile, etc.). No inventes nada que no puedas verificar
   leyendo el código o la configuración.

2. **Crea un `CLAUDE.md` en la raíz** (máx. ~150 líneas) con estas secciones:
   - Qué es el proyecto (1-2 frases).
   - Stack y versiones principales.
   - Comandos clave: build, test, lint, run/dev.
   - Estructura de carpetas relevante.
   - Convenciones del código (estilo, imports, nombres, ubicación de tests).
   - Notas o gotchas importantes.
   Donde no tengas información fiable, deja la sección marcada como `TODO`.

3. **Si el proyecto es grande**, divide además por temas en `.claude/rules/*.md`
   (por ejemplo `testing.md`, `api.md`), usando frontmatter con `paths:` para que
   cada regla se cargue solo cuando se trabaje en los archivos que le competen.

Al terminar, muéstrame un resumen corto de los archivos que creaste y qué contienen.
