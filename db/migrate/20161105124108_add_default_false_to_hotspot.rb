class AddDefaultFalseToHotspot < ActiveRecord::Migration[5.0]
  def change
    remove_column :sites, :hotspot
    add_column :sites, :hotspot, :boolean, :default => false
  end
end
