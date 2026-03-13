#===============================================================================
#  Pokemon World Tournament
#    by Luka S.J.
# 
#  A new (and more advanced) of my previous Pokemon World Tournament script.
#  This system is a little more sophisticated, hence more complex to use and
#  implement. Comes with a whole load of goodies like a visual battle field,
#  customizable tournaments, and Trainer Lobby. Please make sure to carefully
#  read the instructions and information on my site before using/implementing
#  this new system.
#
#  Enjoy the script, and make sure to give credit!
#  (DO NOT ALTER THE NAMES OF THE INDIVIDUAL SCRIPT SECTIONS OR YOU WILL BREAK
#   YOUR SYSTEM!)
#===============================================================================                           
#  Pokemon World Tournament (settings)
#===============================================================================                           
# This is a list of the Pokemon that cannot be used in the PWT                
BAN_LIST = [:MEWTWO,:MEW,:HOOH,:LUGIA,:CELEBI,:KYOGRE,:GROUDON,:RAYQUAZA,
            :DEOXYS,:JIRACHI,:DIALGA,:PALKIA,:GIRATINA,:REGIGIGAS,:HEATRAN,:DARKRAI,
            :SHAYMIN,:ARCEUS,:ZEKROM,:RESHIRAM,:KYUREM,:LANDORUS,:MELOETTA,
            :KELDEO,:GENESECT]
# To edit Tournament branches please see below:

# Information pertining to the start position on the PWT stage
# Format is as following: [map_id, map_x, map_y]
PWT_MAP_DATA = [113,21,14]
# ID for the event used to move the player and opponents on the map
PWT_MOVE_EVENT = 37
# ID of the opponent event
PWT_OPP_EVENT = 35
# ID of the scoreboard event
PWT_SCORE_BOARD_EVENT = 34
# ID of the lobby trainer event
PWT_LOBBY_EVENT = 6
# ID of the event used to display an optional even if the player wins the PWT
PWT_FANFARE_EVENT = 38
#===============================================================================               
# Main PWT architecture
#-------------------------------------------------------------------------------
class AdvancedWorldTournament
  attr_reader :party_bak
  attr_reader :internal
  attr_reader :cachedSpeech
  attr_accessor :outcome
  attr_accessor :beat
  attr_accessor :inbattle
  
