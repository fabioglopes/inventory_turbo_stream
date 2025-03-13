class AddInternalRoleToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :internal_role, :string, default: "user", null: false
  end
end
