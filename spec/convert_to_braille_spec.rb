require './lib/convert_to_braille'


RSpec.describe ConvertToBraille do
  before :each do
    @braille = ConvertToBraile.new
  end

  it "exists" do
    expect(@braille).to be_a(ConvertToBraille)
  end
end
