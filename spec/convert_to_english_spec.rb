require './lib/convert_to_braille.rb'
require './lib/string_formatting.rb'
require './lib/convert_to_english.rb'


RSpec.describe ConvertToEnglish do
  before :each do
    @english = ConvertToEnglish.new
      handle = File.open("test_message_in_braille.txt", "r")
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

  it 'can divide each split line of braille text into 2 element arrays'do
    @english.message_split(@incoming_text)
    @english.divide_braille_rows(@english.braille_message_split)
    expected = @english.separated_braille_rows

    expect(expected[0]).to eq(["0.","0.","00"])
    expect(expected[1]).to eq(["..","0.",".."])
    expect(expected[2]).to eq(["..","..",".."])
  end
end

context "combining and converting braille message arrays" do
  before :each do
    @english = ConvertToEnglish.new
      handle = File.open("braille.txt", "r")
      #message text is the inverse of "abc the quick brown fox jumps over the lazy dog"
      @incoming_text = handle.read
      handle.close
    @english.message_split(@incoming_text)
    # require "pry"; binding.pry
    @english.divide_braille_rows(@english.braille_message_split)
  end

  it 'can combine corresponding indexes of 3 braille_message_arrays' do
    # require "pry"; binding.pry
    expected = @english.zip_braille_arrays
    expect(expected.length * @english.braille_message_row_count).to eq(@english.braille_message_length)
    expect(expected[0].length).to eq(@english.braille_message_row_count)
  end

  it 'can translate braille characters into english letters' do
    @english.divide_braille_rows(@braille_message_split)
    @english.zip_braille_arrays
    expected = @english.braille_to_english(@english.zipped)

    expect(expected).to eq(['a','b','c','t','h','e','q','u','i','c','k','b','r','o','w','n','f','o','x','j','u','m','p','s','o','v','e','r','t','h','e','l','a','z','y','d','o','g'])
  end

  it 'can join array of characters' do
    @english.divide_braille_rows(@braille_message_split)
    @english.zip_braille_arrays(@english.top, @english.mid, @english.bot)
    @english.braille_to_english(@english.zipped)
    expected = @english.combine_characters(@english.zipped)
    expect(expected).to eq("abcthequickbrownfoxjumpsoverthelazydog")
  end
end

context "Convert helper method" do
  before :each do
    @english = ConvertToEnglish.new
    handle = File.open("long_test_braille_message.txt", "r")
    handle_short = File.open("test_message_in_braille.txt", "r")
    #long test message text:  xxxxx..(80 total)..xxxxx/n aaaa...(80 total)...aaa/n xxxx>>>(890 total)...xxxx
    @incoming_text = handle.read
    @short_text = handle_short.read
    handle.close
    handle_short.close
  end

  it "can convert a short text string into braille" do
    expected = @english.convert(@short_text)

    expect(expected).to eq("abc")
  end

  it "can convert > 80 characters into formated braille file" do
    #@incoming_text file contains 371 characters. The resulting english.txt file should contain 371 - 5 for the "\n" =366/(6 braille characters to one english) resulting in 61 total english characters
    expected = @english.convert(@incoming_text)

    expect(expected).to eq("abcdefghijklmnopqrstuvwxyzisthistheendofthelinethisistheextra")
  end
end
