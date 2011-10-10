class CardAddReadyStarted < ActiveRecord::Migration
  def change
    add_column :cards, :ready_started, :datetime
  end
end
