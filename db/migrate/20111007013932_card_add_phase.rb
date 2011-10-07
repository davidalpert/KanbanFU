class CardAddPhase < ActiveRecord::Migration
  def change
    add_column :cards, :phase_id, :integer
  end
end
