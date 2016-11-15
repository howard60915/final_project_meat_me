class CreateLikeSites < ActiveRecord::Migration[5.0]
  def change
    create_table :like_sites do |t|
      t.integer :user_id
      t.integer :site_id

      t.timestamps
    end
  end
end
