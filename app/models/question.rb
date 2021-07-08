class Question < ApplicationRecord
    
  belongs_to :formulary
  has_one :answer, dependent: :destroy
  has_one_attached :image
  validates :name, presence: true, uniqueness: {scope: :formulary_id}

end
