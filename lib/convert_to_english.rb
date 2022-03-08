require_relative 'convert_to_braille.rb'

class ConvertToEnglish
  attr_reader :english_reference, :braille, :top, :mid, :bot, :zipped, :braille_message_row_count, :separated_braille_rows, :braille_message_length

  def initialize
    @braille = ConvertToBraille.new
    @english_reference = {
      ["0.", "..", ".."]=>"a",
       ["0.", "0.", ".."]=>"b",
       ["00", "..", ".."]=>"c",
       ["00", ".0", ".."]=>"d",
       ["0.", ".0", ".."]=>"e",
       ["00", "0.", ".."]=>"f",
       ["00", "00", ".."]=>"g",
       ["0.", "00", ".."]=>"h",
       [".0", "0.", ".."]=>"i",
       [".0", "00", ".."]=>"j",
       ["0.", "..", "0."]=>"k",
       ["0.", "0.", "0."]=>"l",
       ["00", "..", "0."]=>"m",
       ["00", ".0", "0."]=>"n",
       ["0.", ".0", "0."]=>"o",
       ["00", "0.", "0."]=>"p",
       ["00", "00", "0."]=>"q",
       ["0.", "00", "0."]=>"r",
       [".0", "0.", "0."]=>"s",
       [".0", "00", "0."]=>"t",
       ["0.", "..", "00"]=>"u",
       ["0.", "0.", "00"]=>"v",
       [".0", "00", ".0"]=>"w",
       ["00", "..", "00"]=>"x",
       ["00", ".0", "00"]=>"y",
       ["0.", ".0", "00"]=>"z"}
       @separated_braille_rows = []
       @zipped = []
       @braille_message_row_count = braille_message_row_count
    end

    def convert(text)
      message_split(text)
      divide_braille_rows(@braille_message_split)
      zip_braille_arrays(@top, @mid, @bot)
      braille_to_english(@zipped)
      combine_characters(@zipped)
      @output_english_text
      # require "pry"; binding.pry
    end

    def message_split(braille_text)
      @braille_message_length = braille_text.length / 3
      @braille_message_row_count = ((@braille_message_length / 80).to_f).ceil
      @braille_message_split = braille_text.scan(/.{1,#{braille_message_length}}/)
      @braille_message_split
      # require "pry"; binding.pry
    end

    def divide_braille_rows(row_array, n = 1, index = 0)
      while n <= @braille_message_row_count
        array = []
          3.times do
            element = row_array[index].scan(/.{1,2}/)
            array << element
            index += 1
          end
          n += 1
        @separated_braille_rows << array
        # require "pry"; binding.pry
      end
    end

    def zip_braille_arrays(count = @braille_message_row_count,sep = @separated_braille_rows, n = 0)

      until n > (count - 1)
        text_line = sep[n][0].zip(sep[n][1], sep[n][2])
        @zipped << text_line
        n += 1
      end
      @zipped = @zipped.flatten(1)
        # require "pry"; binding.pry
    end

    def braille_to_english(zipped_array)
      zipped_array.map! {|row| row.map! {|letter| @english_reference[letter]}}.join("\n")
    end

    def combine_characters(converted_array)
      @output_english_text = converted_array.join.to_s
    end

end
