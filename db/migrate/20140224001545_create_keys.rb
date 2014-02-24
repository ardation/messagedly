class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :key
      t.integer :user_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
