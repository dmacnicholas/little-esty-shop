class Discount < ApplicationRecord
  validates :percent, presence: true,
    :numericality => { :greater_than => 0, :less_than_or_equal_to => 100 }
  validates_presence_of :threshold

  belongs_to :merchant

end
