class Renamecolumnnamemusic < ActiveRecord::Migration[7.0]
  def change
    rename_column :musics, :name, :music_id
  end
end
