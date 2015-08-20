class RemoveCaseRefFromCases < ActiveRecord::Migration
  def change
    remove_reference :cases, :case, index: true
    remove_foreign_key :cases, :cases
  end
end
