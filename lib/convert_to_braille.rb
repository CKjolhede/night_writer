class ConvertToBraille
  attr_reader :braille_reference, :braille_characters

  def initialize
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

  def isolate(text)
    @characters = text.chars
  end

  def letter_to_braille(characters)
    @braille_characters = @characters.map {|letter| @braille_reference[letter]}
  end

  def transposer(braille_characters)
    @transposed_braille = braille_characters.transpose
  end
end
