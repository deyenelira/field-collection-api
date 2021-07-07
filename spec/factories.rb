FactoryBot.define do 
	factory :user do
		name {'test'}
	    password_digest {'test1234'}
	    email {'test@gmail.com'}
	    cpf {'68298515056'}
	    id {1}
	end

	factory :formulary do
		name {'forms'}
	end

	factory :question do 
		name {'question'}
		formulary_id {1}
		question_type {'text'}
	end

	factory :visit do 
		date {Date.new(2021,7,10)}
		status {'REALIZANDO'}
		checkin_at {DateTime.new(2021,7,6,8,0,0)}
		checkout_at {DateTime.new(2021,7,8,14,0,0)}
		user_id {1}
	end

end
