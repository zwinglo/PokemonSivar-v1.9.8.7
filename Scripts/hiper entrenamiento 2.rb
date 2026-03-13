#===============================================================================
#  Hyper Training Script
#  Credit to Jonas930
#===============================================================================
#  How to Use:
#     pbMrHyper(ITEM1,ITEM2)
#         ITEM1 => the item that you want player use with boosting ONE stats into 31
#         ITEM2 => the item that you want player use with boosting ALL stats into 31
#  Example: pbMrHyper(:STARDUST,:STARPIECE)
def pbMrHyper2(item1, item2)
    @nombre_item1 = PBItems.getName(732)
    @nombre_item2 = PBItems.getName(711)
    @tiene_item1 = $PokemonBag.pbHasItem?(item1)
    @tiene_item2 = $PokemonBag.pbHasItem?(item2)
    Kernel.pbMessage(_INTL("Hola, yo puedo ayudar a los Pokémon con el Hiperentrenamiento"))
    if Kernel.pbConfirmMessage(_INTL("¿Queres probar un poco de mi Hiperentrenamiento para mejorar las estadísticas de tu Pokémon?"))
      if @tiene_item1 || @tiene_item2
        item = 0 if @tiene_item1 && !@tiene_item2
        item = 1 if !@tiene_item1 && @tiene_item2
        item = Kernel.pbMessage(_INTL("¿Qué objeto queres usar en el Hiperentrenamiento?"), [@nombre_item1, @nombre_item2]) if @tiene_item1 && @tiene_item2
        item_usado = (item == 0 ? @nombre_item1 : @nombre_item2)
        if Kernel.pbConfirmMessage(_INTL("¿Vas a usar uno \\c[1]{1}\\c[0] para el Hiperentrenamiento?", item_usado))
          Kernel.pbMessage(_INTL("¿En cuál de tus Pokémon queres realizar el Hiperentrenamiento?"))
          pbChoosePokemon(1, 2)
          pokemon = $Trainer.pokemonParty[pbGet(1)]
          if pbGet(1) < 0
          elsif $Trainer.party[pbGet(1)].egg?
            Kernel.pbMessage(_INTL("¿Un huevo?! Entiendo por qué estás emocionado por tener uno, ¡pero no puedo entrenar a esa cosa todavía!"))
      
          else
            if item == 0
                if (pokemon.ev[0] == 85 && pokemon.ev[1] == 85 && pokemon.ev[2] == 85 &&
                    pokemon.ev[3] == 85 && pokemon.ev[4] == 85 && pokemon.ev[5] == 85)
                  Kernel.pbMessage(_INTL("¡Pero ese Pokémon ya es tan fuerte que no necesita ningún entrenamiento!"))
                else
                for i in 0..5
                    pokemon.ev[i] = 85
                  end
                item_usado = (item == 0 ? item1 : item2)
                $PokemonBag.pbDeleteItem(item_usado)
                Kernel.pbMessage(_INTL("¡Buso pues! ¡Porque estoy a punto de realizar un verdadero Hiperentrenamiento en tu pokémon aquí!"))
                Kernel.pbMessage(_INTL("¡Muy bien!\nTu pokémon se hizo aún más fuerte gracias a mi Hiperentrenamiento!"))
              end
            elsif item == 1
                if (pokemon.iv[0] >= 30 && pokemon.iv[1] >= 30 && pokemon.iv[2] >= 30 &&
                    pokemon.iv[3] >= 30 && pokemon.iv[4] >= 30 && pokemon.iv[5] >= 30)
                Kernel.pbMessage(_INTL("¡Pero ese Pokémon ya es tan fuerte que no necesita ningún entrenamiento!"))
              else
                for i in 0..5
                  pokemon.iv[i] = 30
                end
                item_usado = (item == 0 ? item1 : item2)
                $PokemonBag.pbDeleteItem(item_usado)
                Kernel.pbMessage(_INTL("¡Buso pues! ¡Porque estoy a punto de realizar un verdadero Hiperentrenamiento en tu pokémon aquí!"))
                Kernel.pbMessage(_INTL("¡Muy bien!\nTu pokémon se hizo aún más fuerte gracias a mi Hiperentrenamiento!"))
              end
            end
          end
        end
      else
        Kernel.pbMessage(_INTL("Ijole"))
        Kernel.pbMessage(_INTL("¡No tenes una {1} o  una {2}!\n¡Ni una!", @nombre_item1, @nombre_item2))
      end
    end
    Kernel.pbMessage(_INTL("Volve cuando queras"))
  end