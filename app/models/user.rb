class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # Relationships
  # belongs_to :team

  # Callbacks
  before_save { email.downcase! }

  has_secure_password

  # Validation
  validates :first, presence: true, length: { maximum: 50 }
  validates :last, presence: true, length: { maximum: 50 }
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates_length_of :password, minimum: 7, too_short: 'Please enter at least 7 characters.'

  # Virtual property
  def name
    @name ||= "#{first} #{last}"
  end
end
