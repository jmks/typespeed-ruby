class UserInput
  attr_reader :last_submission

  def initialize(game)
    @game = game
    @game.text_input = @input = build_input
    @last_submission = ""
    @display = Gosu::Font.new(36)
  end

  def submit!
    @last_submission = @input.text
    @game.text_input = @input = build_input
    @last_submission
  end

  def draw
    @display.draw(input_text, 400 - input_width / 2, 600 - 36, 0, 1, 1, Gosu::Color::GREEN)
  end

  private

  def input_text
    "> #{@input.text}"
  end

  def input_width
    @display.text_width(input_text)
  end

  def build_input
    Gosu::TextInput.new
  end
end
