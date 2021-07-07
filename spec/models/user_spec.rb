require 'rails_helper'

RSpec.describe User, :type => :model do  	
  	subject {
	    described_class.new(name: "Elias",
	                        password_digest: "elias123",
	                        email: "elias@gmail.com",
	                        cpf: "61779398050")
  	}

  	it 'is valid with valid attributes' do
    	expect(subject).to be_valid
  	end

  	it 'is invalid with invalid password' do 
  		subject.password_digest = 'eliaslol'
  		expect(subject).to_not be_valid
  	end

  	it 'is invalid with invalid password' do 
  		subject.password_digest = 'elias'
  		expect(subject).to_not be_valid
  	end

  	it 'is invalid with invalid password' do 
  		subject.password_digest = '123456'
  		expect(subject).to_not be_valid
  	end

  	it 'is invalid without a valid cpf' do 
	    subject.cpf = "12312312354"
	    expect(subject).to_not be_valid
  	end

  	it 'is invalid without an unique email/cpf' do 
  		user1 = FactoryBot.create(:user)
    	user1.save
    	user2 = FactoryBot.build(:user)
    	expect(user2).to_not be_valid
  	end


end