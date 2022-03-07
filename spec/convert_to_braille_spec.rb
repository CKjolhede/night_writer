require './lib/convert_to_braille.rb'


RSpec.describe ConvertToBraille do
  before :each do
    @braille = ConvertToBraille.new
  end

  it "exists" do
    expect(@braille).to be_a(ConvertToBraille)
  end

  it 'can return the braille refernce set' do
    expect(@braille.braille_reference['a']).to eq(["0.", "..", ".."])
    expect(@braille.braille_reference['z']).to eq(["0.", ".0", "00"])
  end

end
