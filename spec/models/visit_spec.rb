require 'rails_helper'

RSpec.describe Visit, :type => :model do  	
  	
  	user = FactoryBot.create(:user)
  	
  	subject {
	    described_class.new(date: Date.new(2021,7,10),
	    					status: "REALIZANDO",
	                        checkin_at: DateTime.new(2021,7,6,8,0,0),
	                        checkout_at: DateTime.new(2021,7,8,14,0,0),
	                        user_id: "1")
  	}
  	it 'is valid with valid attributes' do
    	expect(subject).to be_valid
  	end

  	it 'is invalid with invalid date' do 
  		subject.date = Date.new(2010,7,10)
  		expect(subject).to_not be_valid
  	end

  	it 'iis invalid with invalid checkin and checkout' do 
  		subject.checkout_at = DateTime.new(2021,7,6,8,0,0)
  		subject.checkin_at = DateTime.new(2021,7,8,14,0,0)
  		expect(subject).to_not be_valid
  	end

  	it 'is invalid with invalid status' do 
  		subject.status = "status invalido"
  		expect(subject).to_not be_valid
  	end

  	it 'is invalid with invalid user_id' do 
  		subject.user_id = 12
  		expect(subject).to_not be_valid
  	end

end