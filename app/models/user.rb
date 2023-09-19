class User < ApplicationRecord
  validates :type, inclusion: { in: %w[Owner Customer] }
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Invalid email id!!!!' }
  before_save :remove_space

  def remove_space
    self.name = name.strip
    self.email = email.strip
  end

  def generate_password_token!
    update(reset_password_token: generate_token, reset_password_sent_at: Time.now.utc)
  end

  def password_token_valid?
    (reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    return update(reset_password_token: nil) if update(password: password)

    false
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
