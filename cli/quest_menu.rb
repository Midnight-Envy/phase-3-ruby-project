class QuestMenu
  MENU_ACTIONS = {
    "1" => :accept_quest,
    "2" => :view_all_quests,
    "3" => :view_player_quests,
    "4" => :view_active_quests,
    "5" => :view_completed_quests,
    "6" => :update_quest,
    "7" => :complete_quest,
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
    puts "6. Update Quest"
    puts "7. Complete Quest"
    puts "8. Return to Main Menu"
    print "Choose an option: "
  end

  def return_to_main_menu?(choice)
    choice == "8"
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
      puts "Quest Accepted!"
      display_quest(quest)
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

  def update_quest
    quest = select_quest
    return unless quest

    if quest.update(updated_quest_attributes(quest))
      puts "Quest updated successfully."
      display_quest(quest)
    else
      display_errors(quest)
    end
  end

  def updated_quest_attributes(quest)
    {
      title: updated_value("Title", quest.title),
      description: updated_value("Description", quest.description),
      difficulty: updated_difficulty(quest),
      xp_reward: updated_value("XP reward", quest.xp_reward),
    }
  end

  def updated_difficulty(quest)
    value = updated_value("Difficulty", quest.difficulty)

    value == quest.difficulty ? value : value.capitalize
  end

  def updated_value(label, current_value)
    print "#{label} [#{current_value}]: "
    input = gets.chomp

    input.empty? ? current_value : input
  end

  def complete_quest
    quest = select_active_quest
    return unless quest

    display_quest(quest)
    return unless confirm_completion?

    complete_quest_and_award_xp(quest)
  end

  def confirm_completion?
    print "Complete this quest? (y/n): "
    gets.chomp.downcase == "y"
  end

  def complete_quest_and_award_xp(quest)
    player = quest.player

    Quest.transaction do
      quest.update!(completed: true)
      player.update!(current_xp: player.current_xp + quest.xp_reward)
    end

    display_completion_message(quest, player)
  rescue ActiveRecord::RecordInvalid => e
    display_errors(e.record)
  end

  def display_completion_message(quest, player)
    puts "\nQuest Complete!"
    puts "#{player.name} earned #{quest.xp_reward} XP."
    puts "Level: #{player.level}"
    puts "Current XP: #{player.current_xp}"
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
    player = Player.find_by(id: gets.chomp)

    puts "Adventurer not found." unless player
    player
  end

  def select_quest
    quests = Quest.all

    if quests.empty?
      puts "No quests found."
      return
    end

    display_quest_choices(quests)

    print "Enter quest ID: "
    quest = Quest.find_by(id: gets.chomp)

    puts "Quest not found." unless quest
    quest
  end

  def select_active_quest
    active_quests = Quest.where(completed: false)

    if active_quests.empty?
      puts "No active quests found."
      return
    end

    display_quest_choices(active_quests)

    print "Enter active quest ID: "
    quest = active_quests.find_by(id: gets.chomp)

    puts "Active quest not found." unless quest
    quest
  end

  def display_quest_choices(quests)
    quests.each do |quest|
      puts "#{quest.id}. #{quest.title}"
    end
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
