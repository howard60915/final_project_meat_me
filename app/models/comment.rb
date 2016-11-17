class Comment < ApplicationRecord

  validates_presence_of :content

  belongs_to :user
  belongs_to :post

  def api_info
    nameList = ["OhNO", "Chrisrtine", "Justin", "Jacob", "Howard"]
    {
      :commentId => self.id,
      :commentContent => self.content,
      :commentAuthor => nameList.sample,
      :commentCreatedAt => self.created_at
    }
  end
end
