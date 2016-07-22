# The Typespeed game
class Typespeed < Gosu::Window
  include States
  include DeltaTime

  register_states :splash, :playing, :game_over

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

    @game_over = Gosu::Font.new(48)
    @game_over_text = "Game Over!!"
  end

  def update
    delta_time!

    update_game_state!
    @input.kill_input! if game_over?

    @level.update(@ref)
    clean_up_words
    @scoreboard.update unless game_over?
    update_words
  end

  def draw
    @words.map(&:draw)
    @input.draw
    @scoreboard.draw
    @game_over.draw(@game_over_text, 800 / 2 - @game_over.text_width(@game_over_text) / 2, 600 / 2, 0, 1, 1, Gosu::Color::RED) if game_over?
  end

  def button_down(id)
    return if game_over?

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

  def update_game_state!
    return if game_over?

    game_over! if @ref.game_over?
  end
end
