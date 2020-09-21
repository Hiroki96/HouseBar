class AddColumnsToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :amount, :integer
    add_column :posts, :alcohol, :integer
  end
end
