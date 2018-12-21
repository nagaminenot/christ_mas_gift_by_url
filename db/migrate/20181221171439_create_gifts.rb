class CreateGifts < ActiveRecord::Migration[5.2]
  def change
    create_table :gifts do |t|
      t.string :gift_name
      t.string :giver_name
      t.string :taker_name
      t.string :gift_url
      t.string :image_url
      t.string :message
      t.string :slug

      t.timestamps
    end
  end
end
