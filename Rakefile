# frozen_string_literal: true

require "standalone_migrations"
StandaloneMigrations::Tasks.load_tasks

desc "Start the console"
task console: :environment do
  Pry.start
end

desc "Seed the database"
task seed: :environment do
  load "db/seeds.rb"
end
