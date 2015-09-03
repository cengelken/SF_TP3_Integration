class AddUrlAndDescriptionToCases < ActiveRecord::Migration
  def change
    add_column :cases, :url, :string
    add_column :cases, :description, :string
  end
end
