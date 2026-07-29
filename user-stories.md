# QuestCLI

## Overview

QuestCLI is a Ruby command-line application designed for users who want to manage an RPG-inspired adventurer and quest log.

Users can create an adventurer, accept quests, update quest information, complete quests, earn experience points, level up, and abandon quests they no longer wish to pursue.

The goal is to create a simple but engaging CLI experience that demonstrates CRUD operations, Active Record associations, database management, validations, and object-oriented Ruby design.

---

# User Stories

## Feature 1 - Create and Manage Adventurers

**User Story:** As a user, I want to create and manage an adventurer so that I have a character who can accept quests and earn experience.

### Details

- Create a new player
- Enter a player name
- Assign a starting level of 1
- Assign starting experience of 0
- Save the player to the database
- View all saved players
- View an individual player's information
- Update a player's name
- Delete a player
- Display validation errors when player information is invalid
- Confirm before deleting a player

---

## Feature 2 - Accept and View Quests

**User Story:** As a user, I want my adventurer to accept quests so that they can begin working toward objectives and earning experience.

### Details

- Select the player receiving the quest
- Enter a quest title
- Enter a quest description
- Select a quest difficulty
- Assign an experience-point reward
- Save the quest to the database
- Automatically mark newly accepted quests as active
- Display a "Quest Accepted" confirmation message
- Display the newly accepted quest
- View all quests
- View quests belonging to a specific player
- View active quests
- View completed quests
- Display the player associated with each quest
- Display validation errors when quest information is invalid

---

## Feature 3 - Update Quest Information

**User Story:** As a user, I want to edit an existing quest so that I can correct mistakes or change the quest details.

### Details

- Select a quest to update
- Display the current quest title before requesting a new value
- Display the current description before requesting a new value
- Display the current difficulty before requesting a new value
- Display the current experience reward before requesting a new value
- Allow the user to keep an existing value by leaving the input blank
- Save updated quest information to the database
- Display confirmation after the quest is updated
- Display validation errors when updated information is invalid

---

## Feature 4 - Complete Quests and Earn Experience

**User Story:** As a user, I want my adventurer to complete accepted quests so that they earn experience and grow stronger.

### Details

- Select an active quest
- Confirm quest completion
- Mark the quest as completed
- Add the quest's experience reward to the associated player
- Save the updated quest
- Save the player's updated experience
- Display a "Quest Complete" confirmation message
- Display the amount of experience earned
- Display the player's updated level and experience
- Prevent a completed quest from being completed twice
- Prevent a completed quest from awarding experience more than once

---

## Feature 5 - Player Level Progression

**User Story:** As a user, I want my adventurer to level up after earning enough experience so that completing quests feels rewarding.

### Details

- Calculate a player's level using accumulated experience
- Check for a level increase after completing a quest
- Update the player's level when the required experience is reached
- Display a level-up message
- Display the player's current level
- Display the player's current experience
- Keep the level calculation inside the Player model

---

## Feature 6 - Abandon Quests

**User Story:** As a user, I want to abandon quests so that I can remove objectives I no longer want to pursue.

### Details

- Select a quest to abandon
- Display the selected quest before deletion
- Ask the user to confirm the deletion
- Delete the quest from the database
- Return to the quest menu after deletion
- Display confirmation after the quest is abandoned
- Handle an invalid quest selection without crashing the application

---

## Feature 7 - CLI Navigation and User Feedback

**User Story:** As a user, I want a clear menu-driven interface so that I can navigate the application and understand the result of each action.

### Details

- Display a main menu
- Display numbered menu choices
- Keep the application running inside a loop
- Allow the user to return to the previous menu
- Allow the user to exit the application
- Handle invalid menu choices
- Display clear success messages
- Display clear error messages
- Format player and quest information for readability
- Separate CLI responsibilities into at least two Ruby classes
- Use reusable helper methods to avoid repeated code

---

## Feature 8 - Color-Coded CLI Feedback

**User Story:** As a player, I want important information in the CLI to use consistent colors so that I can quickly understand quest difficulty, status, rewards, errors, and successful actions.

