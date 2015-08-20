class AddCaseSetRefToCase < ActiveRecord::Migration
  def change
    add_reference :cases, :case_set, index: true
    add_foreign_key :cases, :case_sets
  end
end
