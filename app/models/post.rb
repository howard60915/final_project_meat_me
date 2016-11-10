class Post < ApplicationRecord

  belongs_to :user


  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  def api_info
    return {
      :id => self.id,
      :title => self.title,
      :content => self.content,
      :poster => self.user,
      :photo => self.photo.url
    }
  end


end
