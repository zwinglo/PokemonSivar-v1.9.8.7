ItemHandlers::UseOnPokemon.add(:ADAMANTMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:ADAMANT)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:ADAMANT)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta firme.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:BOLDMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:BOLD)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:BOLD)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta osada.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:BRAVEMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:BRAVE)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:BRAVE)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta audaz.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:CALMMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:CALM)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:CALM)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta serena.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:CAREFULMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:CAREFUL)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:CAREFUL)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta cauta.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:GENTLEMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:GENTLE)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:GENTLE)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta amable.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:HASTYMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:HASTY)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:HASTY)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta activa.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:IMPISHMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:IMPISH)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:IMPISH)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta agitada.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:JOLLYMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:JOLLY)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:JOLLY)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta alegre.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:LAXMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:LAX)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:LAX)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta floja.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:LONELYMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:LONELY)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:LONELY)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta huraña.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:MILDMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:MILD)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:MILD)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta afable.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:MODESTMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:MODEST)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:MODEST)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta modesta.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:NAIVEMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:NAIVE)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:NAIVE)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta ingenua.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:NAUGHTYMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:NAUGHTY)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:NAUGHTY)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta pícara.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:QUIETMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:QUIET)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:QUIET)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta mansa.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:RASHMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:RASH)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:RASH)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta alocada.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:RELAXEDMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:RELAXED)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:RELAXED)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta plácida.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:SASSYMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:SASSY)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:SASSY)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta grosera.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:SERIOUSMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:SERIOUS)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:SERIOUS)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta seria.",pokemon.name))
   end
})

ItemHandlers::UseOnPokemon.add(:TIMIDMINT,proc{|item,pokemon,scene|
    if pokemon.nature==(:TIMID)
      scene.pbDisplay(_INTL("No tendrá ningún efecto."))
    else
      pokemon.setNature(:TIMID)
      pokemon.calcStats
      scene.pbDisplay(_INTL("{1} se comió la menta tímida.",pokemon.name))
   end
})