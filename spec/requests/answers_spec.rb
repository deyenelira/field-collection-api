require 'rails_helper'

RSpec.describe 'Formularies', type: :request do

	before(:all) do
		@user = User.create!(name: 'Zequinha',
			    			 password: 'zeca123',
			    			 password_confirmation: 'zeca123',
			    			 email: 'zeca@gmail.com',
			    			 cpf: '99978355065') 

	    @visit = Visit.create!(:date => Date.new(2021,7,10),
	    					   :status => "REALIZANDO",
	    					   :checkin_at => DateTime.new(2021,7,6,8,0,0),
	    					   :checkout_at => DateTime.new(2021,7,8,14,0,0),
	    					   :user_id => "#{@user.id}")

	    @formulary = Formulary.create!(name: 'formulario')

  		@question = Question.create!(name: 'question',
  									 formulary_id: "#{@formulary.id}",
  									 question_type: 'type')

  		@answer = Answer.create!(content: 'content',
  								 formulary_id: "#{@formulary.id}",
  								 question_id: "#{@question.id}",
  								 visit_id: "#{@visit.id}",
  								 answered_at:DateTime.new(2021,7,8,14,0,0))
  	end

  	describe '#index' do
	    it 'when the user is authenticated' do
	      authentication = AuthenticateUser.call(@user.email, @user.password)
	      get '/answers', headers: {"Authorization" => "Bearer #{authentication.result}"}
	      expect(response).to be_successful
	      expect(response).to have_http_status(200)
	    end

	    it 'when the user is not authenticated' do
	      get '/answers'
	      expect(response).to have_http_status(401)
	    end
  	end

	describe '#create' do
		it 'when the answer is created' do
		  	authentication = AuthenticateUser.call(@user.email, @user.password)
		  	post '/answers', params: {:content => 'content', :formulary_id => "#{@formulary.id}", :question_id => "#{@question.id}", :visit_id => "#{@visit.id}", :answered_at => DateTime.new(2021,7,8,14,0,0)}, headers: {"Authorization" => "Bearer #{authentication.result}"}
		  	expect(response).to be_successful
		  	expect(response).to have_http_status(201)
		end

		it 'when the user is not authenticated' do
		  	post '/answers', params: {:content => 'content', :formulary_id => "#{@formulary.id}", :question_id => "#{@question.id}", :visit_id => "#{@visit.id}", :answered_at => DateTime.new(2021,7,8,14,0,0)}
		  	expect(response).to have_http_status(401)
		end
	end

	describe '#update' do 

		it 'when the answer is updated' do
			authentication = AuthenticateUser.call(@user.email, @user.password)
			put "/answers/#{@answer.id}", params: {:content => 'content2'}, headers: {"Authorization" => "Bearer #{authentication.result}"}
			@answer.reload
			expect(response).to have_http_status(200)
		end

		context 'when the user is not updated' do 
			it 'when the user is not authenticated' do 
			  	put "/answers/#{@answer.id}", params: {:content => 'content2'}
			  	expect(response).to have_http_status(401)
			end
		end
	end

	describe '#delete' do 

		it 'when the answer is deleted' do
		    authentication = AuthenticateUser.call(@user.email, @user.password)
		    delete "/answers/#{@answer.id}", headers: {"Authorization" => "Bearer #{authentication.result}"}
		    expect(response).to have_http_status(204)
		end

		context 'when the user is not deleted' do 
		  
			it 'when the user is not authenticated' do
			  	delete "/answers/#{@answer.id}"
			    expect(response).to have_http_status(401)
			end
		end
	end
end	
