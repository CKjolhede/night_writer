require_relative 'convert_to_braille.rb'
require_relative 'string_formatting.rb'

handle = File.open(ARGV[0], "r")
@incoming_text = handle.read
handle.close

braille = ConvertToBraille.new


writer = File.open(ARGV[1], "w")
@incoming_text.delete("\n")
writer.write(braille.convert(@incoming_text))
writer.close
#
puts "Created #{ARGV[1]} containing #{@incoming_text.length} characters"
# puts "Created #{incoming_text} containing #{incoming_text.length} characters."
