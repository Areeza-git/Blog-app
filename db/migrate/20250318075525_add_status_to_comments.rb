class AddStatusToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :status, :string, default: "public", null: false
  end
end
