class AddCaseRefToCaseSets < ActiveRecord::Migration
  def change
    add_reference :case_sets, :case, index: true
    add_foreign_key :case_sets, :cases
  end
end
