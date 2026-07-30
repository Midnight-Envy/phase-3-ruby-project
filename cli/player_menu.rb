require_relative "colors"

class PlayerMenu
  MENU_ACTIONS = {
    "1" => :create_player,
    "2" => :view_all_players,
    "3" => :view_player_details,
    "4" => :update_player,
    "5" => :delete_player,
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
    puts
    puts "========================"
    puts Colors.heading("    ADVENTURER MENU")
    puts "========================"
    puts "1. Create Adventurer"
    puts "2. View All Adventurers"
    puts "3. View Adventurer Details"
    puts "4. Update Adventurer"
    puts "5. Delete Adventurer"
    puts "6. Return to Main Menu"
    print "\n#{Colors.yellow('Choose an option: ')}"
  end

  def return_to_main_menu?(choice)
    return false unless choice == "6"

    puts "\n#{Colors.warning('Returning to the main menu...')}"
    true
  end

  def perform_action(choice)
    action = MENU_ACTIONS[choice]

    if action
      send(action)
    else
      puts "\n#{Colors.error('Invalid choice. Please select an option from 1 to 6.')}"
    end
  end

  def create_player
    print "\nEnter adventurer name: "
    player = Player.new(name: gets.chomp)

    if player.save
      puts "\n#{Colors.success('Adventurer created successfully!')}"
      display_player(player)
    else
      display_errors(player)
    end
  end

  def view_all_players
    players = Player.all.to_a

    if players.empty?
      puts "\n#{Colors.warning('No adventurers have been created yet.')}"
      return
    end

    display_heading("ADVENTURERS")

    players.each_with_index do |player, index|
      puts "\n#{Colors.heading("#{index + 1}. #{player.name}")}"
      display_player(player, show_name: false)
    end
  end

  def view_player_details
    player = select_player
    return unless player

    display_heading("ADVENTURER DETAILS")
    display_player(player)
    display_quest_summary(player)
  end

  def update_player
    player = select_player
    return unless player

    print "\nName [#{player.name}]: "
    new_name = gets.chomp
    new_name = player.name if new_name.empty?

    if player.update(name: new_name)
      puts "\n#{Colors.success('Adventurer updated successfully!')}"
      display_player(player)
    else
      display_errors(player)
    end
  end

  def delete_player
    player = select_player
    return unless player

    puts "\n#{Colors.warning('You selected:')}"
    display_player(player)

    unless confirm_action?(
      "Delete this adventurer and all of their quests?"
    )
      puts "\n#{Colors.warning('Deletion canceled.')}"
      return
    end

    destroy_player(player)
  end

  def destroy_player(player)
    if player.destroy
      puts "\n#{Colors.success('Adventurer deleted successfully.')}"
    else
      display_errors(player)
    end
  end

  def confirm_action?(message)
    print "\n#{Colors.warning("#{message} (y/n): ")}"
    gets.chomp.downcase == "y"
  end

  def select_player
    players = Player.all.to_a

    if players.empty?
      puts "\n#{Colors.warning('No adventurers have been created yet.')}"
      return
    end

    puts "\n#{Colors.heading('Select an adventurer:')}"

    players.each_with_index do |player, index|
      puts "#{Colors.cyan(index + 1)}. #{player.name}"
    end

    print "\nEnter adventurer number: "
    selected_player = record_at_index(players, gets.chomp)

    puts "\n#{Colors.error('Adventurer not found.')}" unless selected_player

    selected_player
  end

  def record_at_index(records, input)
    index = input.to_i - 1

    return if index.negative?
    return if index >= records.length

    records[index]
  end

  def display_heading(title)
    puts
    puts "========================"
    puts Colors.heading(title.center(24))
    puts "========================"
  end

  def display_player(player, show_name: true)
    puts "\n#{Colors.bold('Name:')} #{player.name}" if show_name
    puts "#{Colors.bold('Level:')} #{Colors.xp(player.level)}"
    puts "#{Colors.bold('Current XP:')} #{Colors.xp(player.current_xp)}"
    puts "------------------------"
  end

  def display_quest_summary(player)
    active_count = player.quests.where(completed: false).count
    completed_count = player.quests.where(completed: true).count

    puts "#{Colors.yellow('Active Quests:')} #{active_count}"
    puts "#{Colors.green('Completed Quests:')} #{completed_count}"
    puts "------------------------"
  end

  def display_errors(record)
    puts "\n#{Colors.error('Unable to save adventurer:')}"

    record.errors.full_messages.each do |message|
      puts Colors.red("- #{message}")
    end
  end
end
