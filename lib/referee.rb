class Referee
  MISSES_TO_GAME_OVER = 3

  attr_reader :submissions, :correct, :incorrect, :misses

  def initialize(words, user_input)
    @words = words
    @user_input = user_input

    @submissions = 0
    @correct     = 0
    @misses      = 0
  end

  def incorrect
    @submissions - @correct
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
      false
    end
  end

  def mark_miss!
    @misses += 1
  end

  def game_over?
    misses >= MISSES_TO_GAME_OVER
  end
end
