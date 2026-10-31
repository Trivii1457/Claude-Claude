# ccx

**Varias cuentas de Claude Code en el mismo PC, proyectos locales y memoria autogenerada — todo desde la terminal.**

`ccx` es un lanzador minimalista (un único script POSIX, sin dependencias) que te deja:

- Tener **varias cuentas / sesiones de Claude Code** aisladas en la misma máquina, sin tocar configuraciones a mano.
- **Registrar proyectos locales** y abrir cada uno con la cuenta correcta en un solo comando.
- Pedirle al **propio Claude que genere los archivos de memoria** (`CLAUDE.md`, `.claude/rules/*.md`) de un proyecto.

Funciona en **Linux**, **WSL** y **Git Bash** (Windows).

---

## ¿Cómo funciona por debajo?

Claude Code respeta la variable de entorno **`CLAUDE_CONFIG_DIR`**. Cuando está definida, guarda *todo* bajo ese directorio en lugar de `~/.claude`: settings, historial de sesiones, plugins **y las credenciales de login**. Dándole a cada cuenta su propio directorio, cada una mantiene su propia sesión de claude.ai o su propia API key, de forma independiente.

`ccx` no es más que un envoltorio ergonómico sobre eso: mantiene un directorio por cuenta, un registro de proyectos, y exporta la variable correcta antes de lanzar `claude`. Nada de magia ni parches.

```
~/.config/ccx/
├── accounts/
│   ├── personal/      ← esto es un CLAUDE_CONFIG_DIR
│   └── trabajo/       ← y esto otro
├── projects.tsv       ← nombre  →  ruta  →  cuenta
└── active             ← cuenta por defecto
```

> **macOS:** aunque el objetivo son Linux y Windows, también funcionaría en macOS. Claude Code indexa la entrada del Keychain según `CLAUDE_CONFIG_DIR`, así que el aislamiento se mantiene allí también.

---

## Instalación

```sh
git clone https://github.com/<tu-usuario>/ccx.git
cd ccx
sh install.sh
```

El instalador copia el script a `~/.ccx/bin`. Si ese directorio no está en tu `PATH`, te lo indicará:

```sh
export PATH="$HOME/.ccx/bin:$PATH"   # añádelo a ~/.bashrc o ~/.zshrc
```

Comprueba que todo está bien:

```sh
ccx doctor
```

> Requiere [Claude Code](https://code.claude.com/docs/en/setup) instalado y accesible como `claude`.
> En **Windows**, usa `ccx` dentro de **Git Bash** o **WSL** (donde `claude` queda en el PATH).

---

## Uso

### 1. Crear cuentas

```sh
ccx account add personal     # crea la cuenta y abre el login en el navegador
ccx account add trabajo
ccx account ls               # lista las cuentas; * marca la activa
```

Cada `account add` abre Claude Code una vez para que inicies sesión. Al terminar, escribe `/exit`.

### 2. Registrar proyectos

```sh
cd ~/code/mi-api
ccx project add mi-api --account trabajo    # usa la ruta actual
ccx project add web ~/code/landing --account personal
ccx project ls
```

### 3. Abrir un proyecto

```sh
ccx open mi-api        # entra a la carpeta y lanza Claude con la cuenta 'trabajo'
ccx mi-api             # atajo equivalente
ccx open mi-api -- --model claude-opus-5-5   # pasa flags a claude tras el --
```

¿Solo quieres lanzar Claude aquí con una cuenta, sin registrar nada?

```sh
ccx run personal
ccx run                # usa la cuenta activa
```

### 4. Generar los archivos de memoria con Claude

```sh
ccx init mi-api            # Claude analiza el repo y crea CLAUDE.md (+ rules si aplica)
ccx init .                 # sobre la carpeta actual
ccx init mi-api --headless # sin sesión interactiva (claude -p)
```

Usa la plantilla de [`templates/bootstrap-prompt.md`](templates/bootstrap-prompt.md); edítala a tu gusto.

---

## Comandos

| Comando | Qué hace |
|---|---|
| `ccx account add <n>` | Crea la cuenta y abre el login |
| `ccx account ls` | Lista las cuentas (`*` = activa) |
| `ccx account use <n>` | Fija la cuenta activa |
| `ccx account which` | Muestra la cuenta activa |
| `ccx account rm <n>` | Elimina la cuenta y su login |
| `ccx project add <n> [ruta] [--account <c>]` | Registra un proyecto |
| `ccx project ls` | Lista los proyectos |
| `ccx project rm <n>` | Quita el proyecto del registro |
| `ccx open <p> [-- ...]` | Abre Claude en el proyecto, con su cuenta |
| `ccx <p>` | Atajo de `ccx open <p>` |
| `ccx run [cuenta] [-- ...]` | Abre Claude en la carpeta actual |
| `ccx init [p\|.] [--headless]` | Genera los archivos de memoria con Claude |
| `ccx doctor` | Diagnóstico del entorno |
| `ccx version` · `ccx help` | Versión / ayuda |

---

## Variables de entorno

| Variable | Por defecto | Para qué |
|---|---|---|
| `CCX_HOME` | `~/.config/ccx` | Dónde guarda `ccx` sus datos |
| `CCX_PREFIX` | `~/.ccx` | Dónde instala el script `install.sh` |
| `NO_COLOR` | — | Si está definida, desactiva colores |

---

## Limitaciones conocidas

- **Logins "keyless" de Claude Console** (perfiles de Anthropic): Claude Code los guarda *fuera* de `CLAUDE_CONFIG_DIR`, así que ese tipo concreto de sesión no se aísla entre cuentas. Las suscripciones **claude.ai (Pro/Max/Team)** y las **API keys** sí se aíslan por completo.
- En **Windows nativo** (cmd/PowerShell) hace falta un wrapper aparte; por ahora, úsalo en Git Bash o WSL.

---

## Licencia

MIT © 2026 Juan Diego Escobar ([@Trivi](https://github.com/))
