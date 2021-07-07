FactoryBot.define do 
	factory :user do
		name {'test'}
	    password_digest {'test1234'}
	    email {'test@gmail.com'}
	    cpf {'68298515056'}
	end
end