class AddAttachmentPhotoToPosts < ActiveRecord::Migration[5.0]
  def up
    add_attachment :posts, :photo
  end

  def down
    remove_attachment :posts, :photo
  end
end
