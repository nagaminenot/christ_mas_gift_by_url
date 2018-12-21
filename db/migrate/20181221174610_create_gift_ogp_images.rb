class CreateGiftOgpImages < ActiveRecord::Migration[5.2]
  def change
    create_table :gift_ogp_images do |t|
      t.references :gift, foreign_key: true
      t.text :image

      t.timestamps
    end
  end
end
