```text
 ██████╗ ██████╗██╗  ██╗
██╔════╝██╔════╝╚██╗██╔╝
██║     ██║      ╚███╔╝
██║     ██║      ██╔██╗
╚██████╗╚██████╗██╔╝ ██╗
 ╚═════╝ ╚═════╝╚═╝  ╚═╝
```

<!-- ¿Prefieres un logo en vez de arte ASCII? Crea assets/logo-light.svg y
     assets/logo-dark.svg, borra el bloque de arriba y descomenta esto:
<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/logo-dark.svg">
    <source media="(prefers-color-scheme: light)" srcset="assets/logo-light.svg">
    <img alt="ccx logo" src="assets/logo-light.svg" width="200">
  </picture>
</div>
-->

<div align="center">

<em>Varias cuentas de Claude Code en el mismo PC, sin fricción.</em>

<p>

<a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-222222?style=flat-square" alt="MIT license"></a>
<img src="https://img.shields.io/badge/shell-POSIX%20sh-222222?style=flat-square&logo=gnu-bash&logoColor=white" alt="POSIX sh">
<img src="https://img.shields.io/badge/platform-Linux%20%7C%20Windows-222222?style=flat-square" alt="Platforms">
<img src="https://img.shields.io/badge/dependencies-none-222222?style=flat-square" alt="No dependencies">
<a href="#-contribuir"><img src="https://img.shields.io/badge/PRs-welcome-222222?style=flat-square" alt="PRs welcome"></a>
<a href="https://github.com/TU-USUARIO/ccx/stargazers"><img src="https://img.shields.io/github/stars/TU-USUARIO/ccx?style=flat-square&color=222222&label=stars" alt="Stars"></a>

</p>

<sub>
<a href="#-features">Features</a> ·
<a href="#-quick-start">Quick start</a> ·
<a href="#-instalación">Instalación</a> ·
<a href="#-comandos">Comandos</a> ·
<a href="#-cómo-funciona">Cómo funciona</a> ·
<a href="#%EF%B8%8F-limitaciones">Limitaciones</a>
</sub>

</div>

<!-- Cuando grabes el demo (ver README del repo / guía), descomenta esto:
<p align="center">
  <img src="assets/demo.gif" alt="Demo de ccx: añadir cuentas, cambiar de cuenta y abrir un proyecto" width="700">
</p>
-->

---

**ccx** gestiona varias cuentas y sesiones de **Claude Code** en una sola máquina. Claude Code guarda su configuración, historial, plugins y credenciales de login en un directorio; con la variable `CLAUDE_CONFIG_DIR`, ese directorio se puede cambiar. ccx le da a **cada cuenta su propio directorio aislado**, recuerda tus proyectos locales (nombre → ruta → cuenta), mantiene una cuenta activa y exporta la variable correcta antes de lanzar `claude`. Un solo script POSIX `sh`, cero dependencias, Linux y Windows (Git Bash / WSL).

## ✨ Features

| | Feature | Qué hace |
|---|---|---|
| 🔑 | **Cuentas aisladas** | Cada cuenta vive en su propio `CLAUDE_CONFIG_DIR`: settings, historial, plugins y login separados. |
| 🔀 | **Cambio instantáneo** | `ccx account use <nombre>` y la siguiente sesión de Claude arranca con esa identidad. |
| 📁 | **Registro de proyectos** | Asocia cada proyecto local (nombre → ruta → cuenta) y ábrelo con un comando. |
| 🚀 | **Atajo de apertura** | `ccx <proyecto>` entra a la carpeta y lanza Claude con la cuenta correcta. |
| 🧠 | **`ccx init`** | Lanza Claude con un prompt para que genere los archivos de memoria del proyecto (`CLAUDE.md`, `.claude/rules/*.md`). |
| 🩺 | **`ccx doctor`** | Diagnostica tu instalación y detecta problemas de configuración. |
| 🪶 | **Sin dependencias** | Un único script POSIX `sh`. Nada de Node, Python ni paquetes externos. |
| 🖥️ | **Multiplataforma** | Linux y Windows vía Git Bash o WSL. |

## 🚀 Quick start

```sh
# 1. Añade tus cuentas (cada una se aísla en su propio directorio)
ccx account add trabajo
ccx account add personal

# 2. Elige la cuenta activa
ccx account use personal

# 3. Registra un proyecto local
ccx project add miapp ~/code/miapp

# 4. Ábrelo: entra a la carpeta y lanza Claude con la cuenta correcta
ccx miapp
```

Eso es todo. `ccx` exporta el `CLAUDE_CONFIG_DIR` adecuado y arranca `claude` por ti.

## 📦 Instalación

```sh
git clone https://github.com/TU-USUARIO/ccx.git
cd ccx
sh install.sh
```

El instalador copia `ccx` a `~/.ccx/bin`. Añade esa carpeta a tu `PATH` si el instalador no lo hace por ti:

