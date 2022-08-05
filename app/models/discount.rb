class Discount < ApplicatonRecord
  validates_presence_of :percent
  validates_presence_of :threshold

  belongs_to :merchant

end
