class CreateSitePlantships < ActiveRecord::Migration[5.0]
  def change
    create_table :site_plantships do |t|
      t.integer :plant_id
      t.integer :site_id

      t.timestamps
    end
  end
end
