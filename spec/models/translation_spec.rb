require 'rails_helper'

RSpec.describe Translation, type: :model do
  it "translation is valid" do 
    translation = Translation.new(translation_value:"8000", translation_type:"Deposito",user_id:"1")
    expect(translation).to be_valid
  end

  it "translation in not valid" do 
    translation = Translation.new(translation_value:"8000", translation_type:"Deposito")
    expect(translation).to_not be_valid
  end
end
