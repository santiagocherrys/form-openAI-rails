class Form < ApplicationRecord
  #validations
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :processed_in_job, inclusion: { in: [true, false], message: 'must be true or false' }

  #relation for bring response
  has_one :response
end
