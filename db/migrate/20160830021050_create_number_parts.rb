class CreateNumberParts < ActiveRecord::Migration
  def change
    create_table :number_parts do |t|
      t.string :type
      t.string :format
      t.references :number_format
      t.integer :current

      t.timestamps null: false
    end
  end
end
