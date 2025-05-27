class AddTenantIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :tenant_id, :integer
    add_index :users, :tenant_id
    # Add foreign key constraint if the tenants table exists
  end
end
