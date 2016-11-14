class CreatePostPlantships < ActiveRecord::Migration[5.0]
  def change
    create_table :post_plantships do |t|
      t.integer :post_id
      t.integer :plant_id
      t.timestamps
    end
    add_index :post_plantships, :post_id
    add_index :post_plantships, :plant_id
  end
end
