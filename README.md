# QuestCLI

QuestCLI is a Ruby command-line application built with **Active Record** and **SQLite3** that allows players to create an adventurer, accept quests, complete objectives, earn experience, and level up.

Designed as an RPG-inspired quest manager, QuestCLI demonstrates object-oriented programming principles, database design, Active Record associations, validations, and full CRUD functionality through an interactive command-line interface.

---

# Features

## Adventurer Management

- Create adventurers
- View all adventurers
- View individual adventurer details
- Update adventurer information
- Delete adventurers

## Quest Management

- Accept new quests
- View all quests
- View active quests
- View completed quests
- Update quest information
- Complete quests
- Abandon quests

## Progression System

- Earn experience by completing quests
- Automatic level progression
- Prevent duplicate quest rewards
- Track active and completed quests

---

# Domain Model

QuestCLI contains two Active Record models with a one-to-many relationship.

- A **Player** has many **Quests**
- A **Quest** belongs to one **Player**

```text
Player
------
id
name
level
current_xp

        1
        │
        │ has many
        ▼

Quest
------
id
title
description
difficulty
xp_reward
completed
player_id
```

---

# Technologies

- Ruby
- Active Record
- SQLite3
- Rake

---

# Installation

Clone the repository.

```bash
git clone <repository-url>
```

Navigate into the project.

```bash
cd questcli
```

Install dependencies.

```bash
bundle install
```

Create the database.

```bash
bundle exec rake db:create
```

Run the migrations.

```bash
bundle exec rake db:migrate
```

(Optional) Seed the database.

```bash
bundle exec rake seed
```

Start the application.

```bash
ruby cli/main.rb
```

---

# Example Gameplay

```text
========================
      QUESTCLI
========================

1. Manage Players
2. Manage Quests
3. View Quest Log
4. Exit
```

Accepting a quest:

```text
⚔ Quest Accepted!

Quest:
Recover the Ancient Relic

Difficulty:
Medium

Reward:
250 XP

Status:
Active
```

Completing a quest:

```text
🏆 Quest Complete!

+250 XP

Current XP: 950

LEVEL UP!

You are now Level 4.
```

---

# CRUD Functionality

## Players

### Create

Create a new adventurer.

### Read

View all adventurers or inspect an individual adventurer.

### Update

Modify an adventurer's information.

### Delete

Delete an adventurer and their associated quests.

---

## Quests

### Create

Accept a new quest.

### Read

View all quests, active quests, completed quests, or quests belonging to a specific player.

### Update

Modify quest details.

### Delete

Abandon a quest.

---

# Validations

## Player

- Name is required
- Name must be unique
- Level must be greater than zero
- Current experience cannot be negative

## Quest

- Title is required
- Difficulty is required
- Experience reward must be greater than zero
- Every quest must belong to a player

---

# Project Structure

```text
.
├── app
│   └── models
│       ├── player.rb
│       └── quest.rb
├── cli
│   └── main.rb
├── config
│   ├── database.yml
│   └── environment.rb
├── db
│   ├── migrate
│   └── seeds.rb
└── README.md
```

---

# Future Improvements

Future versions of QuestCLI may include:

- Character classes
- Gold and economy system
- Inventory management
- Equipment
- NPC quest givers
- Random quest generation
- Quest categories
- Achievements
- Player statistics dashboard
- Multiple save files
- ASCII art and enhanced terminal styling

---

# Learning Objectives

This project demonstrates:

- Object-Oriented Programming
- Active Record Associations
- Active Record Validations
- Database Migrations
- SQLite3
- CRUD Operations
- Menu-Driven CLI Design
- Ruby Classes and Modules
- Separation of Concerns

---

# Author

Thomas Correia
