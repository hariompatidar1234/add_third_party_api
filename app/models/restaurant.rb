class Restaurant < ApplicationRecord
  belongs_to :owner , foreign_key: 'user_id'
  has_many :dishes ,  dependent: :destroy

  has_one_attached :picture

  validates :name, :status, :address, presence: true
  validates :status, inclusion: { in: %w[open closed] }
  validates :name, uniqueness: true
end
