class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  enum admin: { general: 0, admin: 1}

  attr_accessor :remember_token
  before_save   :downcase_email
  before_destroy :last_admin_do_not_delete

  has_secure_password validations: false
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  
  scope :admin_users, -> { where(admin: 'admin') }

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  def admin_user?
    self.admin == 'admin'
  end  

  def last_admin_user?
    self.admin_user? && User.admin_users.count == 1
  end  

  private

    def downcase_email
      email.downcase!
    end

    def last_admin_do_not_delete
      if last_admin_user?
        errors.add :base, '最後の管理者のため削除できません。他のユーザーにadminを付与して下さい。'
        throw :abort
      end
    end
end