# List containing all possible tournament branches
# Format per tournament is as following:
#
# "name of tournaments","condition == true"
# trainer_entry[trainertype,trainername,endspeech_loose,endspeech_win,trainer variable,lobby text (optional), text before battle (optional), text after battle (optional)]
# 
# At least 8 entry arrays need to be defined per tournament name and condition
# to make the tournament valid. A tournament with less than 8 trainers to fight,
# will not show up on your tournament selection list.
  def fetchTournamentList
    tournament_list = [
    "Estrellas", "",
      [:RENE,"René","Baaaarbaro.","Ya viste que barbara soy.",1],
      [:ARTISTA,"King Flyp","Vos si que sos un terremoto.","Perdón, hice que temblara muy fuerte.",1],
      [:CIPITIO,"Cipitio","Tan cabeza de ayote no sos cipote.","Si sos cabeza de ayote cipote.",1],
      [:BRUJO,"Brujo Barbujo","Noooo.","¡Ja!, Nadie puede con mi magia.",1],
      [:GORDOSOYACITY,"Soyacity","Puta, mejor me hubiera esperado al Pato","Ni me hizo falta esperar al Pato.",1],
      [:MAGICOGONZALES,"Mágico Gonzáles","Bien jugado cipotón.","Te falta practicar con el balón.",1],
      [:LILIAN,"Niña Lilian","Puta, este hijuelagranputa si le sabe a los pokémon","No le sabes hijueputa.",1],
      [:COCOLITO,"Cocolito","¡Qué chivo va vos!","¡Qué chivo va vos!",1],
      [:TENCHIS,"Tenchis","¡Si vos vivo va animal!","Si sos dundo animal.",1],
      [:GATITA,"Gatita Serpas","Ya acabé","Tenes que aprender a aguantar más.",1],
      [:YANI,"La Niña Yani","¡Qué bien bailas corazón bello!","¡Estuvo divertido corazón bello!",1],
      [:HULERO,"Don hulero","¿Te gustaron los hules chico?","Quizás mis hules son mucho para vos.",1],
      [:ALECO,"Aleco Meco","Maje...","¿Qué pasó ahí chepe?",1],
      "3ra división", '',
      [:STOCKING,"Stocking","¡Me divertí igual!","¡Que chivo estuvo!",1],
      [:JOVENTALENTO_GLAZE,"Glaze","Lol, oh my god, en plan, holy shit.","Not worry, me divertí igual.",1],
      [:JOVENTALENTO_VLADIMIR,"Vladimir","Me faltarón espinacas hoy.","Te falta comer espinacas.",1],
      [:DARKMONG,"Darkmong","Mis poderes oscuros no bastaron.","Parece que mis poderes oscuros fueron mucho para vos.",1],
      [:JD,"jd","Vale verga","Te falta practicar más.",1],
      [:PLAGUE,"Plague","Jueputa","Te falta escuela maje.",1],
      [:MOONS,"Moons","Puta, ¿Qué le dan a estos niños de ahora?","Estos niños de ahora ya no rinden como antes.",1],
      [:ALEXANDER,"Alexander","Cerote","Jaja, gané.",1],
      [:JOVENTALENTO_ALCAPONE,"Alcapone","Puta, le fallé al Madrid.","Esta va por el Madrid.",1],
      [:FERNAN,"Fernan","Te fallé Messi.","Está va por Messi.",1],
      [:MINUN,"Minun","Así nunca podré poner mi ciber.","Ciber, ahí te voy.",1],
      [:INFORMATICO,"Pepé","Con eso te armas una PC.","Mejor me voy a armar mi PC.",1],
      [:ALEX,"Alex","Ya vete del ciber.","Ya estoy listo para cuidar mi ciber.",1],
      [:JARI,"Jari","Culero que no me queres hacer barra a multi.","Eso te pasa por no querer hacerme barra a multi.",1],
      "2da división", '$Trainer.pwt_wins["3ra división"]>0',
      [:LEADER_KLEIN,"Klein","Suesverga.","Parece que no tenías técnicas contra incendio.",1],
      [:LEADER_RADIANT,"Radiant","Que vergones los vergasos que soltas.","Le faltan fuerza a esos vergasos tuyos.",1],
      [:LEADER_SAM,"Sam","¡Qué buen control de la marea marinero!","Parece que el nivel de la marea era demasiado para vos.",1],
      [:LEADER_DALESSAR,"Dalessar","Que vergón jugas man.","Te falta entreno.",1],
      [:LEADER_RABOS,"Rabos","Gracias por entretener a mis amores.","No te preocupes, mis amores se divirtieron igual.",1],
      [:LEADER_SHIDO,"Shido","No sirvió mi carta trampa.","Caíste en mi carta trampa.",1],
      [:LEADER_SOILZ,"Soilz","El duelo terminó.","Este duelo es para mí.",1],
      [:JOVENTALENTO_JOCNA,"Jocna","Magnífico.","Un duelo magnífico aún así.",1],
      [:JOVENTALENTO_HECTOR,"Héctor","No pude leer lo que ibas a hacer.","Leí todo lo que ibas a hacer.",1],
      "1ra división", '$Trainer.pwt_wins["2da división"]>0',
      [:LEADER_YENISCE,"Yenisce","Parece que los que necesitarán la ambulancia serán mis pokémon.","Tranquilo, ya te llamo una ambulancia.",1],
      [:LEADER_LEO,"Leo","No cabe duda de que tenes un fuerte vínculo con tus pokémon.","Tenes que fortalecer el vínculo con tus pokémon.",1],
      [:ELITEFOUR_CYAN,"Cyan","Se nota todo lo que has aprendido.","Aún te queda mucho por aprender.",1],
      [:JOSUE,"Josué","Sin duda tenes un gran potencial.","Tenes un gran potencial aún así.",1],
      [:JOVENTALENTO_MACHAPE,"Machape","Buenaaa.","Estuvo bueno igual.",1],
      [:JOVENTALENTO_LEX,"Lex","Sos bastante fuerte.","Aún así diría que sos bastante fuerte.",1],
      [:CASTER,"ChessCaster","Estas listo para lo que sea.","Tenes que preparte más.",1],
      [:JOVENTALENTO_DAVID,"David","Andas con todo.","Andas con todo, pero no fue suficiente.",1],
      "2da división 2022", '$Trainer.pwt_wins["1ra división"]>0',
      [:LEADER_KLEIN_2022,"Klein","Suesverga.","Parece que no tenías técnicas contra incendio.",2],
      [:LEADER_SAM_2022,"Sam","¡Qué buen control de la marea marinero!","Parece que el nivel de la marea era demasiado para vos.",2],
      [:LEADER_DALESSAR_2022,"Dalessar","Que vergón jugas man.","Te falta entreno.",2],
      [:LEADER_RABOS_2022,"Rabos","Gracias por entretener a mis amores.","No te preocupes, mis amores se divirtieron igual.",2],
      [:LEADER_SHIDO_2022,"Shido","No sirvió mi carta trampa.","Caíste en mi carta trampa.",2],
      [:LEADER_SOILZ_2022,"Soilz","El duelo terminó.","Este duelo es para mí.",2],
      [:JOVENTALENTO_JOCNA,"Jocna","Magnífico.","Un duelo magnífico aún así.",2],
      #[:BARBABLANCA,"Barba","Puya, me ganaste.","Yo gané está vez.",2],
      [:ALEXANDER,"Alexander","Cerote","Jaja, gané.",2],
      "1ra división 2022", '$Trainer.pwt_wins["1ra división"]>0',
      [:LEADER_YENISCE_2022,"Yenisce","Parece que los que necesitarán la ambulancia serán mis pokémon.","Tranquilo, ya te llamo una ambulancia.",2],
      [:LEADER_LEO_2022,"Leo","No cabe duda de que tenes un fuerte vínculo con tus pokémon.","Tenes que fortalecer el vínculo con tus pokémon.",2],
      [:ELITEFOUR_CYAN_2022,"Cyan","Se nota todo lo que has aprendido.","Aún te queda mucho por aprender.",2],
      [:JOSUE_2022,"Josué","Sin duda tenes un gran potencial.","Tenes un gran potencial aún así.",2],
      [:JOVENTALENTO_MACHAPE,"Machape","Buenaaa.","Estuvo bueno igual.",2],
      [:JOVENTALENTO_LEX,"Lex","Sos bastante fuerte.","Aún así diría que sos bastante fuerte.",2],
      [:CASTER_2022,"ChessCaster","Estas listo para lo que sea.","Tenes que preparte más.",2],
      [:CAVEIRA,"Caveira","Verga, no te pude ganar","La victoria es para mí.",2],
      [:JOVENTALENTO_DAVID,"David","Andas con todo.","Andas con todo, pero no fue suficiente.",2],
      [:MIKE,"Mike","No dí lo suficiente","Parece que fue demasiado para vos.",2],
      "2da división 2023", '$Trainer.pwt_wins["1ra división"]>0',
      [:LEADER_KLEIN_2022,"Klein","Suesverga.","Parece que no tenías técnicas contra incendio.",3],
      [:LEADER_DALESSAR_2022,"Dalessar","Que vergón jugas man.","Te falta entreno.",3],
      [:LEADER_RABOS_2022,"Rabos","Gracias por entretener a mis amores.","No te preocupes, mis amores se divirtieron igual.",3],
      [:JOVENTALENTO_JOCNA,"Jocna","Magnífico.","Un duelo magnífico aún así.",3],
      #[:BARBABLANCA,"Barba","Puya, me ganaste.","Yo gané está vez.",3],
      [:COOLTRAINER_F,"Sara","Juela, sos muy fuerte.","Te falta practicar más.",3],
      [:LEADER_YENISCE_2022,"Yenisce","Parece que los que necesitarán la ambulancia serán mis pokémon.","Tranquilo, ya te llamo una ambulancia.",3],
      [:JOVENTALENTO_HECTOR,"Héctor","No pude leer lo que ibas a hacer.","Leí todo lo que ibas a hacer.",3],
      [:ALEX,"Alex","Ya vete del ciber.","Ya estoy listo para cuidar mi ciber.",3],
      #[:LEADER_SOILZ_2022,"Soilz","El duelo terminó.","Este duelo es para mí.",3],
      "1ra división 2023", '$Trainer.pwt_wins["1ra división"]>0',
      [:LEADER_YENISCE_2022,"Yenisce","Parece que los que necesitarán la ambulancia serán mis pokémon.","Tranquilo, ya te llamo una ambulancia.",4],
      [:LEADER_LEO_2022,"Leo","No cabe duda de que tenes un fuerte vínculo con tus pokémon.","Tenes que fortalecer el vínculo con tus pokémon.",3],
      [:ELITEFOUR_CYAN_2022,"Cyan","Se nota todo lo que has aprendido.","Aún te queda mucho por aprender.",3],
      [:CAVEIRA,"Caveira","Verga, no te pude ganar","La victoria es para mí.",3],
      [:JOVENTALENTO_MACHAPE,"Machape","Buenaaa.","Estuvo bueno igual.",3],
      [:JOVENTALENTO_LEX,"Lex","Sos bastante fuerte.","Aún así diría que sos bastante fuerte.",3],
      [:CASTER_2022,"ChessCaster","Estas listo para lo que sea.","Tenes que preparte más.",3],
      [:JOVENTALENTO_DAVID,"David","Andas con todo.","Andas con todo, pero no fue suficiente.",3],
      # "Johto Leaders","",      <=  start of defining a new Tournament branch 
    ] # end of list
    return tournament_list
  end
  
  # Starts the PWT process
  def initialize(viewport)
    @viewport = viewport
    @outcome = 0
    @inbattle = false
    @cachedSpeech = ""
    @beat = []
    @levels = []
    @party_bak = []
    # Turns on the PWT
    @internal = true
    # Backing up party
    self.backupParty
    # Configures the win entries of the PWT
    all = self.checkFor?
    $Trainer.pwt_wins = {} if $Trainer.pwt_wins.nil? || $Trainer.pwt_wins.is_a?(Array)
    for entry in all
      $Trainer.pwt_wins[entry] = 0 if $Trainer.pwt_wins[entry].nil?
    end
    $Trainer.battle_points = 0 if $Trainer.battle_points.nil?
    # Playes the introductory dialogue
    self.introduction
    
    # Chooses tournament
    @tournament_type = self.chooseTournament
    return self.notAvailable if @tournament_type.nil?
    return self.cancelEntry if !@tournament_type
    # Chooses battle type
    @battle_type = self.chooseBattle
    return cancelEntry if !@battle_type
    # Chooses new party
    @modified_party = self.choosePokemon
    # Generates the scoreboard
    if @modified_party == "notEligible"
      Kernel.pbMessage(_INTL("Lo sentimos mucho, pero tus Pokémon no son elegibles para el Torneo."))
      Kernel.pbMessage(_INTL(showBanList))
      Kernel.pbMessage(_INTL("Por favor, regresa una vez que hayas ajustado tu equipo."))
    elsif !@modified_party
      cancelEntry
    else
      # Starts tournament branch
      self.transferPlayer(*PWT_MAP_DATA)
    end
  end
  
  def continue
    # Continues the tournament branch
    $Trainer.party.clear
    $Trainer.party = @modified_party
    self.setLevel
    self.generateRounds(@tournament_type)
    ret = self.startTournament
    # Handles the tournament end and outcome
    self.endFanfare if ret == "win"
    @current_location.push(true)
    self.transferPlayer(*@current_location)
    case ret
    when "win"
      $game_switches[82]=false
      Kernel.pbMessage(_INTL("Felicitaciones, has ganado hoy."))
      Kernel.pbMessage(_INTL("Toma esto como recompensa."))
      Kernel.pbMessage(_INTL("Has obtenido $15000"))
      $Trainer.money+=15000
      Kernel.pbMessage(_INTL("Esperamos verte otra vez."))
      $Trainer.pwt_wins[@tournament_type] += 1
      self.endTournament
    when "loss"
     $game_switches[82]=false
     Kernel.pbMessage(_INTL("Lamento que hayas perdido."))
     Kernel.pbMessage(_INTL("Quizás tengas mejor suerte la próxima vez."))
     self.cancelEntry
    end
  end
  
  # Ends the whole PWT process
  def endTournament
    self.restoreParty
    self.disposeScoreboard
    @internal = false
    $PWT = nil
  end
  
  # Generates the main list used to manipulate the tournaments
  def checkFor?(type ="list")
    list = []
    rows = [0]
    conditions = []
    return nil if self.fetchTournamentList.length < 10
    catch = -1
    k = 0
    for i in 0...self.fetchTournamentList.length
      val = self.fetchTournamentList[i]
      if !val.is_a?(Array) || i == (self.fetchTournamentList.length - 1)
        i += 1 if i == (self.fetchTournamentList.length - 1)
        k += 1
        catch = i if catch < 0
        if k > 2
          k = 1
          rows.push(i - catch)
          catch = i
        end
      end
    end
    return nil if rows.length < 2
    for i in 1...rows.length
      next if rows[i] < 10
      k = 0
      for m in 0...i
        k += rows[m]
      end
      break if self.fetchTournamentList[k].nil?
      val = self.fetchTournamentList[k]
      list.push(val) if val.is_a?(String)
      val = self.fetchTournamentList[k + 1]
      conditions.push(val)
    end
    return conditions.length > 0 ? conditions : nil if type == "condition"
    return rows if type == "rows"
    return list.length > 0 ? list : nil
  end
  
  # Generates a list of trainers for a selected tournament
  def generateFromList(selected)
    selected = [selected] if !selected.is_a?(Array)
    list = []
    rows = self.checkFor?("rows")
    for sel in selected
      for i in 1...rows.length
        next if rows[i] < 10
        k = 0
        for m in 0...i
          k += rows[m]
        end
        break if self.fetchTournamentList[k].nil?
        val = self.fetchTournamentList[k]
        next if val != sel
        k += 2
        for m in k...(k + rows[i] - 2)
          list.push(self.fetchTournamentList[m])
        end
      end
    end
    return list.length < 8 ? nil : list
  end
  
  # Progressively generates a list of all the world leaders
  def generateWorldLeaders
    list = []
    all = self.checkFor?
    for val in all
      list.push(val) if val.include?("Leaders")
    end
    return generateFromList(list)
  end
  
  # Heals your party
  def healParty
    for poke in $Trainer.party
      poke.heal
    end
  end
  
  # Sets all Pokemon to lv 50
  def setLevel
    for poke in $Trainer.party
      poke.level = 60
      poke.calcStats
      poke.heal
    end
  end
  
  # Backs up your current party
  def backupParty
    @party_bak.clear
    @levels.clear
    for poke in $Trainer.party
      @party_bak.push(poke)
      @levels.push(poke.level)
    end
  end
  
  # Restores your party from an existing backup
  def restoreParty
    $Trainer.party.clear
    for i in 0...@party_bak.length
      poke = @party_bak[i]
      poke.level = @levels[i]
      poke.calcStats
      poke.heal
      $Trainer.party.push(poke)
    end
  end
  
  # Outputs a message which lists all the Pokemon banned from the Tournament
  def showBanList
    msg = ""
    for species in BAN_LIST
      if species.is_a?(Numeric)
      elsif species.is_a?(Symbol)
        species = getConst(PBSpecies,species)
      else
        next
      end
      pkmn = PokeBattle_Pokemon.new(species,1,nil,false)
      msg += "#{pkmn.name}, "
    end
    msg += "Los pokémon no pueden participar si aún están en el huevo."
    return msg
  end
  
  # Generates a list of choices based on available tournaments
  def chooseTournament
    choices = []
    all = self.checkFor?
    condition = self.checkFor?("condition")
    world = false
    for i in 0...all.length
      val = all[i]
      cond = condition[i]
      cond = (cond == "" || eval(cond)) if cond.is_a?(String)
      choices.push(val) if cond
      world = false if val.include?("Leaders") && cond
      world = false if val.include?("Leaders") && $Trainer.pwt_wins[val] < 1
    end
    choices.push("World Leaders") if world
    return nil if choices.length < 1
    choices.push("Cancel")
    cmd = Kernel.pbMessage(_INTL("¿En qué división quieres participar?"),choices,choices.length)
    return false if cmd == choices.length - 1
    return choices[cmd]
  end
    
  # Allows the player to choose which style of battle they would like to do
  def chooseBattle
  choices = ["3 pokémon","Doble","6 pokémon","Muerte Súbita","Cancelar"]
  cmd = Kernel.pbMessage(_INTL("¿En qué tipo de Batalla te gustaría participar?"),choices,choices.length - 1)
    return false if cmd == choices.length-1
    return cmd
  end
  
  # Creates a new trainer party based on the battle type, and the Pokemon chosen to enter
  def choosePokemon
    ret = false
    return "notEligible" if !self.partyEligible?
    length = [3,4,6,1][@battle_type]
    Kernel.pbMessage(_INTL("Elige los Pokémon con los que te gustaría participar."))
    banlist = BAN_LIST
    banlist = BAN_LIST[@tournament_type] if BAN_LIST.is_a?(Hash)
    ruleset = PokemonRuleSet.new
    ruleset.addPokemonRule(RestrictSpecies.new(banlist))
    ruleset.setNumberRange(length,length)
    pbFadeOutIn(99999){
       if defined?(PokemonParty_Scene)
         scene = PokemonParty_Scene.new
         screen = PokemonPartyScreen.new(scene,$Trainer.party)
       else
         scene = PokemonScreen_Scene.new
         screen = PokemonScreen.new(scene,$Trainer.party)
       end
       ret = screen.pbPokemonMultipleEntryScreenEx(ruleset)
    }
    return ret
  end
  
  # Cancels the entry into the Tournament
  def cancelEntry
    self.endTournament
    Kernel.pbMessage(_INTL("Esperamos verte otra vez"))
    return false
  end
  
  # Checks if the party is eligible
  def partyEligible?
    length = [3,4,6,1][@battle_type]
    count = 0
    banlist = BAN_LIST
    banlist = BAN_LIST[@tournament_type] if BAN_LIST.is_a?(Hash)
    return false if $Trainer.party.length < length
    for i in 0...$Trainer.party.length
      for species in banlist
        if species.is_a?(Numeric)
        elsif species.is_a?(Symbol)
          species = getConst(PBSpecies,species)
        else
          next
        end
        egg = $Trainer.party[i].respond_to?(:egg?) ? $Trainer.party[i].egg? : $Trainer.party[i].isEgg?
        count += 1 if species != $Trainer.party[i].species && !egg
      end
    end
    return true if count >= length
    return false
  end
  
  # Method used to generate a full list of Trainers to battle
  def generateRounds(selected)
    @trainer_list = []
    if selected == "World Leaders"
      full_list = generateWorldLeaders
    else
      full_list = generateFromList(selected)
    end
    loop do
      n = rand(full_list.length)
      trainer = full_list[n]
      full_list.delete_at(n)
      @trainer_list.push(trainer)
      break if @trainer_list.length > 7
    end
    n = rand(8)
    @player_index = n
    @player_index_int = @player_index
    @trainer_list[n] = $Trainer.party    
    @trainer_list_int = @trainer_list
  end
  
  # Methods used to generate the individual rounds
  def generateRound1
    self.healParty
    trainer = @trainer_list[[1,0,3,2,5,4,7,6][@player_index]]
    trainer = Tournament_Trainer.new(*trainer)
    @cachedSpeech = trainer.winspeech
    return trainer
  end
  
  def generateRound2
    self.healParty
    list = ["","","",""]
    @player_index = @player_index/2
    for i in 0...4
      if i == @player_index
        list[i] = $Trainer.party
      else
        list[i] = @trainer_list[(i*2)+rand(2)]
      end
    end
    @trainer_list = list
    trainer = @trainer_list[[1,0,3,2][@player_index]]
    trainer = Tournament_Trainer.new(*trainer)
    @cachedSpeech = trainer.winspeech
    return trainer
  end
  
  def generateRound3
    self.healParty
    list = ["","","",""]
    @player_index = @player_index/2
    for i in 0...2
      if i == @player_index
        list[i] = $Trainer.party
      else
        list[i] = @trainer_list[(i*2)+rand(2)]
      end
    end
    @trainer_list = list
    trainer = @trainer_list[[1,0][@player_index]]
    trainer = Tournament_Trainer.new(*trainer)
    @cachedSpeech = trainer.winspeech
    return trainer
  end
  
  def visualRound(trainer,back =false)
    event = $game_map.events[PWT_OPP_EVENT]
    event.character_name = pbTrainerCharNameFile(trainer.id)
    event.refresh
    if back
      self.moveSwitch('D',event)
    else
      self.moveSwitch('B',event)
    end
    @miniboard.vsSequence(trainer) if !back
  end
  
  # Scoreboard visual effects
  def generateScoreboard
    @brdview = Viewport.new(0,-@viewport.rect.height,@viewport.rect.width,@viewport.rect.height*2)
    @brdview.z = 999999
    @board = Sprite.new(@brdview)
    @board.bitmap = Bitmap.new(@viewport.rect.width,@viewport.rect.height)
    pbSetSystemFont(@board.bitmap)
    @miniboard = MiniBoard.new(@viewport)
  end
  
  def displayScoreboard(trainer)
    @brdview.color = Color.new(0,0,0,0)
    nlist = []
    for i in 0...@trainer_list.length
      nlist.push(@trainer_list[i][0])
    end
    x = 0
    y = 0
    gwidth = @viewport.rect.width
    gheight = @viewport.rect.height
    @board.bitmap.clear
    @board.bitmap.fill_rect(0,0,gwidth,gheight,Color.new(0,0,0))
    @board.bitmap.blt(0,0,BitmapCache.load_bitmap("Graphics/Pictures/scoreboard"),Rect.new(0,0,gwidth,gheight))
    for i in 0...@trainer_list_int.length
      opacity = 255
      if i == @player_index_int
        trname = "#{$Trainer.name}"
        meta = pbGetMetadata(0,MetadataPlayerA+$PokemonGlobal.playerID)
        char = pbGetPlayerCharset(meta,1)
        bitmap = BitmapCache.load_bitmap("Graphics/Characters/#{char}")
      else
        opacity = 80 if !(nlist.include?(@trainer_list_int[i][0]))
        trainer = Tournament_Trainer.new(*@trainer_list_int[i])
        trname = trainer.name
        bitmap = BitmapCache.load_bitmap(pbTrainerCharFile(trainer.id))
      end
      @board.bitmap.blt(24+(gwidth-44-(bitmap.width/4))*x,24+(gheight/6)*y,bitmap,Rect.new(0,0,bitmap.width/4,bitmap.height/4),opacity)
      text=[["#{trname}",34+(bitmap.width/4)+(gwidth-64-(bitmap.width/2))*x,38+(gheight/6)*y,x*1,Color.new(255,255,255),Color.new(80,80,80)]]
      pbDrawTextPositions(@board.bitmap,text)
      y+=1
      x+=1 if y > 3
      y=0 if y > 3
    end
    for k in 0...2
      16.times do
        next if @brdview.nil?
        @brdview.color.alpha += 16*(k < 1 ? 1 : -1)
        self.wait(1)
      end
      if k == 0
        @brdview.rect.y += @viewport.rect.height
        @brdview.rect.y = - @viewport.rect.height if @brdview.rect.y > 0
      end
      8.times do; Graphics.update; end
    end
    loop do
      self.wait(1)
      if Input.trigger?(Input::C)
        pbSEPlay("Choose",80)
        break
      end
    end
    for k in 0...2
      16.times do
        next if @brdview.nil?
        @brdview.color.alpha += 16*(k < 1 ? 1 : -1)
        self.wait(1)
      end
      if k == 0
        @brdview.rect.y += @viewport.rect.height
        @brdview.rect.y = - @viewport.rect.height if @brdview.rect.y > 0
      end
      8.times do; Graphics.update; end
    end
  end
  
  def disposeScoreboard
    @board.dispose if @board && !@board.disposed?
    @miniboard.dispose if @miniboard && !@miniboard.disposed?
    @brdview.dispose if @brdview
  end
  
  def updateMiniboard
  return if @miniboard.nil? || !@miniboard.respond_to?(:disposed?) || !@miniboard.respond_to?(:update)
    return if !@miniboard && !@miniboard.disposed?
    if $game_map.map_id == PWT_MAP_DATA[0]
      event = $game_map.events[PWT_SCORE_BOARD_EVENT]
      return if event.nil?
      @miniboard.update(event.screen_x - 16, event.screen_y - 32)
    end
  end
    
  # Creates a small introductory conversation
  def introduction
    Kernel.pbMessage(_INTL("¡Hola y bienvenido a la copa sivar!"))
    Kernel.pbMessage(_INTL("El lugar donde los más fuertes se reúnen para competir."))
    #Kernel.pbMessage(_INTL("Antes de continuar, deberás guardar tu progreso."))
  end
  
  # Creates a small conversation if no Tournaments are available
  def notAvailable
    Kernel.pbMessage(_INTL("Lo siento mucho, pero parece que actualmente no hay competiciones en las que puedas participar."))
    Kernel.pbMessage(_INTL("¡Por favor vuelve más tarde!"))
  end
  
  # Handles the tournament branch
  def startTournament
    $game_switches[82]=true
    @round = 0
    doublebattle = false
    doublebattle = true if @battle_type == 1

    Kernel.pbMessage(_INTL("Comentarista: ¡Bienvenidos a la copa sivar!"))
    Kernel.pbMessage(_INTL("Comentarista: El lugar donde los más fuertes se reúnen para competir."))
    Kernel.pbMessage(_INTL("Comentarista: Veamos la tabla de clasificación de hoy"))
    trainer = self.generateRound1
    self.displayScoreboard(trainer)
    self.moveSwitch('A')
    Kernel.pbMessage(_INTL("Comentarista: Sin más preámbulos, que comience el primer combate."))
    Kernel.pbMessage(_INTL("Comentarista: Esta será una batalla entre #{$Trainer.name} y #{trainer.name}."))
    self.visualRound(trainer)
    Kernel.pbMessage(trainer.beforebattle) if !trainer.beforebattle.nil?
    if pbTrainerBattle(trainer.id,trainer.name,trainer.endspeech,doublebattle,trainer.variant,true,$PWT.outcome)
      @round = 1
      Kernel.pbMessage(trainer.afterbattle) if !trainer.afterbattle.nil?
      @beat.push(trainer)
      Kernel.pbMessage(_INTL("Comentarista: ¡Guau! ¡Qué emocionante primera ronda!"))
      Kernel.pbMessage(_INTL("Comentarista: ¡El estadio está calentándose y los concursantes están que arden!"))
      self.visualRound(trainer,true)
      Kernel.pbMessage(_INTL("Comentarista: Volvamos nuestra atención a la pizarra para ver los resultados."))
      trainer = self.generateRound2
      self.displayScoreboard(trainer)
      Kernel.pbMessage(_INTL("Comentarista: Parece que el próximo combate será entre #{$Trainer.name} y #{trainer.name}."))
      self.visualRound(trainer)
      Kernel.pbMessage(_INTL("Comentarista: ¡Que comience la batalla!"))
      Kernel.pbMessage(trainer.beforebattle) if !trainer.beforebattle.nil?
      if pbTrainerBattle(trainer.id,trainer.name,trainer.endspeech,doublebattle,trainer.variant,true,$PWT.outcome)
        @round = 2
        Kernel.pbMessage(trainer.afterbattle) if !trainer.afterbattle.nil?
        @beat.push(trainer)
        Kernel.pbMessage(_INTL("Comentarista: ¡Qué espectaculares combates!"))
        Kernel.pbMessage(_INTL("Comentarista: Estos entrenadores lo están dando todo."))
        self.visualRound(trainer,true)
        Kernel.pbMessage(_INTL("Comentarista: Dirijamos nuestra atención a la pizarra por última vez."))
        trainer = self.generateRound3
        self.displayScoreboard(trainer)
        Kernel.pbMessage(_INTL("Comentarista: ¡Muy bien! ¡Todo está listo!"))
        Kernel.pbMessage(_INTL("Comentarista: ¡La batalla final de este torneo será entre #{$Trainer.name} y #{trainer.name}!"))
        self.visualRound(trainer)
        Kernel.pbMessage(_INTL("Comentarista: ¡Que gane el mejor entrenador!"))
            Kernel.pbMessage(trainer.beforebattle) if !trainer.beforebattle.nil?
            if pbTrainerBattle(trainer.id,trainer.name,trainer.endspeech,doublebattle,trainer.variant,true,$PWT.outcome)
              @round = 3
              Kernel.pbMessage(trainer.afterbattle) if !trainer.afterbattle.nil?
              @beat.push(trainer)
              Kernel.pbMessage(_INTL("Comentarista: ¡Qué batalla tan impresionante!"))
              Kernel.pbMessage(_INTL("Comentarista: Ambos entrenadores dieron una gran pelea, pero #{$Trainer.name} fue quien salió victorioso."))
              Kernel.pbMessage(_INTL("Comentarista: ¡Felicitaciones #{$Trainer.name}! Sin duda, te has ganado el título de Campeón de hoy."))
              Kernel.pbMessage(_INTL("Comentarista: Eso es todo por hoy. Esperamos que hayan disfrutado del torneo."))
              return "win"
        end
      end
    end
    return "loss"
  end
  
  def transferPlayer(id,x,y,lobby =false)
    @viewport.color = Color.new(0,0,0,0)
    16.times do
      next if @viewport.nil?
      @viewport.color.alpha += 16
      self.wait(1)
    end
    @current_location = [$game_map.map_id,$game_player.x,$game_player.y]
    $MapFactory = PokemonMapFactory.new(id)
    $game_player.moveto(x, y)
    $game_player.refresh
    $game_player.turn_up
    $game_map.autoplay
    $game_map.update
    if lobby
      self.randLobbyGeneration
      @miniboard.dispose
    else
      self.generateScoreboard
      pbUpdateSceneMap
    end
    8.times do; Graphics.update; end
    16.times do
      next if @viewport.nil?
      @viewport.color.alpha -= 16
      self.wait(1)
    end
  end
  
  def moveSwitch(switch = 'A',event =nil)
    $game_self_switches[[PWT_MAP_DATA[0],PWT_MOVE_EVENT,switch]] = true
    $game_map.need_refresh = true
    loop do
      break if $game_self_switches[[PWT_MAP_DATA[0],PWT_MOVE_EVENT,switch]] == false
      self.wait(1)
    end
  end
  
  def randLobbyGeneration
    return if @beat.length < 1
    return if rand(100) < 25
    event = $game_map.events[PWT_LOBBY_EVENT]
    trainer = @beat[rand(@beat.length)]
    return if trainer.lobbyspeech.nil?
    event.character_name = pbTrainerCharNameFile(trainer.id)
    $Trainer.lobby_trainer = trainer
  end
  
  def endFanfare
    $game_self_switches[[PWT_MAP_DATA[0],PWT_FANFARE_EVENT,'A']] = true
    $game_map.need_refresh = true
    loop do
      break if $game_self_switches[[PWT_MAP_DATA[0],PWT_FANFARE_EVENT,'A']] == false
      self.wait(1)
    end
  end
    
  def wait(frames)
    frames.times do
      Graphics.update
      Input.update
      pbUpdateSceneMap
    end
  end
