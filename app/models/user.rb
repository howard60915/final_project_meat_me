class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sites
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  def api_info
    {
      :userId => self.id,
      :UserEmail => self.email,
      :userName => self.nickname,
      :biography => self.bio
    }
  end

  def generate_authentication_token
     self.authentication_token = Devise.friendly_token
  end

end
