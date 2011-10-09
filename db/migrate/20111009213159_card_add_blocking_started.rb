class CardAddBlockingStarted < ActiveRecord::Migration
  def change
    add_column :cards, :block_started, :datetime
  end
end