end
#-------------------------------------------------------------------------------
# Trainer objects to be used in tournaments
#-------------------------------------------------------------------------------
class Tournament_Trainer
  attr_reader :id
  attr_reader :name
  attr_reader :endspeech
  attr_reader :winspeech
  attr_reader :variant
  attr_reader :lobbyspeech
  attr_reader :beforebattle
  attr_reader :afterbattle
  
  def initialize(*args)
    trainerid, name, endspeech, winspeech, variant, lobbyspeech, beforebattle, afterbattle = args
    if trainerid.is_a?(Numeric)
      @id = trainerid
    elsif trainerid.is_a?(Symbol)
      @id = getConst(PBTrainers, trainerid)
    else
      raise "No se ha especificado una ID de entrenador válida"
    end
    @name = name
    @endspeech = endspeech.nil? ? "..." : endspeech
    @winspeech = winspeech.nil? ? "..." : winspeech
    @variant = variant
    @lobbyspeech = lobbyspeech
    @beforebattle = beforebattle
    @afterbattle = afterbattle
  end
  
end
#-------------------------------------------------------------------------------
# Mini scoreboard object
#-------------------------------------------------------------------------------
class MiniBoard
  attr_reader :inSequence
  
  def initialize(viewport)
    @viewport = Viewport.new(-6*32,-3*32,6*32,3*32)
    @viewport.z = viewport.z - 1
    @disposed = false
    @inSequence = false
    @index = 0
    
    @s = {}
    @s["bg"] = Sprite.new(@viewport)
    @s["bg"].bitmap = BitmapCache.load_bitmap("Graphics/Pictures/pwtMiniBoard_bg")
    @s["bg"].opacity = 0
    
    @s["vs1"] = Sprite.new(@viewport)
    @s["vs1"].bitmap = Bitmap.new(6*32,3*32)
    pbSetSmallFont(@s["vs1"].bitmap)
    @s["vs1"].x = 6*32
    
    @s["vs2"] = Sprite.new(@viewport)
    @s["vs2"].bitmap = Bitmap.new(6*32,3*32)
    pbSetSmallFont(@s["vs2"].bitmap)
    @s["vs2"].x = -6*32
    
    @s["vs"] = Sprite.new(@viewport)
    @s["vs"].bitmap = BitmapCache.load_bitmap("Graphics/Pictures/pwtMiniBoard_vs")
    @s["vs"].ox = @s["vs"].bitmap.width/2
    @s["vs"].oy = @s["vs"].bitmap.height/2
    @s["vs"].x = @s["vs"].ox
    @s["vs"].y = @s["vs"].oy
    @s["vs"].zoom_x = 2
    @s["vs"].zoom_y = 2
    @s["vs"].opacity = 0
    
    @s["over"] = Sprite.new(@viewport)
    @s["over"].bitmap = BitmapCache.load_bitmap("Graphics/Pictures/pwtMiniBoard_ov")
    @s["over"].z = 50
  end
  
  def update(x, y)
    @viewport.rect.x = x
    @viewport.rect.y = y
    @s["over"].y -= 1 if @index%4==0
    @s["over"].y = 0 if @s["over"].y <= -(32*3)
    @index += 1
    @index = 0 if @index > 64
    @s["bg"].opacity += 32 if @s["bg"].opacity < 255
    if !@inSequence
      @s["vs1"].x += 12 if @s["vs1"].x < 6*32
      @s["vs2"].x -= 12 if @s["vs2"].x > -6*32
      @s["vs"].zoom_x += 1/16.0 if @s["vs"].zoom_x < 2
      @s["vs"].zoom_y += 1/16.0 if @s["vs"].zoom_y < 2
      @s["vs"].opacity -= 16 if @s["vs"].opacity > 0
    end
  end
  
  def dispose
    pbDisposeSpriteHash(@s)
    @viewport.dispose
    @disposed = true
  end
  
  def disposed?
    return @disposed
  end
  
  def vsSequence(trainer)
    @inSequence = true
    @s["vs1"].bitmap.clear
    @s["vs1"].bitmap.blt(0,0,BitmapCache.load_bitmap("Graphics/Pictures/pwtMiniBoard_vs1"),Rect.new(0,0,6*32,3*32))
    bmp = self.fetchTrainerBmp($Trainer.trainertype)
    x = (bmp.width - 38)/2
    y = (bmp.height - 38)/6
    @s["vs1"].bitmap.blt(135,13,bmp,Rect.new(x,y,38,38))
    pbDrawOutlineText(@s["vs1"].bitmap,79,59,108,26,$Trainer.name,Color.new(255,255,255),nil,1)
    
    @s["vs2"].bitmap.clear
    @s["vs2"].bitmap.blt(0,0,BitmapCache.load_bitmap("Graphics/Pictures/pwtMiniBoard_vs2"),Rect.new(0,0,6*32,3*32))
    bmp = self.fetchTrainerBmp(trainer.id)
    x = (bmp.width - 38)/2
    y = (bmp.height - 38)/6
    @s["vs2"].bitmap.blt(19,44,bmp,Rect.new(x,y,38,38))
    pbDrawOutlineText(@s["vs2"].bitmap,5,10,108,26,trainer.name,Color.new(255,255,255),nil,1)
    16.times do
      @s["vs1"].x -= 12
      @s["vs2"].x += 12
      @s["vs"].zoom_x -= 1/16.0
      @s["vs"].zoom_y -= 1/16.0
      @s["vs"].opacity += 16
      pbWait(1)
    end
    pbWait(64)
    @inSequence = false
  end
  
  def fetchTrainerBmp(trainerid)
    file = pbPlayerSpriteFile(trainerid)
    bmp0 = BitmapCache.load_bitmap(file)
    if defined?(DynamicTrainerSprite) && defined?(TRAINERSPRITESCALE)
      bmp1 = Bitmap.new(bmp0.height*TRAINERSPRITESCALE,bmp0.height*TRAINERSPRITESCALE)
      bmp1.stretch_blt(Rect.new(0,0,bmp1.width,bmp1.height),bmp0,Rect.new(bmp0.width-bmp0.height,0,bmp0.height,bmp0.height))
    else
      bmp1 = bmp0.clone     
    end
    return bmp1
  end
