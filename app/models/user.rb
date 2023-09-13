class User < ApplicationRecord
  has_many :restaurants , dependent: :destroy
  has_one :cart ,  dependent: :destroy
  has_many :orders ,  dependent: :destroy

  after_create :create_cart
  validates :type, inclusion: { in: %w[Owner Customer] }
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Invalid email id!!!!' }
  before_save :remove_space

  def remove_space
    self.name = name.strip
    self.email = email.strip
  end

  def self.create_cart
    cart.create
  end
end
