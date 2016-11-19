class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :post_plantships, :dependent => :destroy
  has_many :plants, :through => :post_plantships


  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  def api_info
    nameList = ["OhNO", "Chrisrtine", "Justin", "Jacob", "Howard"]
    avatarUrl = [
      'https://c5.staticflickr.com/6/5568/22842328868_5eedf8e61a.jpg',
      'https://c3.staticflickr.com/6/5645/22842328338_4e0ef78181.jpg',
      'https://c1.staticflickr.com/6/5451/22842327648_1321a9b888.jpg'
    ]
    return {
      :articleId => self.id.to_s,
      :articleTitle => self.title,
      :articleContent => self.content,
      :articleAuthorName => nameList.sample,
      :articleAuthorImage => avatarUrl,
      :articleImage => "#{SITE_DOMAIN}#{self.photo.url}",
      :articleDate => self.created_at.strftime("%Y.%m.%d"),
      :articleLoveNumber => (10..30).to_a.sample,
      :articleCommentNumber => self.comments.count
    }
  end


end
