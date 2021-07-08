require 'rails_helper'

RSpec.describe 'Formularies', type: :request do
	before(:all) do
		@user = User.create!(name: 'dayane',
			password: 'dayane123',
			password_confirmation: 'dayane123',
			email: 'dayane@gmail.com',
			cpf: '28327733036')
		@formulary = Formulary.create!(name: 'formulario')
	end

	describe '#index' do
		it 'when the user is authenticated' do
			authentication = AuthenticateUser.call(@user.email, @user.password)
			get '/formularies', headers: {"Authorization" => "Bearer #{authentication.result}"}
			expect(response).to be_successful
			expect(response).to have_http_status(200)
		end

		it 'when the user is not authenticated' do
			get '/formularies'
			expect(response).to have_http_status(401)
		end
	end

	describe '#create' do
		it 'when the formulary is created' do
			authentication = AuthenticateUser.call(@user.email, @user.password)
			post '/formularies', params: {:name => 'meu_form'}, headers: {"Authorization" => "Bearer #{authentication.result}"}
			expect(response).to be_successful
			expect(response).to have_http_status(201)
		end

		it 'when the user is not authenticated' do
			post '/formularies', params: {:name => 'meu_form'}
			expect(response).to have_http_status(401)
		end
	end

	describe '#update' do 
		it 'when the formulary is updated' do
			authentication = AuthenticateUser.call(@user.email, @user.password)
			put "/formularies/#{@formulary.id}", params: {:name => 'meu_form2'}, headers: {"Authorization" => "Bearer #{authentication.result}"}
			@formulary.reload
			expect(response).to have_http_status(200)
		end

		context 'when the formulary is not updated' do 
			it 'when the user is not authenticated' do 
				put "/formularies/#{@formulary.id}", params: {:name => 'meu_form2'}
				expect(response).to have_http_status(401)
			end
		end
	end

	describe '#delete' do 

		it 'when the user is deleted' do
			authentication = AuthenticateUser.call(@user.email, @user.password)
			delete "/formularies/#{@formulary.id}", headers: {"Authorization" => "Bearer #{authentication.result}"}
			expect(response).to have_http_status(204)
		end

		context 'when the user is not deleted' do 

			it 'when the user is not authenticated' do
				delete "/formularies/#{@formulary.id}"
				expect(response).to have_http_status(401)
			end
		end
	end
end
