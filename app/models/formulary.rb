class Formulary < ApplicationRecord
	
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  validates :name, presence: true, uniqueness: true

end
