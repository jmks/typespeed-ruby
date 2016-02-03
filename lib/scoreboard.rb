class Scoreboard
  DISPLAY_FONT_SIZE = 24

  attr_accessor :first_word_at

  def initialize(referee)
    @ref = referee
    @display = Gosu::Font.new(DISPLAY_FONT_SIZE)
  end

  def update
    @score = @ref.correct
  end

  def draw
    @display.draw(score_text, 800 - text_width - 15, 600 - DISPLAY_FONT_SIZE, 0, 1, 1, Gosu::Color::RED)
  end

  private

  def score_text
    "score: #{@score}, wpm: #{wpm}"
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
    @display.text_width(score_text)
  end
end
