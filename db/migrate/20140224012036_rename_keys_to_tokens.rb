class RenameKeysToTokens < ActiveRecord::Migration
  def self.up
    rename_table :keys, :tokens
    rename_column :tokens, :key, :token
  end 
  def self.down
    rename_table :tokens, :keys
    rename_column :keys, :token, :key
  end
end