class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # for Google OmniAuth
         :omniauthable, omniauth_providers: [:google_oauth2]
  validates :type, inclusion: { in: %w[Owner Customer] }
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Invalid email id!!!!' }

  # validates :contact,
  #     presence: true,
  #     uniqueness: true,format: { with: /\d[0-9]\)*\z/ }
  has_one_attached :picture

  # def self.ransackable_attributes(auth_object = nil)
  #   ["created_at", "email", "encrypted_password", "id", "name", "password", "remember_created_at", "reset_password_sent_at", "reset_password_token", "type", "updated_at"]
  # end

  # def self.ransackable_associations(auth_object = nil)
  #   ["picture_attachment", "picture_blob"]
  # end


  def self.from_omniauth(auth)
    byebug
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
      # Set default account type to 'customer'
      user.type ||= 'Customer'
      unless user.save
        puts "Error saving user: #{user.errors.full_messages.join(', ')}"
      end
    end
  end

end
