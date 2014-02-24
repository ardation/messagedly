class ChangeTokenDescriptionToText < ActiveRecord::Migration
  def up
      change_column :tokens, :description, :text
  end
  def down
      # This might cause trouble if you have strings longer
      # than 255 characters.
      change_column :tokens, :description, :string
  end
end
