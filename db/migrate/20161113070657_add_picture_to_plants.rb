class AddPictureToPlants < ActiveRecord::Migration[5.0]
  def up
    add_attachment :plants, :picture
  end

  def down
    remove_attachment :plants, :picture
  end
end