### Details

- Menu headings and decorative separators remain white.
- Successful actions and completed quests display in green.
- Errors and invalid selections display in red.
- Prompts, warnings, confirmations, and active quests display in yellow.
- XP rewards and level-up information display in magenta.
- Easy difficulty displays in green.
- Medium difficulty displays in yellow.
- Hard difficulty displays in red.
- Color formatting is managed through a reusable `Colors` module.
- Existing player and quest functionality continues to work.

---



# Quest Lifecycle

```text
Quest Accepted
      │
      ▼
Active Quest
      │
      ▼
Quest Updated (optional)
      │
      ▼
Quest Completed
      │
      ▼
Experience Awarded
      │
      ▼
Player Levels Up (if enough XP)
```

A quest may also be abandoned before it is completed.

---

# MVP Features

The initial project scope will include:

- Create players
- View players
- Update players
- Delete players
- Accept quests
- View all quests
- View quests belonging to a player
- Update quests
- Complete quests
- Abandon quests
- Award experience for completed quests
- Prevent completed quests from awarding experience twice
- Level up players
- Display validation errors
- Menu-driven CLI navigation

---

# CLI Menus

## Main Menu

```txt
1. Manage Players
2. Manage Quests
3. View Quest Log
4. Exit
```

## Player Menu

```txt
1. Create Player
2. View All Players
3. View Player Details
4. Update Player
5. Delete Player
6. Return to Main Menu
```

## Quest Menu

```txt
1. Accept Quest
2. View All Quests
3. View Active Quests
4. View Completed Quests
5. Update Quest
6. Complete Quest
7. Abandon Quest
8. Return to Main Menu
```

---

# Planned Classes

- Player
- Quest
- QuestCLI
- PlayerMenu
- QuestMenu

The exact CLI class structure may be adjusted during development, but the application will contain at least two Ruby classes responsible for CLI behavior.

---

# Database Structure

## Players

```txt
players
-------
id
name
level
current_xp
created_at
updated_at
```

## Quests

```txt
quests
------
id
title
description
difficulty
xp_reward
completed
player_id
created_at
updated_at
```

---

# Model Relationships

A Player has many Quests.

A Quest belongs to one Player.

```text
Player
  |
  | has many
  |
  ▼
Quest
```

```ruby
class Player < ActiveRecord::Base
  has_many :quests, dependent: :destroy
end

class Quest < ActiveRecord::Base
  belongs_to :player
end
```

---

# Validations

## Player Validations

- Name must be present
- Name must be unique
- Level must be greater than 0
- Current experience must be 0 or greater

## Quest Validations

- Title must be present
- Difficulty must be present
- Experience reward must be greater than 0
- Completed must be either true or false
- Player must exist

---

# Technical Challenges

## Managing Active Record Associations

Creating quests that correctly belong to a player and displaying the associated records.

## Updating Existing Records

Showing the current database value before asking the user to enter an updated value.

## Experience and Level Progression

Awarding experience when a quest is completed while preventing the same quest from awarding experience multiple times.

## User Input Validation

Handling invalid menu choices, missing records, blank values, and failed Active Record validations without crashing the application.

## CLI Organization

Separating menu navigation, user input, and database interactions into organized and reusable Ruby methods and classes.

---

# Meeting Project Requirements

## Active Record

All database interactions will use Active Record.

## Models

The application will contain at least two Active Record models:

- Player
- Quest

## One-to-Many Relationship

- Player has many Quests
- Quest belongs to Player

## CRUD Operations

The application will allow users to create, read, update, and delete player and quest records.

## Validations

At least one model will contain Active Record validations.

## CLI Classes

The application will contain at least two Ruby classes responsible for menu navigation and CLI behavior.

## Menu Loop

The application will use a loop-based menu that continues running until the user chooses to exit.

## Update Prompts

Update prompts will display the current value before asking the user to enter a replacement.

---

# Stretch Goals

These features are not required for the MVP:

