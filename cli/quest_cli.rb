require_relative "colors"

class QuestCLI
  MENU_ACTIONS = {
    "1" => :manage_adventurers,
    "2" => :manage_quests,
    "3" => :view_quest_log,
  }.freeze

  def run
    display_welcome

    loop do
      display_main_menu
      choice = gets.chomp

      break if exit_selected?(choice)

      perform_action(choice)
    end
  end

  private

  def display_welcome
    puts
    puts("========================")
    puts Colors.heading("      QUESTCLI")
    puts("========================")
    puts "Create adventurers, accept quests, and earn experience!"
  end

  def display_main_menu
    puts
    puts "========================"
    puts Colors.heading("       MAIN MENU")
    puts "========================"
    puts "1. Manage Adventurers"
    puts "2. Manage Quests"
    puts "3. View Quest Log"
    puts "4. Exit"
    print "\n#{Colors.yellow('Choose an option: ')}"
  end

  def exit_selected?(choice)
    return false unless choice == "4"

    puts
    puts "========================"
    puts Colors.heading("   THANKS FOR PLAYING")
    puts "========================"
    puts Colors.success("Your adventures have been saved.")
    true
  end

  def perform_action(choice)
    action = MENU_ACTIONS[choice]

    if action
      send(action)
    else
      puts "\n#{Colors.error('Invalid choice. Please select an option from 1 to 4.')}"
    end
  end

  def manage_adventurers
    PlayerMenu.new.run
  end

  def manage_quests
    QuestMenu.new.run
  end

  def view_quest_log
    players = Player.includes(:quests)

    QuestDisplay.new.quest_log(players)
  end
end
