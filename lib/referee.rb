class Referee
  attr_reader :submissions, :correct, :incorrect

  def initialize(words, user_input)
    @words = words
    @user_input = user_input

    @submissions = 0
    @correct     = 0
    @incorrect   = 0
  end

  def score!
    typed = @user_input.submit!
    @submissions += 1

    word = @words.detect { |w| w.value == typed }
    if word
      word.user_entered!
      @correct += 1
      true
    else
      @incorrect += 1
      false
    end
  end
end
