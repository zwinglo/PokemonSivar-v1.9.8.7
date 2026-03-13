def quemar_equipo
  for i in 0...$Trainer.party.length
    $Trainer.party[i].status = PBStatuses::BURN
  end
end



def dormir_equipo
  for i in 0...$Trainer.party.length
    $Trainer.party[i].status = PBStatuses::SLEEP
  end
end



def paralizar_equipo
  for i in 0...$Trainer.party.length
    $Trainer.party[i].status = PBStatuses::PARALYSIS
  end
end



def envenenar_equipo
  for i in 0...$Trainer.party.length
    $Trainer.party[i].status = PBStatuses::POISON
  end
end



def dañar_equipo(porciento) # Para llamarlo pon dañar_equipo y el porcentaje de vida
  for i in 0...$Trainer.party.length
    calc = ($Trainer.party[i].hp * (porciento / 100.0)).floor
    $Trainer.party[i].hp = calc
  end
end