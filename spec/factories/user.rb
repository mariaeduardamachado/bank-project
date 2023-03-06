FactoryBot.define do 
	factory :user do
		name {"Maria Eduarda Machado Alves"}
		email {"mariaeduarda.0450@gmail.com.br"}
		phone {"62984923784"}
		cpf {"70853780188"}
		rg {"405045153"}
		road {"3"}
		neighborhood {"Setor Residencial Leste (Planaltina)"}
		number {"905"}
		complement {"Quadra Quadra 19 Conjunto E"}
		active {"true"}
		cep {"73357-025"}
		income {"4000"}
		patrimony {"19000"}
		agency {"5443"}
		account {"02215357"}
		avatar {Rack::Test::UploadedFile.new(Rails.root.join("spec","support", "IMG_6829.jpeg"),"image/png")}
		password {"123456"}
	end
end
