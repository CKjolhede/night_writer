require_relative 'convert_to_braille.rb'
require_relative 'string_formatting.rb'

handle = File.open(ARGV[0], "r")
@incoming_text = handle.read
handle.close

braille = ConvertToBraille.new


writer = File.open(ARGV[1], "w")
@incoming_text.delete("\n")
converted = writer.write(braille.convert(@incoming_text))
writer.close
#long_test_message contains 61 letters. After conversion to 80 characters per line, the output file should contain 371 characters (366 braille characters and 5 "/n"'s)
puts "Created #{ARGV[1]} containing #{converted} characters"
