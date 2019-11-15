class Task < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :detail, presence: true, length: { in: 5..300 }
end
