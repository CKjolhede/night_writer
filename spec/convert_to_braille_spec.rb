require './lib/convert_to_braille.rb'


RSpec.describe ConvertToBraille do
  before :each do
    @braille = ConvertToBraille.new
  end

  it "exists" do
    expect(@braille).to be_a(ConvertToBraille)
  end
end
