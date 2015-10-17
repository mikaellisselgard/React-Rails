class AddColumnToChecklists < ActiveRecord::Migration
  def change
    add_column :checklists, :done, :boolean
  end
end
