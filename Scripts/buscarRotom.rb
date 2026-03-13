def buscarRotom
  for poke in $Trainer.pokemonParty
    if isConst?(poke.species,PBSpecies,:ROTOM)
      return true
    end
  end
  return false
end