# frozen_string_literal: true

ENV["RACK_ENV"] ||= "development"

# Require in Gems
require "bundler/setup"
Bundler.require(:default, ENV.fetch("RACK_ENV", nil))
require "active_record"

# Set up database connection directly via Active Record
require "yaml"

db_config = YAML.load_file(File.join(__dir__, "database.yml"))

ActiveRecord::Base.establish_connection(
  db_config[ENV.fetch("RACK_ENV", "development")]
)

# Require in all model files
require_all "app/models"

# Require reusable CLI classes
require_relative "../cli/player_menu"
require_relative "../cli/quest_menu"
require_relative "../cli/quest_cli"
