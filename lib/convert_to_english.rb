require_relative 'convert_to_braille.rb'

class ConvertToEnglish
  attr_reader :english_reference, :braille, :top, :mid, :bot, :zipped

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
    end

    def message_split(braille_text)
      braille_message_length = braille_text.length / 3
      @braille_message_split = braille_text.scan(/.{1,#{braille_message_length}}/)
      @braille_message_split
    end

    def divide_braille_rows(row_array)
      @top = row_array[0].scan(/.{1,2}/)
      @mid = row_array[1].scan(/.{1,2}/)
      @bot = row_array[2].scan(/.{1,2}/)
    end

    def zip_braille_arrays(top_row, mid_row, bot_row)
      @zipped = top_row.zip(mid_row, bot_row)
    end

    def braille_to_english(zipped_array)
      zipped_array.map! {|letter| @english_reference[letter]}
    end

end
