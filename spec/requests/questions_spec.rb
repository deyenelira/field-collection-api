require 'rails_helper'

RSpec.describe 'Questions', type: :request do
	before(:all) do
	    @user = User.create!(name: 'Daniela',
			    			 password: 'daniela123',
			    			 password_confirmation: 'daniela123',
			    			 email: 'dani@gmail.com',
			    			 cpf: '84262459004')

	    @formulary = Formulary.create!(name: 'formulary')

	    @question = Question.create!(name: 'question',
  									 formulary_id: "#{@formulary.id}",
  									 question_type: 'type')
  	end

  	describe '#index' do
	    it 'when the user is authenticated' do
	        authentication = AuthenticateUser.call(@user.email, @user.password)
	        get '/questions', headers: {"Authorization" => "Bearer #{authentication.result}"}
	        expect(response).to be_successful
	        expect(response).to have_http_status(200)
	    end

	    it 'when the user is not authenticated' do
	        get '/questions'
	        expect(response).to have_http_status(401)
	    end
    end

	describe '#create' do
		it 'when the question is created' do
		  	authentication = AuthenticateUser.call(@user.email, @user.password)
		  	post '/questions', params: {:name => 'question1', :formulary_id => "#{@formulary.id}", :question_type => 'type'}, headers: {"Authorization" => "Bearer #{authentication.result}"}
		  	expect(response).to be_successful
		  	expect(response).to have_http_status(201)
		end

		it 'when the user is not authenticated' do
		  	post '/questions', params: {:name => 'question1', :formulary_id => "#{@formulary.id}", :question_type => 'type'}
		  	expect(response).to have_http_status(401)
		end
	end

	describe '#update' do 
		it 'when the question is updated' do
		    authentication = AuthenticateUser.call(@user.email, @user.password)
		    put "/questions/#{@question.id}", params: {:name => 'question2', :formulary_id => "#{@formulary.id}", :question_type => 'type'}, headers: {"Authorization" => "Bearer #{authentication.result}"}
		    @question.reload
		    expect(response).to have_http_status(200)
		end

		context 'when the user is not updated' do 
		    it 'when the user is not authenticated' do 
		  	    put "/questions/#{@question.id}", params: {:name => 'question2', :formulary_id => "#{@formulary.id}", :question_type => 'type'}
		  	    expect(response).to have_http_status(401)
		    end
		end
	end

	describe '#delete' do 

		it 'when the user is deleted' do
		    authentication = AuthenticateUser.call(@user.email, @user.password)
		    delete "/questions/#{@question.id}", headers: {"Authorization" => "Bearer #{authentication.result}"}
		    expect(response).to have_http_status(204)
		end

		context 'when the user is not deleted' do 
		  
		    it 'when the user is not authenticated' do
		  		delete "/questions/#{@question.id}"
		    	expect(response).to have_http_status(401)
		    end
		end
	end
end