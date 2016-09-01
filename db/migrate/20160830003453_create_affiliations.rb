class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.references :project
      t.references :user
      t.boolean :administrator

      t.timestamps null: false
    end
  end
end
