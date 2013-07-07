class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :channel_name
      t.integer :user_id
      t.string :confirmation_code
      t.string :access_token

      t.timestamps
    end
  end
end
