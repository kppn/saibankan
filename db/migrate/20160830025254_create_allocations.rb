class CreateAllocations < ActiveRecord::Migration
  def change
    create_table :allocations do |t|
      t.references :user
      t.references :number

      t.timestamps null: false
    end
  end
end
