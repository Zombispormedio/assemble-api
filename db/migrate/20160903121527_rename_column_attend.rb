class RenameColumnAttend < ActiveRecord::Migration
  def change
    rename_column :attendances, :attent_?, :attend?
  end
end
