#===============================================================================
#  Hyper Training Script
#  Credit to Jonas930
#===============================================================================
#  How to Use:
#     pbMrHyper(ITEM1,ITEM2)
#         ITEM1 => the item that you want player use with boosting ONE stats into 31
#         ITEM2 => the item that you want player use with boosting ALL stats into 31
#  Example: pbMrHyper(:STARDUST,:STARPIECE)
#===============================================================================
#===============================================================================
def pbMrHyper(item1, item2)
  @nameitem1 = PBItems.getName(711)
  @nameitem2 = PBItems.getName(711)
  @hasitem1 = $PokemonBag.pbHasItem?(item1)
  @hasitem2 = $PokemonBag.pbHasItem?(item2)
  Kernel.pbMessage(_INTL("Hola, yo puedo ayudar a los Pokémon con el Hiperentrenamiento"))
  if Kernel.pbConfirmMessage(_INTL("¿Queres probar algo de mi Hiperentrenamiento para mejorar las estadísticas de tus Pokémon?"))
    if @hasitem1
      item = 1 
      itemuse = (item == 0 ? @nameitem1 : @nameitem2)
      if Kernel.pbConfirmMessage(_INTL("¿Vas a usar uno \\c[1]{1}\\c[0] para el Hiperentrenamiento?", itemuse))
        Kernel.pbMessage(_INTL("¿En cuál de tus Pokémon queres hacer Hiperentrenamiento?"))
        pbChoosePokemon(1, 2)
        pokemon = $Trainer.pokemonParty[pbGet(1)]
        if pbGet(1) < 0
        elsif $Trainer.party[pbGet(1)].egg?
          Kernel.pbMessage(_INTL("¿¡Un Huevo?! Entiendo por qué estás emocionado por tener uno,\n¡pero aún no puedo entrenar esa cosa!"))
        else
          if item == 0
            stat = Kernel.pbMessage(_INTL("¿En cuál de las estadísticas de {1} quieres hacer Hiperentrenamiento?", pokemon.name),
            [_INTL("PS"), _INTL("Ataque"), _INTL("Defensa"), _INTL("Velocidad"), _INTL("Ataque Especial"), _INTL("Defensa Especial")])
            if pokemon.iv[stat] == 31
              Kernel.pbMessage(_INTL("¡Pero ese Pokémon ya es tan increíble que no necesita entrenamiento alguno!"))
            else
              pokemon.iv[stat] = 31
              itemuse = (item == 0 ? item1 : item2)
              $PokemonBag.pbDeleteItem(itemuse)
              Kernel.pbMessage(_INTL("Muy bien, voy a hacer el hiperentrenamiento en tu pokémon"))
              Kernel.pbMessage(_INTL("¡Muy bien! Tu pokémon se volvió aún más fuerte gracias a mi Hiperentrenamiento!"))
            end
          elsif item == 1
            if (pokemon.iv[0] >= 30 && pokemon.iv[1] >= 30 && pokemon.iv[2] >= 30 &&
                pokemon.iv[3] >= 30 && pokemon.iv[4] >= 30 && pokemon.iv[5] >= 30)
              Kernel.pbMessage(_INTL("¡Pero ese Pokémon ya es tan increíble que no necesita entrenamiento alguno!"))
            else
              for i in 0..5
                pokemon.iv[i] = 30
              end
              itemuse = (item == 0 ? item1 : item2)
              $PokemonBag.pbDeleteItem(itemuse)
              Kernel.pbMessage(_INTL("Muy bien, voy a hacer el hiperentrenamiento en tu pokémon"))
              Kernel.pbMessage(_INTL("¡Muy bien! Tu pokémon se volvió aún más fuerte gracias a mi Hiperentrenamiento!"))
            end
          end
        end
      end
    else
      Kernel.pbMessage(_INTL("¡Oh no...\n¡No, no, no!"))
      Kernel.pbMessage(_INTL("¡No tenes ningúna {1} ¡Ni siquiera una!", @nameitem1, @nameitem2))
    end
  end
  Kernel.pbMessage(_INTL("Volve cuando queras."))
end