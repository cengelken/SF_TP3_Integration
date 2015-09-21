class AddTp3IdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :tp3_id, :string
  end
end
