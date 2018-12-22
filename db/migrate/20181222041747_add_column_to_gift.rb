class AddColumnToGift < ActiveRecord::Migration[5.2]
  def change
    add_column :gifts, :taker_name, :string
  end
end
