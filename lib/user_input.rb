class UserInput
  DISPLAY_FONT_SIZE = 36

  attr_reader :last_submission

  def initialize(game, level)
    @game = game
    @level = level
    @game.text_input = @input = build_input
    @last_submission = ""
    @display = Gosu::Font.new(DISPLAY_FONT_SIZE)
    @kill_input = false
  end

  def submit!
    return if input_killed?
    @last_submission = @input.text
    @game.text_input = @input = build_input
    @last_submission
  end

  def draw
    if @level.typing_visible? && !input_killed?
      @display.draw(input_text, 400 - input_width / 2, 600 - DISPLAY_FONT_SIZE, 0, 1, 1, Gosu::Color::GREEN)
    end
  end

  def kill_input!
    @kill_input = true
    @game.text_input = @input = nil
  end

  private

  def input_text
    input_killed? ? "" : "> #{@input.text}"
  end

  def input_width
    @display.text_width(input_text)
  end

  def build_input
    Gosu::TextInput.new
  end

  def input_killed?
    @kill_input
  end
end
