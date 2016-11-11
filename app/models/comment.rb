class Comment < ApplicationRecord

  validates_presence_of :content

  belongs_to :user
  belongs_to :post

  def api_info
    {
      :commentId => self.id,
      :commentContent => self.content,
      :commentAuthor => self.user.nickname,
      :commentCreatedAt => self.created_at
    }
  end
end
