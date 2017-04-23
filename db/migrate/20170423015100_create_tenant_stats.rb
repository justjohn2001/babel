class CreateTenantStats < ActiveRecord::Migration
  def change
    create_table :tenant_stats do |t|
      t.integer :request_count
      t.references :tenant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
