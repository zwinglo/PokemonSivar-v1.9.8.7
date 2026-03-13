#Checks whether a Pokémon in party has a certain Type
def pbHasPokemonType?(type)
  if type.is_a?(String) || type.is_a?(Symbol)
    type=getID(PBTypes,type)
  end
  for pokemon in $Trainer.party
    next if pokemon.isEgg?
    if pokemon.hasType?(type)
      pbSet(1,$Trainer.party.index(pokemon))
      pbSet(3,pokemon.name)
      return true
    end
  end
  pbSet(1,-1)
  pbSet(3,"")
  return false
end