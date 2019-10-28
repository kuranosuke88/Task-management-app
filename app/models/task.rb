class Task < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :detail, presence: true, length: { in: 5..300 }
end
