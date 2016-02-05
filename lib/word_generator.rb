# class to track when to generate new words
class WordGenerator
  include DeltaTime

  NEW_WORD_AFTER = 2500 # ms

  attr_reader :last_word_at

  def initialize(dictionary)
    @last_word_at = 0
    @dictionary = dictionary
  end

  def update
    delta_time!
    return unless @last_word_at.zero? || delta_since(@last_word_at) >= NEW_WORD_AFTER
    generate_word
  end

  private

  def generate_word
    @last_word_at = Gosu.milliseconds
    @dictionary.sample
  end
end
