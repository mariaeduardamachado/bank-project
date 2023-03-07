require 'rails_helper'

RSpec.describe User, type: :model do 
  it "user is valid" do 
    user = User.new(name:"Teste First", email:"teste@teste.com", password:"123456789", phone: "62984923784", 
                    cpf:"74802593015", rg:"420641312", road:"Rua São Jorge", neighborhood: "Vila Merlo",
                    cep:"29156401", number:"726", income:"6000", patrimony:"7000", complement:"qd-04 lt-15",
                    avatar: fixture_file_upload(Rails.root.join("spec","support", "IMG_6829.jpeg"),"image/png"))
  
    expect(user).to be_valid
  end

  it "user is not valid" do 
    user = User.new(email:"teste@teste.com", password:"123456789", phone: "62984923784", 
    cpf:"74802593015", rg:"420641312", road:"Rua São Jorge", neighborhood: "Vila Merlo",
    cep:"29156401", number:"726", income:"6000", patrimony:"7000", complement:"qd-04 lt-15",
    avatar: fixture_file_upload(Rails.root.join("spec","support", "IMG_6829.jpeg"),"image/png"))

    expect(user).to_not be_valid
  end

end