end
#-------------------------------------------------------------------------------
# Trainer party modifier
#-------------------------------------------------------------------------------
alias pbLoadTrainer_pwt pbLoadTrainer unless defined?(pbLoadTrainer_pwt)
def pbLoadTrainer(*args)
  trainer = pbLoadTrainer_pwt(*args)
  return nil if trainer.nil?
  return trainer if !(!$PWT.nil? && $PWT.internal)
  opponent = trainer[0]
  items = trainer[1]
  party = trainer[2]
  length = [3,4,6,1][@battle_type]
  old_party = party.clone
  new_party = []
  count = 0
  loop do
    n = rand(old_party.length)
    new_party.push(old_party[n])
    old_party.delete_at(n)
    break if new_party.length >= length
  end
  party = new_party.clone 
  return [opponent,items,party]
end

alias pbPrepareBattle_pwt pbPrepareBattle unless defined?(pbPrepareBattle_pwt)
def pbPrepareBattle(battle)
  pbPrepareBattle_pwt(battle)
  if !$PWT.nil? && $PWT.internal
    $PokemonGlobal.nextBattleBack = "PWT" if pbResolveBitmap(sprintf("Graphics/Battlebacks/battlebgPWT"))
    $PWT.inbattle = true
    battle.internalbattle = false
    battle.endspeechwin = $PWT.cachedSpeech
  end
