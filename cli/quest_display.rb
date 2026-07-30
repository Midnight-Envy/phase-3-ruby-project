require_relative "colors"

class QuestDisplay
  def menu
    puts
    puts "========================"
    puts Colors.heading("       QUEST MENU")
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
    print "\n#{Colors.yellow('Choose an option: ')}"
  end

  def quests(quests)
    quests = quests.to_a

    if quests.empty?
      puts "\n#{Colors.warning('No quests found.')}"
      return
    end

    quests.each_with_index do |quest, index|
      quest_details(quest, index + 1)
    end
  end

  def quest_choices(quests)
    puts

    quests.each_with_index do |quest, index|
      number = Colors.cyan(index + 1)

      puts "#{number}. #{quest.title} - #{quest.player.name}"
    end
  end

  def quest_details(quest, number = nil)
    puts "\n------------------------"

    puts "#{Colors.bold('Quest Number:')} #{number}" if number

    puts "#{Colors.bold('Quest:')} #{Colors.heading(quest.title)}"
    puts "#{Colors.bold('Adventurer:')} #{quest.player.name}"
    puts "#{Colors.bold('Description:')} #{quest.description}"
    puts "#{Colors.bold('Difficulty:')} #{Colors.difficulty(quest.difficulty)}"
    puts "#{Colors.bold('XP Reward:')} #{Colors.xp("#{quest.xp_reward} XP")}"
    puts "#{Colors.bold('Status:')} #{Colors.status(quest.completed?)}"
    puts "------------------------"
  end

  def completion(quest, player, previous_level)
    puts
    puts Colors.bright_green("========================")
    puts Colors.bold(Colors.bright_green("     QUEST COMPLETE!"))
    puts Colors.bright_green("========================")
    puts Colors.success(quest.title)
    puts "#{player.name} earned #{Colors.xp("+#{quest.xp_reward} XP")}."

    level_up(player, previous_level)

    puts "#{Colors.bold('Current Level:')} #{Colors.xp(player.level)}"
    puts "#{Colors.bold('Total XP:')} #{Colors.xp(player.current_xp)}"
  end

  def abandonment(quest)
    puts "\n#{Colors.warning('Quest abandoned successfully.')}"
    puts "#{quest.title} has been removed."
    puts Colors.yellow("No XP was awarded.")
  end

  def quest_log(players)
    if players.empty?
      puts "\n#{Colors.warning('No adventurers have been created yet.')}"
      return
    end

    puts
    puts "========================"
    puts Colors.heading("       QUEST LOG")
    puts "========================"

    players.each { |player| player_quest_log(player) }
  end

  def errors(record)
    puts "\n#{Colors.error('Unable to save quest:')}"

    record.errors.full_messages.each do |message|
      puts Colors.red("- #{message}")
    end
  end

  private

  def player_quest_log(player)
    quests = player.quests
    completed_quests, active_quests = quests.partition(&:completed?)

    puts "\n#{Colors.heading(player.name)}"
    puts "#{Colors.bold('Level:')} #{Colors.xp(player.level)} | " \
         "#{Colors.bold('XP:')} #{Colors.xp(player.current_xp)}"
    puts "#{Colors.yellow('Active:')} #{active_quests.count}"
    puts "#{Colors.green('Completed:')} #{completed_quests.count}"

    display_log_section("ACTIVE QUESTS", active_quests)
    display_log_section("COMPLETED QUESTS", completed_quests)

    puts "========================"
  end

  def display_log_section(title, quests)
    puts "\n#{Colors.heading(title)}"

    if quests.empty?
      puts Colors.warning("None")
      return
    end

    quests.each_with_index do |quest, index|
      difficulty = Colors.difficulty(quest.difficulty)
      reward = Colors.xp("#{quest.xp_reward} XP")

      puts "#{index + 1}. #{quest.title} | #{difficulty} | #{reward}"
    end
  end

  def level_up(player, previous_level)
    return unless player.level > previous_level

    puts
    puts Colors.bold(Colors.bright_magenta("★ LEVEL UP! ★"))
    puts "#{player.name} reached " \
         "#{Colors.xp("Level #{player.level}")}!"
    puts "Level #{previous_level} -> Level #{player.level}"
  end
end
