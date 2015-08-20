class AddCaseRefToTasks < ActiveRecord::Migration
  def change
    add_reference :tasks, :case, index: true
    add_foreign_key :tasks, :cases
  end
end
