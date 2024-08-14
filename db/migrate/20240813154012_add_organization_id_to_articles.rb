class AddOrganizationIdToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :organization_id, :integer
  end
end
