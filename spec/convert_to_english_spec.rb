require './lib/convert_to_braille.rb'
require './lib/string_formatting.rb'
require './lib/convert_to_english.rb'


RSpec.describe ConvertToEnglish do
  before :each do

    @english = ConvertToEnglish.new
      handle = File.open("braille.txt", "r")
       #message text is the inverse of "abc the quick brown fox jumps over the lazy dog"
      @incoming_text = handle.read
      handle.close
  end

  it "exists" do
    expect(@english).to be_a(ConvertToEnglish)
  end

  it "exists" do
    expect(@english.braille).to be_a(ConvertToBraille)
  end

  it 'has an inverted @braille_reference' do
    expect(@english.english_reference[["0.", "..", ".."]]).to eq("a")
    expect(@english.english_reference[[".0", "00", ".."]]).to eq('j')
  end

  it 'can #message_split the braille.txt' do
    expected = @english.message_split(@incoming_text)

    expect(expected.length).to eq(3)
  end

  it 'can divide each split line of braille text into 2 element arrays'do
    row_array = @english.message_split(@incoming_text)
    @english.divide_braille_rows(row_array)
    expected_top = @english.top
    expected_mid = @english.mid
    expected_bot = @english.bot

    expect(expected_top[0]).to eq("0.")
    expect(expected_mid[0]).to eq("..")
    expect(expected_bot[0]).to eq("..")
  end
end

context "combining and converting braille message arrays" do
  before :each do
    @english = ConvertToEnglish.new
      handle = File.open("braille.txt", "r")
      #message text is the inverse of "abc the quick brown fox jumps over the lazy dog"
      @incoming_text = handle.read
      handle.close
    row_array = @english.message_split(@incoming_text)
    @english.divide_braille_rows(row_array)
  end

  it 'can combine corresponding indexes of 3 braille_message_arrays' do
    expected = zip_braille_arrays(@english.top, @english.mid, @english.bot)

    expect(expected.length).to eq(@english.top.length)
    expect(expected[0].length).to eq(6)
  end

end
