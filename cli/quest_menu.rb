require_relative "quest_display"

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

  def initialize
    @display = QuestDisplay.new
  end

  def run
    loop do
      @display.menu
      choice = gets.chomp

      break if choice == "8"

      perform_action(choice)
    end
  end

  private

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
      @display.quest_details(quest)
    else
      @display.errors(quest)
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
    @display.quests(Quest.all)
  end

  def view_player_quests
    player = select_player
    return unless player

    @display.quests(player.quests)
  end

  def view_active_quests
    @display.quests(Quest.where(completed: false))
  end

  def view_completed_quests
    @display.quests(Quest.where(completed: true))
  end

  def update_quest
    quest = select_quest
    return unless quest

    if quest.update(updated_quest_attributes(quest))
      puts "Quest updated successfully."
      @display.quest_details(quest)
    else
      @display.errors(quest)
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

    @display.quest_details(quest)
    return unless confirm_completion?

    complete_quest_and_award_xp(quest)
  end

  def confirm_completion?
    print "Complete this quest? (y/n): "
    gets.chomp.downcase == "y"
  end

  def complete_quest_and_award_xp(quest)
    player = quest.player
    previous_level = player.level

    Quest.transaction do
      quest.update!(completed: true)
      player.add_experience!(quest.xp_reward)
    end

    @display.completion(quest, player, previous_level)
  rescue ActiveRecord::RecordInvalid => e
    @display.errors(e.record)
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
    select_quest_from(quests, "quest")
  end

  def select_active_quest
    active_quests = Quest.where(completed: false)
    select_quest_from(active_quests, "active quest")
  end

  def select_quest_from(quests, quest_type)
    if quests.empty?
      puts "No #{quest_type}s found."
      return
    end

    @display.quest_choices(quests)

    print "Enter #{quest_type} ID: "
    quest = quests.find_by(id: gets.chomp)

    puts "#{quest_type.capitalize} not found." unless quest
    quest
  end
end
