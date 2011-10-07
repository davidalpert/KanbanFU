class AddCardFields < ActiveRecord::Migration
  def change
    add_column :cards, :started_on, :datetime
    add_column :cards, :finished_on, :datetime
    add_column :cards, :size, :int
    add_column :cards, :blocked_time, :float
    add_column :cards, :waiting_time, :float
  end
end
