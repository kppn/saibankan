class CreateNumbers < ActiveRecord::Migration
  def change
    create_table :numbers do |t|
      t.references :project

      t.string :val

      t.timestamps null: false
    end
  end
end
