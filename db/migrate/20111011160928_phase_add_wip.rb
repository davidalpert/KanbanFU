class PhaseAddWip < ActiveRecord::Migration
  def change
    add_column :phases, :wip, :integer
  end
end
