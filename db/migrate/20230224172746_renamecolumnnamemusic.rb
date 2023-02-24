class Renamecolumnnamemusic < ActiveRecord::Migration[7.0]
  def change
    rename_column :musics, :name, :spotify_id
  end
end
