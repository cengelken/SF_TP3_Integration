class AddTaskRefToCases < ActiveRecord::Migration
  def change
    add_reference :cases, :task, index: true
    add_foreign_key :cases, :tasks
  end
end
