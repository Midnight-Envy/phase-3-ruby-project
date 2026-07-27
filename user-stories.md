# QuestForge

## Overview

QuestForge is a Ruby command-line application designed for users who want to manage an RPG-inspired adventurer and quest log.

Users can create an adventurer, accept quests, update quest information, complete quests, earn experience points, and remove quests they no longer want to pursue.

The goal is to create a simple but engaging CLI experience that demonstrates CRUD operations, Active Record associations, database management, validations, and object-oriented Ruby design.

---

# User Stories

## Feature 1 - Create and Manage Adventurers

**User Story:** As a user, I want to create and manage an adventurer so that I have a character who can accept quests and earn experience.

### Details

* Create a new player
* Enter a player name
* Assign a starting level of 1
* Assign starting experience of 0
* Save the player to the database
* View all saved players
* View an individual player's information
* Update a player's name
* Delete a player
* Display validation errors when player information is invalid
* Confirm before deleting a player

---

## Feature 2 - Create and View Quests

**User Story:** As a user, I want to create quests for an adventurer so that I can give the player objectives to complete.

### Details

* Select the player receiving the quest
* Enter a quest title
* Enter a quest description
* Select a quest difficulty
* Assign an experience-point reward
* Save the quest to the database
* Display the newly created quest
* View all quests
* View quests belonging to a specific player
* View active quests
* View completed quests
* Display the player associated with each quest
* Display validation errors when quest information is invalid

---

## Feature 3 - Update Quest Information

**User Story:** As a user, I want to edit an existing quest so that I can correct mistakes or change the quest details.

### Details

* Select a quest to update
* Display the current quest title before requesting a new value
* Display the current description before requesting a new value
* Display the current difficulty before requesting a new value
* Display the current experience reward before requesting a new value
* Allow the user to keep an existing value by leaving the input blank
* Save updated quest information to the database
* Display confirmation after the quest is updated
* Display validation errors when updated information is invalid

---

## Feature 4 - Complete Quests and Earn Experience

**User Story:** As a user, I want to complete quests and earn experience so that my adventurer can progress.

### Details

* Select an active quest
* Mark the quest as completed
* Add the quest's experience reward to the associated player
* Save the updated quest
* Save the player's updated experience
* Display the amount of experience earned
* Prevent a completed quest from awarding experience more than once
* Display confirmation after completing a quest
* Display the player's updated level and experience

---

## Feature 5 - Player Level Progression

**User Story:** As a user, I want my adventurer to level up after earning enough experience so that completing quests feels rewarding.

### Details

* Calculate a player's level using accumulated experience
* Check for a level increase after completing a quest
* Update the player's level when the required experience is reached
* Display a level-up message
* Display the player's current level
* Display the player's current experience
* Keep the level calculation inside the Player model

---

## Feature 6 - Delete and Abandon Quests

**User Story:** As a user, I want to delete quests so that I can remove objectives I no longer want to pursue.

### Details

* Select a quest to delete
* Display the selected quest before deletion
* Ask the user to confirm the deletion
* Delete the quest from the database
* Return to the quest menu after deletion
* Display confirmation after the quest is deleted
* Handle an invalid quest selection without crashing the application

---

## Feature 7 - CLI Navigation and User Feedback

**User Story:** As a user, I want a clear menu-driven interface so that I can navigate the application and understand the result of each action.

### Details

* Display a main menu
* Display numbered menu choices
* Keep the application running inside a loop
* Allow the user to return to the previous menu
* Allow the user to exit the application
* Handle invalid menu choices
* Display clear success messages
* Display clear error messages
* Format player and quest information for readability
* Separate CLI responsibilities into at least two Ruby classes
* Use reusable helper methods to avoid repeated code

---

# MVP Features

The initial project scope will include:

* Create players
* View players
* Update players
* Delete players
* Create quests
* View all quests
* View quests belonging to a player
* Update quests
* Complete quests
* Delete quests
* Award experience for completed quests
* Level up players
* Display validation errors
* Menu-driven CLI navigation

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
1. Create Quest
2. View All Quests
3. View Active Quests
4. View Completed Quests
5. Update Quest
6. Complete Quest
7. Delete Quest
8. Return to Main Menu
```

---

# Planned Classes

* Player
* Quest
* QuestForgeCLI
* PlayerMenu
* QuestMenu

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

```txt
Player
  |
  | has many
  |
  v
Quest
```

```ruby
class Player < ActiveRecord::Base
  has_many :quests, dependent: :destroy
end
```

```ruby
class Quest < ActiveRecord::Base
  belongs_to :player
end
```

---

# Validations

## Player Validations

* Name must be present
* Name must be unique
* Level must be greater than 0
* Current experience must be 0 or greater

## Quest Validations

* Title must be present
* Difficulty must be present
* Experience reward must be greater than 0
* Completed must be either true or false
* Player must exist

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

* Player
* Quest

## One-to-Many Relationship

* Player has many Quests
* Quest belongs to Player

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

* Search quests by title
* Sort quests by difficulty
* Randomly generate quests
* Add gold rewards
* Add character classes
* Add quest categories
* Add deadlines to quests
* Display player statistics
* Display completion percentages
* Add achievements
* Add an inventory system
* Add items as a third model
* Add multiple experience progression systems
* Add ASCII art and enhanced CLI styling
