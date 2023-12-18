class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # for Google OmniAuth
         :omniauthable, omniauth_providers: [:google_oauth2,:facebook, :twitter,:github]
  validates :type, inclusion: { in: %w[Owner Customer] }
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Invalid email id!!!!' }

  validates :phone_number,
      presence: true,
      uniqueness: true,format: { with: /\d[0-9]\)*\z/ }
  has_one_attached :picture

  # def self.ransackable_attributes(auth_object = nil)
  #   ["created_at", "email", "encrypted_password", "id", "name", "password", "remember_created_at", "reset_password_sent_at", "reset_password_token", "type", "updated_at"]
  # end

  # def self.ransackable_associations(auth_object = nil)
  #   ["picture_attachment", "picture_blob"]
  # end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.avatar_url = auth.info.image
      user.type ||= 'Customer'
      # user.contact = auth.info.contact
      unless user.save
        puts "Error saving user: #{user.errors.full_messages.join(', ')}"
      end
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && self.provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def has_no_password?
    self.encrypted_password.blank?
  end

end
