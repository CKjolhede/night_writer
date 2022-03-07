require './lib/convert_to_braille.rb'
require './lib/string_formatting.rb'
require './lib/library.rb'

RSpec.describe ConvertToEnglish do
  before :each do
    @english = ConvertToEnglish.new
      handle = File.open("braille.txt", "r")
      #test message text is the inverse of "abc"
      @incoming_text = handle.read
      handle.close
      @english_reference = @braille.braille_reference.invert
  end

  it "exists" do
    expect(@english).to be_a(ConvertToEnglish)
  end

  it 'has inverted @braille_reference' do
    expect(@english_reference["0.", "..", ".."]).to eq("a")
    expect(@english_reference[".0", "00", ".."]).to eq('j')
  end

  it 'can #message_split the braille.txt' do
    expected = @english.message_split(@incoming_text)

    expect(expected.length).to eq(3)
  end
