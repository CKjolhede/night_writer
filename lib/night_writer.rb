handle = File.open(ARGV[0], "r")

incoming_text = handle.read

handle.close

# braille = ConvertToBraille.new

puts "Created #{incoming_text} containing #{incoming_text.length} characters."

writer = File.open(ARGV[1], "w")
# write.write(braille.convert(incoming_text))
writer.close
#
puts "Created #{ARGV[1]} containing #{incoming_text.length} characters"
