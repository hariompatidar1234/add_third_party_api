class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :dishes

  has_one_attached :picture

  validates :name, :status, :address, presence: true
  validates :status, inclusion: { in: %w[open closed] }
  validates :name, uniqueness: true
end
