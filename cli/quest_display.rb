class QuestDisplay
  def menu
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

  def quests(quests)
    if quests.empty?
      puts "No quests found."
      return
    end

    quests.each { |quest| quest_details(quest) }
  end

  def quest_choices(quests)
    quests.each do |quest|
      puts "#{quest.id}. #{quest.title}"
    end
  end

  def quest_details(quest)
    status = quest.completed? ? "Completed" : "Active"

    puts "\n#{quest.title}"
    puts "Adventurer: #{quest.player.name}"
    puts "Description: #{quest.description}"
    puts "Difficulty: #{quest.difficulty}"
    puts "XP Reward: #{quest.xp_reward}"
    puts "Status: #{status}"
  end

  def completion(quest, player, previous_level)
    puts "\nQuest Complete!"
    puts "#{player.name} earned #{quest.xp_reward} XP."

    level_up(player, previous_level)

    puts "Level: #{player.level}"
    puts "Current XP: #{player.current_xp}"
  end

  def errors(record)
    record.errors.full_messages.each do |message|
      puts "Error: #{message}"
    end
  end

  private

  def level_up(player, previous_level)
    return unless player.level > previous_level

    puts "#{player.name} leveled up!"
    puts "Level #{previous_level} -> Level #{player.level}"
  end
end
