# Godot Metroidvania - FoxSpirit (Ampliado)

Este README amplía el proyecto inicial con escenas y mecánicas adicionales: Jardín de los Ajolotes, boss base "El Tardígrado", controles móviles, UI e implementación extendida del jugador (wall-cling, charged attack, esencias). Todo son plantillas y placeholders; reemplaza assets por arte propio.

Archivos añadidos / modificados principales:
- scenes/JardinDeAjolotes.tscn
- scenes/Boss_Tardigrado.tscn
- scenes/UI.tscn
- scenes/MobileControls.tscn
- scenes/LevelTemplate.tscn
- src/player.gd (actualizado: wall cling, charged attack, essences)
- src/boss_tardigrado.gd
- src/ui.gd
- src/mobile_controls.gd
- assets/placeholders/sprites/player_placeholder.png (placeholder)
- assets/placeholders/sprites/enemy_placeholder.png
- assets/placeholders/tileset_placeholder.png
- assets/placeholders/audio/README.txt

Cómo probar las nuevas escenas
1. Abre Godot 4 y carga el proyecto.
2. Asegúrate de que Global (res://src/game.gd) esté en AutoLoad.
3. Abre scenes/Main.tscn o scenes/LevelTemplate.tscn y añade un instance de scenes/Player.tscn si no está ya.
4. Cambia la escena principal temporalmente a scenes/LevelTemplate.tscn (Project -> Project Settings -> Run -> Main Scene) y pulsa Play.

Controles:
- Keyboard: A/D o flechas para moverse, Space para saltar, LShift para dash, X para ataque (manten para cargar), E para cambiar esencia (debug), Esc para pause.
- Mobile: carga scenes/MobileControls.tscn y prueba en el editor con la pantalla táctil visible (TouchScreenButton simulado).

Notas:
- Los TileMap y AnimatedSprite2D referencian placeholders (vacíos). Antes de probar colisiones visuales, coloca una CollisionShape2D en Player.tscn.
- Para desbloquear puertas: llama Global.give_ability("ability_key") o recoge un objeto en la escena (puedo añadir pickups si lo deseas).

Si quieres que programe más (IA de enemigos, diseño de mapa real, animaciones, diálogo NPC, sistema de guardado por bancos), dime qué priorizamos y lo hago en el siguiente commit.
