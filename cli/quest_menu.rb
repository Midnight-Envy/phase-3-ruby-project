class QuestMenu
  MENU_ACTIONS = {
    "1" => :accept_quest,
    "2" => :view_all_quests,
    "3" => :view_player_quests,
    "4" => :view_active_quests,
    "5" => :view_completed_quests,
  }.freeze

  def run
    loop do
      display_menu
      choice = gets.chomp

      break if return_to_main_menu?(choice)

      perform_action(choice)
    end
  end

  private

  def display_menu
    puts "\nQUEST MENU"
    puts "1. Accept Quest"
    puts "2. View All Quests"
    puts "3. View Adventurer's Quests"
    puts "4. View Active Quests"
    puts "5. View Completed Quests"
    puts "6. Return to Main Menu"
    print "Choose an option: "
  end

  def return_to_main_menu?(choice)
    choice == "6"
  end

  def perform_action(choice)
    action = MENU_ACTIONS[choice]

    if action
      send(action)
    else
      puts "Invalid selection."
    end
  end

  def accept_quest
    player = select_player
    return unless player

    quest = player.quests.build(quest_attributes)

    if quest.save
      puts "#{quest.title} accepted by #{player.name}."
    else
      display_errors(quest)
    end
  end

  def quest_attributes
    print "Quest title: "
    title = gets.chomp

    print "Description: "
    description = gets.chomp

    print "Difficulty (Easy, Medium, or Hard): "
    difficulty = gets.chomp.capitalize

    print "XP reward: "
    xp_reward = gets.chomp

    {
      title: title,
      description: description,
      difficulty: difficulty,
      xp_reward: xp_reward,
    }
  end

  def view_all_quests
    display_quests(Quest.all)
  end

  def view_player_quests
    player = select_player
    return unless player

    display_quests(player.quests)
  end

  def view_active_quests
    display_quests(Quest.where(completed: false))
  end

  def view_completed_quests
    display_quests(Quest.where(completed: true))
  end

  def select_player
    players = Player.all

    if players.empty?
      puts "No adventurers found."
      return
    end

    players.each do |player|
      puts "#{player.id}. #{player.name}"
    end

    print "Enter adventurer ID: "
    Player.find_by(id: gets.chomp)
  end

  def display_quests(quests)
    if quests.empty?
      puts "No quests found."
      return
    end

    quests.each { |quest| display_quest(quest) }
  end

  def display_quest(quest)
    status = quest.completed? ? "Completed" : "Active"

    puts "\n#{quest.title}"
    puts "Adventurer: #{quest.player.name}"
    puts "Description: #{quest.description}"
    puts "Difficulty: #{quest.difficulty}"
    puts "XP Reward: #{quest.xp_reward}"
    puts "Status: #{status}"
  end

  def display_errors(record)
    record.errors.full_messages.each do |message|
      puts "Error: #{message}"
    end
  end
end
