class Plant < ApplicationRecord

  has_many :post_plantships, :dependent => :destroy
  has_many :posts, :through => :post_plantships

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/


  def api_info
    return {
      :plantId => self.id,
      :plantName => self.name,
      :plantDescription => self.description,
      :plantPicture => "#{SITE_DOMAIN}#{self.picture.url}"
    }
  end

  def self.fakesample(number)
    Plant.find( (number..(number + 2 )).to_a.sample)
  end

end
