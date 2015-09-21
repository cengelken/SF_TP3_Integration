class AddTp3IdToCases < ActiveRecord::Migration
  def change
    add_column :cases, :tp3_id, :string
  end
end
