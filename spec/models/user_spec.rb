require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}

  it 'should validate email uniqueness' do
    user_valid = create(:user, email: 'example_email@domain.com')
    user_invalid = build(:user, email: 'example_email@domain.com')
    expect { user_invalid.save! }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end
end
