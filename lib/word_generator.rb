# class to track when to generate new words
class WordGenerator
  include DeltaTime

  attr_reader :last_word_at, :new_word

  def initialize(dictionary, level)
    @level = level
    @last_word_at = 0
    @dictionary = dictionary
    @new_word = nil
  end

  def update
    delta_time!
    @new_word = new_word? ? generate_word : nil
  end

  private

  def new_word?
    @last_word_at.zero? || delta_since(@last_word_at) >= @level.word_delay
  end

  def generate_word
    @last_word_at = Gosu.milliseconds
    @dictionary.sample
  end
end
