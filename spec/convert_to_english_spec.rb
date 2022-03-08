require './lib/convert_to_braille.rb'
require './lib/string_formatting.rb'
require './lib/library.rb'


RSpec.describe ConvertToEnglish do
  before :each do

    @english = ConvertToEnglish.new
      handle = File.open("braille.txt", "r")
       #message text is the inverse of "abc"
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
end
