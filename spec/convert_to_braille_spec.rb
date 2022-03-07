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
    expect(expected).to eq(["a", "b", "c", "\n"])
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
        @characters.pop
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
      @characters.pop
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
      #test message text is:  abc
      @incoming_text = handle.read
      handle.close
      @characters = @braille.isolate(@incoming_text)
      @characters.pop
      @braille_characters = @braille.letter_to_braille(@characters)
      @braille.transposer(@braille_characters)
      @braille.convert_to_string
      # require "pry"; binding.pry
    end

    it "can divide braille string into separate strings of 80 characters" do
      top_row_segment = @braille.split_string[0][0].length
      middle_row_segment = @braille.split_string[1][0].length
      bottom_row_segment = @braille.split_string[2][0].length
      expect(top_row_segment).to eq(80)
      expect(middle_row_segment).to eq(80)
      expect(bottom_row_segment).to eq(80)
    end

    it 'can transpose segmented braille arrays' do
      first_top_row_segment = @braille.split_string[0][0]
      first_middle_row_segment = @braille.split_string[1][0]
      first_bottom_row_segment = @braille.split_string[2][0]
      # require "pry"; binding.pry
      expected = @braille.transposer(@braille.split_string)
      expect(expected[0][0]).to eq(first_top_row_segment)
      expect(expected[0][1]).to eq(first_middle_row_segment)
      expect(expected[0][2]).to eq(first_bottom_row_segment)
    end
  end
