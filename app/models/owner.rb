class Owner < User
    has_many :restaurants , dependent: :destroy
end
