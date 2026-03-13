###############################################################
#               LevelCap aplicado a Caramelos X               #
#                   Adaptación : Bezier                       #
#                     LevelCap : Clara                        #
###############################################################
# Esta adaptación encapsula el LevelCap de Clara en un Módulo #
# que sea cómodo de usar, llamando a la función:              #
#   nivelLimite = LevelCap.GetLimitLevel                      #
#                                                             #
# Usa ese nivel para limitar la cantidad de experiencia que   #
# recibe un Pokémon al usar caramelos de experiencia y        #
# dependiendo de las medallas obtenidas                       #
###############################################################
 
# Encapsula el código del LevelCap para facilitar su uso desde varios puntos estratégicos
# Como puede ser esta adaptación de caramelos de experiencia o el repartir experiencia
module LevelCap
  def self.GetLimitLevel
    # Level cap de Clara. Devuelve un nivel máximo dependiendo de las medallas obtenidas
    level=18
    #medallas 1-8
    level=20  if $game_switches[4]
    level=23  if $game_switches[5]
    level=25  if $game_switches[6]
    level=26  if $game_switches[7]
    level=30  if $game_switches[8]
    level=32  if $game_switches[74]
    level=34  if $game_switches[10]
    level=40 if $game_switches[11] 
    level=43  if $game_switches[62] #schafik
    level=46  if $game_switches[86] #talentos vencidos
    level=47 if $game_switches[70] #leo
    level=50  if $game_switches[64] #malo vencido
    level=55  if $game_variables[13]>0 #elite 4 derrotada
    level=100  if $game_variables[19]>3 #post game vencidos
    return level
  end
end