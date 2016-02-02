class Scoreboard
  def initialize(referee)
    @ref = referee
    @display = Gosu::Font.new(24)
  end

  def update
    @score = @ref.correct
  end

  def draw
    @display.draw(score_text, 800 - text_width - 15, 600 - 24, 0, 1, 1, Gosu::Color::RED)
  end

  private

  def score_text
    "score: #{@score}"
  end

  def text_width
    @display.text_width(score_text)
  end
end
