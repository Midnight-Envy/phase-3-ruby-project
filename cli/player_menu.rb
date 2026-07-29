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
    puts "\n========================"
    puts "    ADVENTURER MENU"
    puts "========================"
    puts "1. Create Adventurer"
    puts "2. View All Adventurers"
    puts "3. View Adventurer Details"
    puts "4. Update Adventurer"
    puts "5. Delete Adventurer"
    puts "6. Return to Main Menu"
    print "\nChoose an option: "
  end

  def return_to_main_menu?(choice)
    return false unless choice == "6"

    puts "\nReturning to the main menu..."
    true
  end

  def perform_action(choice)
    action = MENU_ACTIONS[choice]

    if action
      send(action)
    else
      puts "\nInvalid choice. Please select an option from 1 to 6."
    end
  end

  def create_player
    print "\nEnter adventurer name: "
    player = Player.new(name: gets.chomp)

    if player.save
      puts "\nAdventurer created successfully!"
      display_player(player)
    else
      display_errors(player)
    end
  end

  def view_all_players
    players = Player.all

    if players.empty?
      puts "\nNo adventurers have been created yet."
      return
    end

    display_heading("ADVENTURERS")
    players.each { |player| display_player(player) }
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
      puts "\nAdventurer updated successfully!"
      display_player(player)
    else
      display_errors(player)
    end
  end

  def delete_player
    player = select_player
    return unless player

    puts "\nYou selected:"
    display_player(player)

    unless confirm_action?(
      "Delete this adventurer and all of their quests?"
    )
      puts "\nDeletion canceled."
      return
    end

    destroy_player(player)
  end

  def destroy_player(player)
    if player.destroy
      puts "\nAdventurer deleted successfully."
    else
      display_errors(player)
    end
  end

  def confirm_action?(message)
    print "\n#{message} (y/n): "
    gets.chomp.downcase == "y"
  end

  def select_player
    players = Player.all

    if players.empty?
      puts "\nNo adventurers have been created yet."
      return
    end

    puts "\nSelect an adventurer:"

    players.each do |player|
      puts "#{player.id}. #{player.name}"
    end

    print "\nEnter adventurer ID: "
    player = players.find_by(id: gets.chomp)

    puts "\nAdventurer not found." unless player
    player
  end

  def display_heading(title)
    puts "\n========================"
    puts "      #{title}"
    puts "========================"
  end

  def display_player(player)
    puts "\nID: #{player.id}"
    puts "Name: #{player.name}"
    puts "Level: #{player.level}"
    puts "Current XP: #{player.current_xp}"
    puts "------------------------"
  end

  def display_quest_summary(player)
    active_count = player.quests.where(completed: false).count
    completed_count = player.quests.where(completed: true).count

    puts "Active Quests: #{active_count}"
    puts "Completed Quests: #{completed_count}"
    puts "------------------------"
  end

  def display_errors(record)
    puts "\nUnable to save adventurer:"

    record.errors.full_messages.each do |message|
      puts "- #{message}"
    end
  end
end
