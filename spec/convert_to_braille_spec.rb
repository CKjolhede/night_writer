require './lib/convert_to_braille.rb'
require './lib/string_formatting.rb'
# require 'test_message.txt'


RSpec.describe ConvertToBraille do
  before :each do
    @braille = ConvertToBraille.new
      handle = File.open("test_message.txt", "r")
      #test message text is:  abc
      @incoming_text = handle.read
      handle.close
  end

  it "exists" do
    expect(@braille).to be_a(ConvertToBraille)
  end

  it 'can return the braille refernce set' do
    expect(@braille.braille_reference['a']).to eq(["0.", "..", ".."])
    expect(@braille.braille_reference['z']).to eq(["0.", ".0", "00"])
  end

  it 'can isolate individual characters from text' do
    expected = @braille.isolate(@incoming_text)
    #test message is "abc"
    # require "pry"; binding.pry
    # expect(expected).to eq(["a", "b", "c", "\n"])
  end
end

  context "isolated characters" do
    before :each do
      @braille = ConvertToBraille.new
        handle = File.open("test_message.txt", "r")
        #test message text is:  abc
        @incoming_text = handle.read
        handle.close
        @characters = @braille.isolate(@incoming_text)
        # @characters.pop
    end

    it 'can change each @characters into their braille equivalent' do
      expected = @braille.letter_to_braille(@characters)
      # require "pry"; binding.pry
      expect(expected).to eq([["0.", "..", ".."], ["0.", "0.", ".."], ["00", "..", ".."]])
    end
  end

  context "Transform Braille Character Array" do
    before :each do
      @braille = ConvertToBraille.new
      handle = File.open("test_message.txt", "r")
      #test message text is:  abc
      @incoming_text = handle.read
      handle.close
      @characters = @braille.isolate(@incoming_text)
      # @characters.pop
      @braille_characters = @braille.letter_to_braille(@characters)
    end

    it "can transpose @braille_characters array" do
      expected = @braille.transposer(@braille_characters)
      expect(expected).to eq([["0.", "0.", "00"],["..", "0.", ".."],["..", "..", ".."]])
    end

    it 'can convert the transposed array into strings' do
      # @transposed_braille.map! {|element| element.join }
      @braille.transposer(@braille_characters)
      expected = @braille.convert_to_string
      # require "pry"; binding.pry
      expect(expected).to eq(["0.0.00","..0...","......"])
    end
  end

  context "incoming text over 80 characters" do
    before :each do
      @braille = ConvertToBraille.new
      handle = File.open("long_test_message.txt", "r")
      handle_short = File.open("test_message.txt", "r")
      #long test message text is:  abcdefghijklmnopqrstuvwxyzisthistheendofthelinethisistheextra
      @incoming_text = handle.read
      @short_text = handle_short.read
      handle.close
      handle_short.close

      @characters = @braille.isolate(@incoming_text)
      # @characters.pop
      @braille_characters = @braille.letter_to_braille(@characters)
      @braille.transposer(@braille.braille_characters)
      # require "pry"; binding.nit
      @braille.convert_to_string
    end

    it "can divide braille string into separate strings of 80 characters" do
      top_row_segment = @braille.split_string(@braille.braille_strings)[0][0].length
      middle_row_segment = @braille.split_string(@braille.braille_strings)[1][0].length
      bottom_row_segment = @braille.split_string(@braille.braille_strings)[2][0].length
      expect(top_row_segment).to eq(80)
      expect(middle_row_segment).to eq(80)
      expect(bottom_row_segment).to eq(80)
    end

    it 'can transpose segmented braille arrays' do
      first_top_row_segment = @braille.split_string(@braille.braille_strings)[0][0]
      first_middle_row_segment = @braille.split_string(@braille.braille_strings)[1][0]
      first_bottom_row_segment = @braille.split_string(@braille.braille_strings)[2][0]
      second_top_row_segment = @braille.split_string(@braille.braille_strings)[0][1]
      second_middle_row_segment = @braille.split_string(@braille.braille_strings)[1][1]
      second_bottom_row_segment = @braille.split_string(@braille.braille_strings)[2][1]
      # require "pry"; binding.pry
      expected = @braille.transposer(@braille.line_segments)
      expect(expected[0][0]).to eq(first_top_row_segment)
      expect(expected[0][1]).to eq(first_middle_row_segment)
      expect(expected[0][2]).to eq(first_bottom_row_segment)
      expect(expected[1][0]).to eq(second_top_row_segment)
      expect(expected[1][1]).to eq(second_middle_row_segment)
      expect(expected[1][2]).to eq(second_bottom_row_segment)
    end

    it 'can properly format final converted braille text' do
      @braille.split_string(@braille.braille_strings)
      @braille.transposer(@braille.line_segments)
      expected = @braille.final_formatting
      # require "pry"; binding.psry
      expect(expected).to eq("0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000..0.0.00..0.0.00.0.0.00000.00\n..0....0.00.00000.00..0....0.00.00000.00..0.00...0.00.0.00000.0.0000.0.0.0.0.00.\n....................0.0.0.0.0.0.0.0.0.0.0000.0000000..0.0.....0.0.......0...0...\n.00.0.0..0000..00..0.0.0.0.00.0.0.00.00.0.\n0000.00.0..0.000000.0.0.0.0000.0.0..0000..\n0.....0...0...0.....0...0.0.......000.0...")
    end

    it "can properly format converted text if longer than 80 characters" do
      expected = @braille.format(@braille.braille_strings)
      expect(expected).to eq("0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000..0.0.00..0.0.00.0.0.00000.00\n..0....0.00.00000.00..0....0.00.00000.00..0.00...0.00.0.00000.0.0000.0.0.0.0.00.\n....................0.0.0.0.0.0.0.0.0.0.0000.0000000..0.0.....0.0.......0...0...\n.00.0.0..0000..00..0.0.0.0.00.0.0.00.00.0.\n0000.00.0..0.000000.0.0.0.0000.0.0..0000..\n0.....0...0...0.....0...0.0.......000.0...")
    end
  end

    context "Convert helper method" do
      before :each do
        @braille = ConvertToBraille.new
        handle = File.open("long_test_message.txt", "r")
        handle_short = File.open("test_message.txt", "r")
        #long test message text is:  abcdefghijklmnopqrstuvwxyzisthistheendofthelinethisistheextra
        @incoming_text = handle.read
        @short_text = handle_short.read
        handle.close
        handle_short.close
      end

      it "can convert a short text string into braille" do
        expected = @braille.convert(@short_text)
        expect(expected).to eq("0.0.00\n..0...\n......")
      end

      it "can convert > 80 characters into formated braille file" do
        #@incoming_text file contains 61 characters. The resulting braile.txt file should contain 6x that.  366 characters
        expected = @braille.convert(@incoming_text)
        expect(expected).to eq("0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000..0.0.00..0.0.00.0.0.00000.00\n..0....0.00.00000.00..0....0.00.00000.00..0.00...0.00.0.00000.0.0000.0.0.0.0.00.\n....................0.0.0.0.0.0.0.0.0.0.0000.0000000..0.0.....0.0.......0...0...\n.00.0.0..0000..00..0.0.0.0.00.0.0.00.00.0.\n0000.00.0..0.000000.0.0.0.0000.0.0..0000..\n0.....0...0...0.....0...0.0.......000.0...")
      end
  end
#
