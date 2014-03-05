class AddStatusToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :status_cd, :integer, default: 0
  end
end
