require 'rails_helper'

RSpec.describe Formulary, :type => :model do  	
	
	subject {
		described_class.new(name: "form")
	}

	it 'is valid with valid attributes' do
		expect(subject).to be_valid
	end

	it 'is invalid with nil attributes' do
		subject.name = nil
		expect(subject).to_not be_valid
	end

	it 'is invalid without a unique name' do 
		form1 = FactoryBot.create(:formulary)
		form1.save
		form2 = FactoryBot.build(:formulary)
		expect(form2).to_not be_valid
	end
	
end