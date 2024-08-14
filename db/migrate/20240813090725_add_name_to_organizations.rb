class AddNameToOrganizations < ActiveRecord::Migration[7.2]
  def change
    add_column :organizations, :name, :string
  end
end
