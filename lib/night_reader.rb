handle = File.open(ARGV[0], "r")

incoming_text = handle.read

handle.close

puts "This is the incoming text #{incoming_text}"

writer = File.open(ARGV[1], "w")
write.write(english.convert(incoming_text))
write.close

puts "Created #{ARGV[1]} containing #{incoming.text.length} characters"
