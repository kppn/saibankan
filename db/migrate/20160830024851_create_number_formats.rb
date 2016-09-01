class CreateNumberFormats < ActiveRecord::Migration
  def change
    create_table :number_formats do |t|
      t.references :project

      t.timestamps null: false
    end
  end
end
