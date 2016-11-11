class Site < ApplicationRecord
  validates_presence_of :name, :address, :tel
  belongs_to :user

  has_many :pictures, :dependent => :destroy




  def api_info
    return {
      :id => self.id,
      :siteName => self.name,
      :address => self.address,
      :telNumber => self.tel,
      :duration => self.duration,
      :hotSpot => self.hotspot,
      :sitePicture => self.pictures.map{ |p| p.image.url }
    }
  end






end
