require 'rails_helper'

RSpec.describe Answer, :type => :model do  	
  	
  	user = FactoryBot.create(:user)
	form = FactoryBot.create(:formulary)
	question = FactoryBot.create(:question)
	visit = FactoryBot.create(:visit)

  	subject {
	    described_class.new(content: "content",
	    					formulary_id: "#{form.id}",
	    					question_id: "#{question.id}",
	    					visit_id: "#{visit.id}",
	    					answered_at: DateTime.new(2021,7,8,14,0,0))
  	}

  	it 'is valid with valid attributes' do
    	expect(subject).to be_valid
  	end

  	it 'is invalid without a valid formulary_id' do 
    	subject.formulary_id = 12
    	expect(subject).to_not be_valid
  	end

  	it 'is invalid without a valid question_id' do 
    	subject.question_id = 13
    	expect(subject).to_not be_valid
  	end
  	
end
