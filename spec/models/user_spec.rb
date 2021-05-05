require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    expect(User.new).not_to be_valid
  end

  subject { described_class.new }

  it 'is valid with valid attributes' do
    subject.email = 'test@yopmail.com'
    subject.uid = '12345'
    subject.provider = 'facebook'
    subject.full_name = 'Full Name'
    expect(subject).to be_valid
  end
end
