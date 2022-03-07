module StringFormatting

  def split_string
    # require "pry"; binding.
    @line_segments = []
    @braille_strings.each do |line|
      @line_segments << line.chars.each_slice(80).map(&:join)
    end
    @line_segments
    #line_segments is an array with 3 indices, each being a nested array of the top middle and bottom strings, respectively. Each nested array's elements are the original row of braille broken into 80 character segments, with the final segment being some length <= 80
    # require "pry"; binding.pry
  end

  def transposer(braille_characters)
    @transposed_braille = braille_characters.transpose
  end
  # transposer reorganizes the rows such that the top, middle, and bottom lines of each row are placed together within separate nested arrays.

  def final_formatting
    # require "pry"; binding.pry
    @braille_output = @transposed_braille.flatten.join("\n")
    # require "pry"; binding.pry
  end


end
