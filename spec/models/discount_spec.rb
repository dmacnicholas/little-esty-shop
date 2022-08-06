require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'validations' do
    it { should validate_numericality_of(:percent).is_greater_than(0).is_less_than_or_equal_to(100)}
    it { should validate_presence_of :threshold }
  end

  describe 'relationships' do
    it { should belong_to(:merchant) }
  end
end
