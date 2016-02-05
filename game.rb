require "gosu"
require "pry"

require_relative "lib/states"
require_relative "lib/delta_time"

require_relative "lib/word"
require_relative "lib/word_generator"
require_relative "lib/user_input"
require_relative "lib/referee"
require_relative "lib/scoreboard"
require_relative "lib/typespeed"

Typespeed.new.show
