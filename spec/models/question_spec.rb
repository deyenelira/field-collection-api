require 'rails_helper'

RSpec.describe Question, :type => :model do  	
	
	form = FactoryBot.create(:formulary)
	
	subject {
		described_class.new(name: "question", formulary_id: "#{form.id}", question_type: "text")
	}

	it 'is valid with valid attributes' do
		expect(subject).to be_valid
	end

	it 'is invalid with nil attributes' do
		subject.name = nil
		expect(subject).to_not be_valid
	end

	it 'is invalid without a unique name' do 
		question1 = FactoryBot.create(:question)
		question1.save
		question2 = FactoryBot.build(:question)
		expect(question2).to_not be_valid
	end

end
