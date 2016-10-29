class RenameAssistants < ActiveRecord::Migration
  def change

    rename_table :assistants, :attendances


    rename_column :attendances, :attendance, :attent_?

  end
end