-Character classes
-Gold rewards
-Items
-Adventurer inventory
-Quest prerequisites
-Store
-Quest steps and interactions
-Full seed data
-Final balancing and CLI polish

# Stretch Goal User Stories

These user stories describe optional features that expand QuestCLI into a more complete playable RPG experience.

## Feature 9 - Character Classes

**User Story:** As a player, I want my adventurer to specialize into a character class so that the adventurer has a distinct identity and progression path.

### Details

- An eligible adventurer can choose from available character classes.
- The selected class is saved to the adventurer.
- An adventurer cannot select an invalid class.
- An adventurer cannot repeatedly change classes unless the game explicitly allows it.
- The adventurer's class appears in their details.
- Existing adventurers remain valid before selecting a class.

## Feature 10 - Gold Rewards

**User Story:** As a player, I want quests to reward gold so that I can purchase useful items.

### Details

- Players have a gold balance.
- Quests may define a gold reward.
- Completing a quest adds its gold reward to the player.
- Gold is awarded only once per quest.
- The player's current gold appears in their details.

## Feature 11 - Quest Item Rewards

**User Story:** As a player, I want quests to reward items so that completing adventures can unlock tools and valuable objects.

### Details

- Quests may reward one or more items.
- Quest rewards are added to the player's inventory.
- Rewards are granted only after successful quest completion.
- The CLI displays the items earned.
- The same reward is not granted more than once.

## Feature 12 - Adventurer Inventory

**User Story:** As a player, I want my adventurer to have an inventory so that I can collect, view, and use items.

### Details

- A player can own multiple items.
- Inventory tracks the quantity of each item.
- The player can view their inventory.
- Purchased and rewarded items are added to inventory.
- Empty inventories display a clear message.

## Feature 13 - Quest Prerequisites

**User Story:** As a player, I want quests to have prerequisites so that progression feels meaningful and advanced quests must be earned.

### Details

- A quest may require a minimum level.
- A quest may require a character class.
- A quest may require one or more inventory items.
- A quest may require another quest to be completed.
- The player cannot begin an unavailable quest.
- The CLI explains every unmet prerequisite.

## Feature 14 - Item Store

**User Story:** As a player, I want to purchase items from a store so that I can prepare for future quests.

### Details

- The store displays available items.
- Each item displays a name, description, and gold price.
- Players can purchase items they can afford.
- Purchased items are added to inventory.
- The cost is deducted from the player's gold.
- Players cannot purchase items they cannot afford.
- Invalid purchases display a clear error.

## Feature 15 - Interactive Quest Steps

**User Story:** As a player, I want quests to contain interactive steps so that completing a quest feels like playing an adventure instead of selecting a single menu option.

### Details

- A quest contains one or more ordered steps.
- The number and complexity of steps can vary by difficulty.
- Steps may include riddles, combat, choices, obstacles, dialogue, and item use.
- Required steps must be completed in order.
- Failed or invalid input does not automatically complete the quest.
- The quest completes only after all required steps are finished.
- Rewards are granted after the final step.

## Feature 16 - Difficulty-Based Quest Depth

**User Story:** As a player, I want harder quests to contain more challenging and longer interactions so that difficulty affects gameplay rather than only rewards.

### Details

- Easy quests contain a small number of simple steps.
- Medium quests contain multiple interactions.
- Hard quests contain longer sequences and more demanding prerequisites.
- Difficulty affects XP, gold, and possible item rewards.
- The CLI clearly displays quest difficulty.

## Feature 17 - Seeded Adventure

**User Story:** As a new player, I want the game to include a complete seeded adventure so that I can create an adventurer and begin playing immediately.

### Details

- The seed file creates reusable items.
- The seed file creates store inventory.
- The seed file creates quests of every difficulty.
- Seeded quests include XP and gold rewards.
- Some quests include item rewards.
- Some quests include prerequisites.
- Seeded quests contain interactive steps.
- Quests form a logical progression.
- Running the seed task does not create uncontrolled duplicate data.
- A new user can play without manually creating every quest.
