class CreateMarkings < ActiveRecord::Migration
  def change
    create_table :markings do |t|
      t.references :number

      t.timestamps null: false
    end
  end
end
