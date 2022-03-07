require './lib/convert_to_braille.rb'
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
    end

    it 'can change each @characters into their braille equivalent' do
      expected = letter_to_braille(@characters)
      expect(expected).to eq(["0.", "..", ".."], ["0.", "0.", ".."], ["00", "..", ".."])
    end
  end
