class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :advertiser_name
      t.string :url
      t.boolean :premium
      t.datetime :starts_at
      t.datetime :ends_at
      t.text :description

      t.timestamps
    end
  end
end
