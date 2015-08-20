class RemoveTaskRefFromCases < ActiveRecord::Migration
  def change
    remove_reference :cases, :task, index: true
    remove_foreign_key :cases, :tasks
  end
end
