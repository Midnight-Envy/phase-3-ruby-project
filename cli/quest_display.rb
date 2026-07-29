class QuestDisplay
  def menu
    puts "\n========================"
    puts "       QUEST MENU"
    puts "========================"
    puts "1. Accept Quest"
    puts "2. View All Quests"
    puts "3. View Adventurer's Quests"
    puts "4. View Active Quests"
    puts "5. View Completed Quests"
    puts "6. Update Quest"
    puts "7. Complete Quest"
    puts "8. Abandon Quest"
    puts "9. Return to Main Menu"
    print "\nChoose an option: "
  end

  def quests(quests)
    if quests.empty?
      puts "\nNo quests found."
      return
    end

    quests.each { |quest| quest_details(quest) }
  end

  def quest_choices(quests)
    puts

    quests.each do |quest|
      puts "#{quest.id}. #{quest.title} - #{quest.player.name}"
    end
  end

  def quest_details(quest)
    status = quest.completed? ? "Completed" : "Active"

    puts "\n------------------------"
    puts "Quest: #{quest.title}"
    puts "Adventurer: #{quest.player.name}"
    puts "Description: #{quest.description}"
    puts "Difficulty: #{quest.difficulty}"
    puts "XP Reward: #{quest.xp_reward}"
    puts "Status: #{status}"
    puts "------------------------"
  end

  def completion(quest, player, previous_level)
    puts "\n========================"
    puts "     QUEST COMPLETE!"
    puts "========================"
    puts "#{player.name} earned #{quest.xp_reward} XP."

    level_up(player, previous_level)

    puts "Current Level: #{player.level}"
    puts "Total XP: #{player.current_xp}"
  end

  def abandonment(quest)
    puts "\nQuest abandoned successfully."
    puts "#{quest.title} has been removed."
    puts "No XP was awarded."
  end

  def quest_log(players)
    if players.empty?
      puts "\nNo adventurers have been created yet."
      return
    end

    puts "\n========================"
    puts "       QUEST LOG"
    puts "========================"

    players.each { |player| player_quest_log(player) }
  end

  def errors(record)
    puts "\nUnable to save quest:"

    record.errors.full_messages.each do |message|
      puts "- #{message}"
    end
  end

  private

  def player_quest_log(player)
    quests = player.quests
    completed_quests, active_quests = quests.partition(&:completed?)

    puts "\n#{player.name}"
    puts "Level: #{player.level} | XP: #{player.current_xp}"
    puts "Active: #{active_quests.count}"
    puts "Completed: #{completed_quests.count}"

    display_log_section("ACTIVE QUESTS", active_quests)
    display_log_section("COMPLETED QUESTS", completed_quests)

    puts "========================"
  end

  def display_log_section(title, quests)
    puts "\n#{title}"

    if quests.empty?
      puts "None"
      return
    end

    quests.each do |quest|
      puts "- #{quest.title} | #{quest.difficulty} | #{quest.xp_reward} XP"
    end
  end

  def level_up(player, previous_level)
    return unless player.level > previous_level

    puts "\n#{player.name} leveled up!"
    puts "Level #{previous_level} -> Level #{player.level}"
  end
end
