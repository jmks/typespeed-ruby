class Scoreboard
  DISPLAY_FONT_SIZE = 24
  MARGIN_HORIZONTAL = 15

  def initialize(referee)
    @ref = referee
    @font = Gosu::Font.new(DISPLAY_FONT_SIZE)

    @score = @wrong = @misses = 0
  end

  def update
    @score  = @ref.correct
    @wrong  = @ref.incorrect
    @misses = @ref.misses
  end

  def draw
    @font.draw(score_text, 800 - text_width - MARGIN_HORIZONTAL, 600 - DISPLAY_FONT_SIZE, 0, 1, 1, Gosu::Color::GREEN)
    @font.draw(wrong_text, MARGIN_HORIZONTAL, 600 - DISPLAY_FONT_SIZE, 0, 1, 1, Gosu::Color::GREEN)
    @font.draw(miss_text, MARGIN_HORIZONTAL, 600 - DISPLAY_FONT_SIZE - DISPLAY_FONT_SIZE, 0, 1, 1, Gosu::Color::GREEN)
  end

  def new_word_at(milliseconds)
    @first_word_at ||= milliseconds
  end

  private

  def score_text
    "score: #{@score}, wpm: #{wpm}"
  end

  def wrong_text
    "wrong: #{'x' * @wrong}"
  end

  def miss_text
    "miss: #{'o' * @misses}"
  end

  def wpm
    case
    when @ref.correct.zero? then 0
    when elapsed_time.zero? then "n/a"
    else
      (@ref.correct / elapsed_time).round(1)
    end
  end

  def elapsed_time
    if @first_word_at
      (Gosu.milliseconds - @first_word_at).to_f / 60_000
    else
      Float::INFINITY
    end
  end

  def text_width
    @font.text_width(score_text)
  end
end
