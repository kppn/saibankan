class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.integer :owner_id
      t.string  :owner_type

      t.string :label
      t.string :description

      t.timestamps null: false
    end
  end
end
