require 'rails_helper'

RSpec.describe User, type: :model do
  it 'é válido com email e senha' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'não é válido sem email' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'não é válido com senha muito curta' do
    user = FactoryBot.build(:user, password: 'short')
    expect(user).not_to be_valid
  end
end