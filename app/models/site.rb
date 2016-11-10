class Site < ApplicationRecord
  validates_presence_of :name, :address, :tel
  belongs_to :user
<<<<<<< HEAD
# <<<<<<< HEAD
=======
  has_many :pictures, :dependent => :destroy
>>>>>>> 112c40a02db855d903d066b86c21b3d22fce80bd



  def api_info
    return {
      :id => self.id,
      :name => self.name,
      :address => self.address,
      :tel => self.tel,
      :duration => self.duration,
      :hotspot => self.hotspot,
      :picture => self.pictures.map{ |p| p.image.url }
    }
  end




<<<<<<< HEAD
# =======
  has_many :pictures, :dependent => :destroy
# >>>>>>> 655b7d2d9f663983d14470eb311719fbb65faaea
=======


>>>>>>> 112c40a02db855d903d066b86c21b3d22fce80bd
end
