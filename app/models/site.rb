class Site < ApplicationRecord
  validates_presence_of :name, :address, :tel
  belongs_to :user

  has_many :pictures, :dependent => :destroy




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






end
