class RemoveGiftNameFromGifts < ActiveRecord::Migration[5.2]
  def change
    remove_column :gifts, :gift_name, :string
    remove_column :gifts, :taker_name, :string
    remove_column :gifts, :image_url, :string
  end
end
