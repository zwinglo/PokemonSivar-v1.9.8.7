ItemHandlers::UseFromBag.add(:PISCUCHA,proc{|item|
  outdoors=pbGetMetadata($game_map.map_id,MetadataOutdoor)
  if !outdoors
    Kernel.pbMessage(_INTL("No puedes usarlo aquí."))
    next 0
  end
  next 2
})

ItemHandlers::UseInField.add(:PISCUCHA,proc{|item|
  outdoors=pbGetMetadata($game_map.map_id,MetadataOutdoor)
  if !outdoors
    Kernel.pbMessage(_INTL("No puedes usarlo aquí."))
    next 0
  end
  useMoveFly
})


def useMoveFly # Add useMoveFly in the event in a script command
  scene=PokemonRegionMapScene.new(-1,false)
  screen=PokemonRegionMap.new(scene)
  ret=screen.pbStartFlyScreen
  return false if !ret
  $PokemonTemp.flydata=ret
  #if !$PokemonTemp.flydata
  # Kernel.pbMessage(_INTL("No puedes usarlo aquí."))
  #end
  pbFadeOutIn(99999){
    Kernel.pbCancelVehicles
    $game_temp.player_new_map_id=$PokemonTemp.flydata[0]
    $game_temp.player_new_x=$PokemonTemp.flydata[1]
    $game_temp.player_new_y=$PokemonTemp.flydata[2]
    $PokemonTemp.flydata=nil
    $game_temp.player_new_direction=2
    $scene.transfer_player
    $game_map.autoplay
    $game_map.refresh
  }
  pbEraseEscapePoint
  return true
end