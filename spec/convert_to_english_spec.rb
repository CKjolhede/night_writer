require './lib/convert_to_braille.rb'
require './lib/string_formatting.rb'
require './lib/library.rb'

RSpec.describe ConvertToEnglish do
  before :each do
    @english = ConvertToEnglish.new
      handle = File.open("test_braille_message.txt", "r")
      #test message text is the inverse of "abc"
      @incoming_text = handle.read
      handle.close
  end
