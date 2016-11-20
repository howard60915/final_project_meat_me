class Comment < ApplicationRecord

  validates_presence_of :content

  belongs_to :user
  belongs_to :post

  def api_info
    avatarUrl = [
      'https://c5.staticflickr.com/6/5568/22842328868_5eedf8e61a.jpg',
      'https://c3.staticflickr.com/6/5645/22842328338_4e0ef78181.jpg',
      'https://c1.staticflickr.com/6/5451/22842327648_1321a9b888.jpg'
    ]
    nameList = ["OhNO", "Christine", "Justin", "Jacob", "Howard"]
    {
      :articleCommentId => self.id,
      :articleCommentContent => self.content,
      :articleCommentAuthor => nameList.sample,
      :articleCommentAuthorImage => avatarUrl.sample,
      :articleCommentDate => self.created_at.strftime("%Y.%m.%d")
    }
  end
end
