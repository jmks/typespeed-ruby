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

    @input = UserInput.new(self)
    @ref = Referee.new(@words, @input)
    @scoreboard = Scoreboard.new(@ref)
    @word_gen = WordGenerator.new(dictionary)
  end

  def update
    delta_time!

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
    new_word = @word_gen.update
    return unless new_word

    @words << Word.new(new_word, 240, self)
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
