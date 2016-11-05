class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sites

  def api_info
    return {
      :id => self.id,
      :email => self.email,
      :nickname => self.nickname,
      :bio => self.bio,
      :admin => self.admin
    }
  end

  def generate_authentication_token
     self.authentication_token = Devise.friendly_token
  end

end
