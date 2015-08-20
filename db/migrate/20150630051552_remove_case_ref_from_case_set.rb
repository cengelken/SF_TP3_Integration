class RemoveCaseRefFromCaseSet < ActiveRecord::Migration
  def change
    remove_reference :case_sets, :case, index: true
    remove_foreign_key :case_sets, :cases
  end
end
