require 'rails_helper'

RSpec.describe 'User Registration', type: :request do
  it 'permite que um usuário se registre' do
    user_attributes = FactoryBot.attributes_for(:user)  # Dados para criar um novo usuário

    post user_registration_path, params: { user: user_attributes }  # Envia a solicitação de registro

    expect(User.exists?(email: user_attributes[:email])).to be_truthy  # Verifica se o usuário foi criado
    expect(response).to redirect_to(root_path)  # Ou outra rota após registro
  end
end

RSpec.describe 'User Login', type: :request do
  before(:each) do
    @user = FactoryBot.create(:user)  # Cria um usuário para teste de login
  end

  it 'permite que um usuário faça login' do
    post user_session_path, params: { user: { email: @user.email, password: 'password' } }  # Solicitação de login

    expect(response).to redirect_to(root_path)  # Verifica se o login foi bem-sucedido
    follow_redirect!
    expect(controller.current_user).to eq(@user)  # Verifica se o usuário está logado
  end
end