end

alias pbUpdateSceneMap_pwt pbUpdateSceneMap unless defined?(pbUpdateSceneMap_pwt)
def pbUpdateSceneMap(*args)
  pbUpdateSceneMap_pwt(*args)
  $PWT.updateMiniboard if !$PWT.nil? && $PWT.internal && !$PWT.inbattle
end

class PokeBattle_Scene
  alias pbEndBattle_pwt pbEndBattle unless self.method_defined?(:pbEndBattle_pwt)
  def pbEndBattle(*args)
    pbEndBattle_pwt(*args)
    $PWT.inbattle = false if !$PWT.nil? && $PWT.internal && $PWT.inbattle
  end
end
#-------------------------------------------------------------------------------
# PWT battle rules
#-------------------------------------------------------------------------------
class RestrictSpecies
  
  def initialize(banlist)
    @specieslist = []
    for species in banlist
      if species.is_a?(Numeric)
        @specieslist.push(species)
        next
      elsif species.is_a?(Symbol)
        @specieslist.push(getConst(PBSpecies,species))
      end
    end
  end
  
  def isSpecies?(species,specieslist)
    for s in specieslist
      return true if species == s
    end
    return false  
  end
  
  def isValid?(pokemon)
    count = 0
    egg = pokemon.respond_to?(:egg?) ? pokemon.egg? : pokemon.isEgg?
    if isSpecies?(pokemon.species,@specieslist) && !egg
      count += 1
    end
    return count == 0
  end
