# The Typespeed game
class Typespeed < Gosu::Window
  include States
  include DeltaTime

  register_states :splash, :playing, :gameover

  def initialize(width = 800, height = 600, fullscreen = false)
    super
    self.caption = "Typespeed"

    dictionary = File.open("lib/assets/words.txt").map(&:strip)
    @words = []

    @level = Level.new
    @input = UserInput.new(self, @level)
    @ref = Referee.new(@words, @input)
    @scoreboard = Scoreboard.new(@ref)
    @word_gen = WordGenerator.new(dictionary, @level)
    @word_placer = WordPlacer.new(self)
  end

  def update
    delta_time!

    @level.update(@ref)
    clean_up_words
    @scoreboard.update
    update_words
  end

  def draw
    @words.map(&:draw)
    @input.draw
    @scoreboard.draw
  end

  def button_down(id)
    case id
    when Gosu::KbReturn
      @ref.score!
    end
  end

  private

  def update_words
    @word_gen.update
    return unless @word_gen.new_word

    @words << Word.new(@word_gen.new_word, @word_placer.next_row, self, speed: @level.word_speed)
    @scoreboard.new_word_at @word_gen.last_word_at
  end

  def clean_up_words
    @words.reject! do |word|
      reject = word.update
      @ref.mark_miss! if reject && !word.user_entered?
      reject
    end
  end
end
