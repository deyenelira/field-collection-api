require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
	it 'when user is not authenticated' do 
		post '/authenticate', params: {:email => 'usuario', :password => '123123a'}
		expect(response).to have_http_status(401)
	end

	it 'when user is authenticated' do 
		@user = User.create!(name: 'Kinho', password: 'Kinho123', password_confirmation: 'Kinho123', email: 'kinho@gmail.com', cpf: '05017437070')
		post '/authenticate', params: {:email => 'kinho@gmail.com', :password => 'Kinho123'}
		expect(response).to have_http_status(200)
	end
end