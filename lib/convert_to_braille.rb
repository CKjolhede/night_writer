require_relative "string_formatting.rb"


class ConvertToBraille
  include StringFormatting
  attr_reader :braille_reference, :braille_characters, :transposed_braille, :braille_strings, :line_segments, :braille_output, :characters

  def initialize
    @braille_reference = braille_reference
    @braille_reference = {
      "a" => ["0.", "..", ".."],
      "b" => ["0.", "0.", ".."],
      "c" => ["00", "..", ".."],
      "d" => ["00", ".0", ".."],
      "e" => ["0.", ".0", ".."],
      "f" => ["00", "0.", ".."],
      "g" => ["00", "00", ".."],
      "h" => ["0.", "00", ".."],
      "i" => [".0", "0.", ".."],
      "j" => [".0", "00", ".."],
      "k" => ["0.", "..", "0."],
      "l" => ["0.", "0.", "0."],
      "m" => ["00", "..", "0."],
      "n" => ["00", ".0", "0."],
      "o" => ["0.", ".0", "0."],
      "p" => ["00", "0.", "0."],
      "q" => ["00", "00", "0."],
      "r" => ["0.", "00", "0."],
      "s" => [".0", "0.", "0."],
      "t" => [".0", "00", "0."],
      "u" => ["0.", "..", "00"],
      "v" => ["0.", "0.", "00"],
      "w" => [".0", "00", ".0"],
      "x" => ["00", "..", "00"],
      "y" => ["00", ".0", "00"],
      "z" => ["0.", ".0", "00"]
    }

  end

  #things to do to incoming text:
  #isolate each character using .chars method
  #convert the individual strings to their braille array equivalent
  #transpose the arrays to put into braille format using transpose method
  #convert the arrays back into strings and combine them using the join method
  #format the strings with limit of 80 characters per line
  def convert(text)
    isolate(text)
    @braille_characters = self.letter_to_braille(@characters)
# require "pry"; binding.pry
    transposer(@braille_characters)
    @braille_strings = self.convert_to_string
    @braille_output = format(@braille_strings)
    @braille_output
  end

  def isolate(text)
    @characters = text.chars
    @characters.delete("\n")
    @characters
  # require "pry"; binding.pry
  end

  def letter_to_braille(characters)
    # require "pry"; binding.pry
      @braille_characters = characters.map {|letter| @braille_reference[letter]}
      @braille_characters.delete(nil)
      @braille_characters
      # characters.map {|letter| @braille_reference[letter]}
  end

  def convert_to_string
    @braille_strings = @transposed_braille.map! {|element| element.join}
    # @transposed_braille.map! {|element| element.join}
  end

# private

  def format(strings)
    if strings[0].length > 80
      split_string(strings)
      transposer(@line_segments)
      final_formatting
      @braille_output
    else
      @braille_output = strings.join("\n")
    end
  end

end
