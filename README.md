# FoxSpirit - Metroidvania Indie 🦊

Un Metroidvania indie que combina la exploración de **Hollow Knight**, la mecánica narrativa de **Undertale** y la temática de **Scavengers (Casualties Unknown)**.

**Protagonista:** Un espíritu de zorro en busca de redención, con habilidades especiales (esencias) y un sistema de combate cargable.

---

## 🎮 Características

### Mecánicas de Juego
- **Movimiento fluido** con dash y doble salto desbloqueables
- **Wall-cling y wall-jump** para exploración vertical
- **Ataque cargable** que cambia de poder según el tiempo de carga
- **Sistema de esencias** (fire, shadow, joy) que modifican el daño
- **Checkpoint y guardado** automático en bancos
- **Enemigos con IA** básica (patrulla, persecución, ataque)
- **Boss encounters** (El Tardígrado con fases)

### Escenas Principales
- **Main.tscn** - Menú principal (placeholder)
- **LevelTemplate.tscn** - Template de nivel con jugador
- **JardinDeAjolotes.tscn** - Nivel temático con ajolotes
- **Boss_Tardigrado.tscn** - Pelea del jefe Tardígrado
- **Player.tscn** - Controlador del jugador
- **UI.tscn** - Interfaz de esencia y habilidades

### Controles
- **A/D o Flechas** - Movimiento
- **Space** - Saltar / Doble salto
- **LShift** - Dash
- **X** - Ataque (mantén para cargar)
- **E** - Cambiar esencia
- **Esc** - Pausa

---

## 🚀 Cómo Jugar en Web

### Opción 1: Ejecutar localmente (sin Godot instalado)

**Requisitos:**
- Python 3 (o cualquier servidor HTTP)

**Pasos:**

1. Descarga el proyecto compilado desde las releases (si disponible)
2. Extrae el archivo
3. Abre una terminal en la carpeta `hollow-knight-web/`
4. Ejecuta:
   ```bash
   python -m http.server 8000
   ```
5. Abre en tu navegador: `http://localhost:8000`

### Opción 2: Compilar desde el código

**Requisitos:**
- Godot 4.x instalado ([Descargar](https://godotengine.org/download))

**Pasos:**

1. Clona el repositorio
2. Abre el proyecto en Godot 4
3. Asegúrate de que **Global** (src/game.gd) está en AutoLoad (Project > Project Settings > Autoload)
4. Compila a web:
   - **Windows:** Ejecuta `export.bat`
   - **Linux/Mac:** Ejecuta `chmod +x export.sh && ./export.sh`
5. Los archivos compilados se generarán en `../hollow-knight-web/`
6. Sirve los archivos localmente (ver Opción 1)

---

## 📂 Estructura del Proyecto

```
hollow-knight/
├── src/
│   ├── player.gd           # Controlador del jugador
│   ├── enemy_ai.gd         # IA básica de enemigos
│   ├── boss_tardigrado.gd  # Comportamiento del jefe
│   ├── game.gd             # Global (Autoload) - Abilities & Save
│   ├── ui.gd               # Gestor de UI
│   ├── bench.gd            # Checkpoint/Banco
│   ├── gate.gd             # Puertas bloqueadas
│   ├── pickup.gd           # Items de habilidades
│   └── mobile_controls.gd  # Controles táctiles (WIP)
├── scenes/
│   ├── Main.tscn           # Menú principal
│   ├── Player.tscn         # Instancia del jugador
│   ├── LevelTemplate.tscn  # Template de nivel
│   ├── JardinDeAjolotes.tscn
│   ├── Boss_Tardigrado.tscn
│   ├── Enemy.tscn          # Enemy base
│   ├── Gate.tscn           # Puertas
│   ├── Bench.tscn          # Checkpoints
│   ├── UI.tscn             # HUD
│   └── MobileControls.tscn # Botones táctiles
├── assets/
│   └── placeholders/       # Sprites y sonidos placeholder
├── project.godot           # Configuración del proyecto
├── export_presets.cfg      # Presets de exportación
├── export.sh               # Script de compilación (Linux/Mac)
├── export.bat              # Script de compilación (Windows)
└── README.md               # Este archivo
```

---

## 🔧 Desarrollo

### Próximas Mejoras
- [ ] Animaciones completas (idle, run, jump, attack, dash)
- [ ] Sprites y assets propios
- [ ] Más niveles y mapas
- [ ] Sistema de diálogo NPC
- [ ] Música y efectos de sonido
- [ ] Tutorial inicial
- [ ] Menú de pausa mejorado
- [ ] Controles táctiles pulidos

### Para Colaboradores
1. Crea una rama: `git checkout -b feature/tu-caracteristica`
2. Haz tus cambios
3. Compila y prueba localmente
4. Crea un Pull Request

---

## 🛠️ Troubleshooting

**El juego no se ejecuta en web:**
- Verifica que tienes un servidor HTTP activo
- Comprueba la consola del navegador (F12) para errores

**Error de Global no encontrado:**
- Asegúrate de que `src/game.gd` está en AutoLoad en Project Settings

**Colisiones no funcionan:**
- Añade `CollisionShape2D` con una forma definida en `Player.tscn`

---

## 📜 Licencia

MIT License - Libre para usar y modificar

---

## 👾 Créditos

- Inspiración: Hollow Knight, Undertale, Scavengers
- Engine: Godot 4
- Personaje: Espíritu de Zorro

---

**¡Que disfrutes del juego! 🎮✨**
