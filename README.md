# Proyecto Godot - Metroidvania: Espíritu de Zorro (starter)

Este repositorio contiene un proyecto inicial de Godot (plantilla) para crear un juego Metroidvania inspirado en la idea del espíritu de zorro. No contiene assets comerciales ni contenidos protegidos por derechos de autor.

Qué incluye:
- Estructura mínima de carpetas (scenes, src, assets/placeholders)
- Escenas básicas: Main.tscn, Player.tscn
- Scripts principales en GDScript: player.gd, enemy.gd, gate.gd, game.gd, save.gd
- README con instrucciones básicas para abrir y ejecutar

Cómo usar:
1) Clona el repo: git clone https://github.com/Adrigc-hub/hollow-knight.git
2) Asegúrate de estar en la rama main: git checkout main
3) Abre Godot 4, selecciona "Import" o "Open" y abre la carpeta del repo (contiene project.godot)
4) En el Editor -> Project -> Project Settings -> Input Map, añade las acciones mencionadas en src/README o el README.md
5) Añade el script src/game.gd como Autoload/Singleton (Project -> Project Settings -> AutoLoad -> Path: res://src/game.gd Name: Global)

Cómo comprobar que los archivos están en el repositorio (desde tu máquina):
- git pull origin main
- ls (verás las carpetas scenes, src, assets)

Si quieres que añada CI, ejemplos de export o más escenas, dime y los agrego.
