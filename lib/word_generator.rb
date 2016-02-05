# class to track when to generate new words
class WordGenerator
  include DeltaTime

  NEW_WORD_AFTER = 2500 # ms

  attr_reader :last_word_at, :new_word

  def initialize(dictionary)
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
    @last_word_at.zero? || delta_since(@last_word_at) >= NEW_WORD_AFTER
  end

  def generate_word
    @last_word_at = Gosu.milliseconds
    @dictionary.sample
  end
end
