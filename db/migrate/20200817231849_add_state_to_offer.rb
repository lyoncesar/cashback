class AddStateToOffer < ActiveRecord::Migration[6.0]
  def change
    add_column :offers, :state, :integer, default: 0, null: false
  end
end
