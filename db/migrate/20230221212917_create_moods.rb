class CreateMoods < ActiveRecord::Migration[7.0]
  def change
    create_table :moods do |t|
      t.string :emojie
      t.string :definition

      t.timestamps
    end
  end
end
