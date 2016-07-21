class WordPlacer
  ROWS = 12

  attr_reader :rows, :cols

  def initialize(window, options = {})
    options = {
      row_size: 30,
      row_padding: 15,
      row_offset: 15,
    }.update(options)

    @rows = build_coordinates(ROWS, options[:row_size], options[:row_padding], options[:row_offset], window.height)
    randomize_rows
  end

  def next_row
    randomize_rows if @next_rows.empty?
    @next_rows.pop
  end

  private

  def build_coordinates(count, size, padding, offset, maximum)
    (0...count)
      .map { |i| i * (size + padding) + offset }
      .reject { |i| i > maximum }
  end

  def randomize_rows
    @next_rows = @rows.sample(@rows.length)
  end
end
