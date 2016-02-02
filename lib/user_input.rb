class UserInput
  attr_reader :game, :last_submission

  def initialize(game)
    @game = game
    game.text_input = @input = build_input
    @last_submission = ""
  end

  def submit!
    @last_submission = @input.text
    game.text_input  = @input = build_input
    @last_submission
  end

  private

  def build_input
    Gosu::TextInput.new
  end
end
