# frozen_string_literal: true

puts "🌱 Seeding QuestCLI..."

adventurer = Player.find_or_create_by!(name: "Neha") do |player|
  player.level = 1
  player.current_xp = 0
end

quests = [
  {
    title: "Gather Healing Herbs",
    description: "Collect medicinal herbs from the edge of the Whispering Woods.",
    difficulty: "Easy",
    xp_reward: 50,
  },
  {
    title: "Recover the Lost Satchel",
    description: "Find the merchant's missing satchel along the old forest road.",
    difficulty: "Easy",
    xp_reward: 75,
  },
  {
    title: "Defeat the Cave Goblin",
    description: "Enter the northern cave and defeat the goblin troubling nearby travelers.",
    difficulty: "Medium",
    xp_reward: 150,
  },
  {
    title: "Recover the Moonlit Amulet",
    description: "Search the ruined temple and recover the ancient Moonlit Amulet.",
    difficulty: "Hard",
    xp_reward: 300,
  },
]

quests.each do |attributes|
  Quest.find_or_create_by!(
    player: adventurer,
    title: attributes[:title]
  ) do |quest|
    quest.description = attributes[:description]
    quest.difficulty = attributes[:difficulty]
    quest.xp_reward = attributes[:xp_reward]
    quest.completed = false
  end
end

puts "✅ Seeded #{Player.count} adventurer(s)."
puts "✅ Seeded #{Quest.count} quest(s)."
puts "✅ Done seeding!"
