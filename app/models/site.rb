class Site < ApplicationRecord
  validates_presence_of :name, :address, :tel
  belongs_to :user
<<<<<<< HEAD



  def api_info
    return {
      :id => self.id,
      :name => self.name,
      :address => self.address,
      :tel => self.tel,
      :duration => self.duration,
      :hotspot => self.hotspot,
      :picture => self.picture.image.url
    }
  end




=======
  has_many :pictures, :dependent => :destroy
>>>>>>> 655b7d2d9f663983d14470eb311719fbb65faaea
end
