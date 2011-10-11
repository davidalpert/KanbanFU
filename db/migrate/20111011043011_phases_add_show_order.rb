class PhasesAddShowOrder < ActiveRecord::Migration
  def change
    add_column :phases, :show_order, :integer
  end
end
