require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
	it 'when user is not authenticated' do 
		post '/authenticate', params: {:email => 'usuario', :password => '123123a'}
		expect(response).to have_http_status(401)
	end

	it 'when user is authenticated' do 
    	@user = User.create!(name: 'testando' , password: 'tesste2' , password_confirmation: 'tesste2', email: 'tesst@gmail.com', cpf: '05017437070')
		post '/authenticate', params: {:email => 'tesst@gmail.com', :password => 'tesste2'}
		expect(response).to have_http_status(200)
	end
end