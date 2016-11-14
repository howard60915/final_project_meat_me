class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :post_plantships, :dependent => :destroy
  has_many :plants, :through => :post_plantships


  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  def api_info
    return {
      :articleId => self.id.to_s,
      :articletitle => self.title,
      :articlecontent => self.content,
      :articleAuthor => self.user,
      :articleImage => self.photo.url,
      :articleDate => self.created_at
    }
  end


end