end
#-------------------------------------------------------------------------------
# Extra functionality added to the Trainer class
#-------------------------------------------------------------------------------
class PokeBattle_Trainer
  attr_accessor :battle_points
  attr_accessor :pwt_wins
  attr_accessor :lobby_trainer
end

class Game_Event
  attr_accessor :interpreter
  attr_accessor :page
end

# Method used to start the PWT
def startPWT
  height = defined?(SCREENDUALHEIGHT) ? SCREENDUALHEIGHT : Graphics.height
  viewport = Viewport.new(0,0,Graphics.width,height)
  viewport.z = 100
  $PWT = AdvancedWorldTournament.new(viewport)
end

def continuePWT(id =0)
  $PWT.continue
end

def pwtLobbyTalk
  event = $game_map.events[PWT_LOBBY_EVENT]
  if event.character_name != "" && !$Trainer.lobby_trainer.nil?
    Kernel.pbMessage(_INTL($Trainer.lobby_trainer.lobbyspeech))
  end
end

def darTrofeo
  if $Trainer.pwt_wins["Estrellas"].to_i>0&&$Trainer.pwt_wins["2da división 2022"].to_i>0&&$Trainer.pwt_wins["1ra división 2022"].to_i>0&&$Trainer.pwt_wins["2da división 2023"].to_i>0&&$Trainer.pwt_wins["1ra división 2023"].to_i>0
    return true
  else
    return false
  end
end