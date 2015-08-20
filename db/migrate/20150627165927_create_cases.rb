class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :case_num
      t.timestamps null: false
    end
  end
end
