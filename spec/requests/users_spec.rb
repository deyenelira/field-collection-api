require 'rails_helper'

RSpec.describe 'Users', type: :request do

    before(:all) do 
        @user = User.create!(name: 'Kinho',
                     password: 'Kinho123',
                     password_confirmation: 'Kinho123',
                     email: 'kinho@gmail.com',
                     cpf: '05017437070')
    end

    describe '#index' do
        it 'when the user is authenticated' do
            authentication = AuthenticateUser.call(@user.email, @user.password)
            get '/users', headers: {"Authorization" => "Bearer #{authentication.result}"}
            expect(response).to be_successful
            expect(response).to have_http_status(200)
        end

        it 'when the user is not authenticated' do
            get '/users'
            expect(response).to have_http_status(401)
        end
    end

    describe '#create' do
        it 'when the user is created' do 
            post '/users', params: {:name => 'Teste', :password_digest => 'Teste123', :email => 'teste@gmail.com', :cpf => '31199660027'}
            expect(response).to be_successful
            expect(response).to have_http_status(201)
        end
      
        it 'when the user is not created' do 
            post '/users', params: {:name => 'Teste', :password_digest => 'Teste', :email => 'teste@gmail.com', :cpf => '31199660027'}
            expect(response).to have_http_status(422)
        end
    end

    describe '#update' do 
        it 'when the user is updated' do
            authentication = AuthenticateUser.call(@user.email, @user.password)
            put "/users/#{@user.id}", params: {:cpf => '31199660027'}, headers: {"Authorization" => "Bearer #{authentication.result}"}
            @user.reload
            expect(response).to have_http_status(200)
        end

        context 'when the user is not updated' do 
            it 'when the user is not authenticated' do 
                put "/users/#{@user.id}", params: {:cpf => '31199660027'}
                expect(response).to have_http_status(401)
            end
        end
    end

    describe '#delete' do 
        it 'when the user is deleted' do
            authentication = AuthenticateUser.call(@user.email, @user.password)
            delete "/users/#{@user.id}", headers: {"Authorization" => "Bearer #{authentication.result}"}
            expect(response).to have_http_status(204)
        end

        context 'when the user is not deleted' do 
            it 'when the user is not authenticated' do
              delete "/users/#{@user.id}"
              expect(response).to have_http_status(401)
            end
        end
    end
end