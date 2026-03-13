# Localización francesa de PokemonSivar

## Objetivo
Crear una versión francesa natural, jugable y culturalmente fiel a El Salvador.
La traducción no debe borrar la identidad salvadoreña del juego.
Debe permitir que jugadores franceses se diviertan y aprendan sobre El Salvador.

## Principios
1. Conservar lo salvadoreño cuando sea parte del encanto, la ambientación o el aprendizaje cultural.
2. Adaptar modismos, humor y expresiones para que suenen naturales en francés de Francia.
3. No traducir identificadores internos, claves técnicas ni estructura de archivos.
4. Priorizar claridad, naturalidad y coherencia por encima de la literalidad.
5. Mantener un tono cercano, juvenil y natural, evitando tanto la rigidez excesiva como el argot exagerado.

## Qué se conserva
- nombres propios
- nombres de lugares
- comidas típicas
- referencias culturales salvadoreñas
- elementos del folclore o identidad nacional
- nombres de fakemon o variantes locales cuando formen parte de la identidad del juego

## Qué se adapta
- modismos
- bromas
- insultos suaves
- regaños
- expresiones coloquiales
- frases muy locales que un francés no entendería literalmente

## Qué nunca se traduce
- identificadores internos como CLANGINGSCALES, DRAGON, Status, etc.
- nombres de campos como Name=, InternalName=, Moves=, Evolutions=
- sintaxis, comas, separadores, índices, números
- estructura técnica de PBS y scripts

## Registro en francés
- francés estándar de Francia
- tono natural, cercano y jugable
- evitar traducciones demasiado literales
- evitar un francés excesivamente formal
- evitar argot demasiado local o difícil de entender

## Regla cultural principal
Conservar lo salvadoreño, traducir la comprensión.

## Flujo oficial del proyecto
1. copia de seguridad y Git
2. LOCALIZACION_FR.md
3. GLOSARIO_SV_FR.csv
4. traducir PBS seguros en este orden:
   - types.txt
   - abilities.txt
   - items.txt
   - moves.txt
   - trainertypes.txt
   - trainers.txt
   - pokemon.txt
5. después narrativa/sistema
6. selector de idioma al final

## Regla de revisión
Toda traducción automática debe revisarse antes de considerarse final.