class Comment < ApplicationRecord

  validates_presence_of :content

  belongs_to :user
  belongs_to :post

  def api_info
    nameList = ["OhNO", "Chrisrtine", "Justin", "Jacob", "Howard"]
    {
      :articleCommentId => self.id,
      :articleCommentContent => self.content,
      :articleCommentAuthor => nameList.sample,
      :articleCommentCreatedAt => self.created_at
    }
  end
end
