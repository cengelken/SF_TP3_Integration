class CreateCaseSets < ActiveRecord::Migration
  def change
    create_table :case_sets do |t|
      t.timestamps null: false
    end
  end
end
