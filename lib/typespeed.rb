# The Typespeed game
class Typespeed < Gosu::Window
  include States
  include DeltaTime

  register_states :splash, :playing, :gameover

  def initialize(width = 800, height = 600, fullscreen = false)
    super
    self.caption = "Typespeed"

    @dictionary = File.open("lib/assets/words.txt").map(&:strip)
    @words = []

    @input = UserInput.new(self)
    @ref = Referee.new(@words, @input)
    @scoreboard = Scoreboard.new(@ref)
  end

  def update
    delta_time!

    update_words
    @scoreboard.update
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
    generate_words
    clean_up_words
  end

  def generate_words
    if @last_word_at.nil?
      generate_word
      @scoreboard.first_word_at = @last_word_at
    elsif delta_since(@last_word_at) > 2500
      generate_word
    end
  end

  def generate_word
    @last_word_at = Gosu.milliseconds
    @words << Word.new(@dictionary.sample, 240, self)
  end

  def clean_up_words
    @words.reject! do |word|
      reject = word.update
      @ref.mark_miss! if reject && !word.user_entered?
      reject
    end
  end
end