```sh
export PATH="$HOME/.ccx/bin:$PATH"   # añádelo a tu ~/.bashrc, ~/.zshrc o ~/.profile
```

Verifica la instalación:

```sh
ccx doctor
```

> [!NOTE]
> Requiere [Claude Code](https://code.claude.com/docs/en/setup) instalado y accesible como `claude`.

<details>
<summary><strong>Notas para Windows</strong></summary>

ccx es un script POSIX `sh`, así que en Windows se ejecuta dentro de **Git Bash** o **WSL**. Clona e instala desde esa misma terminal. Las rutas de proyecto deben ser las que vea el shell POSIX (por ejemplo `/c/Users/tu-usuario/code/miapp` en Git Bash, o rutas de Linux en WSL).

</details>

## 🧭 Comandos

| Comando | Descripción |
|---|---|
| `ccx account add <nombre>` | Crea una cuenta con su directorio de config aislado y abre el login. |
| `ccx account ls` | Lista las cuentas y marca la activa. |
| `ccx account use <nombre>` | Define la cuenta activa. |
| `ccx account which` | Muestra qué cuenta está activa. |
| `ccx account rm <nombre>` | Elimina una cuenta. |
| `ccx project add <nombre> [ruta]` | Registra un proyecto (nombre → ruta → cuenta). |
| `ccx project ls` | Lista los proyectos registrados. |
| `ccx project rm <nombre>` | Elimina un proyecto del registro. |
| `ccx open <proyecto>` | Entra a la carpeta del proyecto y lanza Claude con su cuenta. |
| `ccx <proyecto>` | Atajo de `ccx open <proyecto>`. |
| `ccx run [cuenta]` | Lanza Claude en la carpeta actual con la cuenta activa (o la indicada). |
| `ccx init [proyecto] [--headless]` | Lanza Claude para generar los archivos de memoria del proyecto. |
| `ccx doctor` | Diagnostica la instalación y la configuración. |
| `ccx version` | Muestra la versión. |
| `ccx help` | Muestra la ayuda. |

## 🔧 Cómo funciona

Claude Code lee la variable `CLAUDE_CONFIG_DIR`. Si está definida, guarda **todo** su estado (settings, historial, plugins y credenciales de login) dentro de ese directorio. ccx aprovecha esto para dar a cada cuenta un sandbox propio y apuntar `claude` al correcto antes de lanzarlo.

```
            ccx (un solo script sh)
                     │
      ┌──────────────┼───────────────┐
      ▼              ▼                ▼
  cuentas        proyectos       cuenta activa
  (registro)     (registro)       (puntero)
      │              │                │
      │   nombre → ruta → cuenta      │
      └──────────────┴────────────────┘
                     │
           ccx open <proyecto>
                     │
       export CLAUDE_CONFIG_DIR=~/.ccx/accounts/<cuenta>
                     │
                     ▼
                 claude  ──▶  usa settings, historial,
                              plugins y login de ESA cuenta
```

Cambiar de cuenta es, literalmente, apuntar `CLAUDE_CONFIG_DIR` a otra carpeta. Nada se mezcla entre cuentas.

## ⚠️ Limitaciones

> [!IMPORTANT]
> **Los logins keyless de Claude Console no se aíslan.** El aislamiento de ccx se basa en `CLAUDE_CONFIG_DIR`, que cubre las credenciales que Claude Code guarda en ese directorio. Un login "keyless" de Claude Console se almacena fuera de ese directorio, así que queda fuera del sandbox y se comparte entre cuentas. Las suscripciones claude.ai (Pro/Max/Team) y las API keys sí se aíslan por completo.

- Requiere que `claude` (Claude Code) ya esté instalado y disponible en el `PATH`.
- En Windows necesitas un entorno POSIX (Git Bash o WSL); no corre en `cmd.exe` ni PowerShell nativo.
- El aislamiento llega hasta donde llega `CLAUDE_CONFIG_DIR`: lo que Claude Code guarde fuera de ese directorio no queda separado por cuenta.

## 🤝 Contribuir

Los PRs son bienvenidos. Antes de enviar:

- Mantén el estilo **POSIX `sh`** (nada de bashismos): el objetivo es correr en cualquier `sh`.
- Pasa [`shellcheck`](https://www.shellcheck.net/) sobre el script.
- Prueba en Linux y, si puedes, en Git Bash/WSL.

Lee [CONTRIBUTING.md](CONTRIBUTING.md) para más detalles y abre un issue si encuentras un bug o tienes una idea.

## 📄 Licencia

[MIT](LICENSE) © Juan Diego Escobar ([@Trivi](https://github.com/TU-USUARIO))

<div align="center">
<sub>Hecho con ☕ por <a href="https://github.com/TU-USUARIO">@Trivi</a></sub>
</div>
