class Site < ApplicationRecord
  validates :name, presence: true ,uniqueness: true
  validates :address, presence: true
  validates :tel, presence: true

  belongs_to :user

  has_many :pictures, :dependent => :destroy

  has_many :site_plantships, :dependent => :destroy
  has_many :plants, :through => :site_plantships

  has_many :like_sites, :dependent => :destroy
  has_many :liked_by, :through => :like_sites, :source => :user




  def api_info
    return {
      :id => self.id,
      :siteName => self.name,
      :address => self.address,
      :telNumber => self.tel,
      :duration => self.duration,
      :hotSpot => self.hotspot,
      :sitePicture => self.pictures.map{ |p| "#{SITE_DOMAIN}#{p.image.url}" }
    }
  end






end
