class QuestCLI
  MENU_ACTIONS = {
    "1" => :manage_adventurers,
    "2" => :manage_quests,
    "3" => :view_quest_log,
  }.freeze

  def run
    loop do
      display_main_menu
      choice = gets.chomp

      break if exit_selected?(choice)

      perform_action(choice)
    end
  end

  private

  def display_main_menu
    puts "\n========================"
    puts "        QUESTCLI"
    puts "========================"
    puts "1. Manage Adventurers"
    puts "2. Manage Quests"
    puts "3. View Quest Log"
    puts "4. Exit"
    print "\nChoose an option: "
  end

  def exit_selected?(choice)
    return false unless choice == "4"

    puts "\nThanks for using QuestCLI!"
    true
  end

  def perform_action(choice)
    action = MENU_ACTIONS[choice]

    if action
      send(action)
    else
      puts "\nInvalid choice. Please select an option from 1 to 4."
    end
  end

  def manage_adventurers
    PlayerMenu.new.run
  end

  def manage_quests
    QuestMenu.new.run
  end

  def view_quest_log
    puts "\nQuest log will be added in a future feature."
  end
end
