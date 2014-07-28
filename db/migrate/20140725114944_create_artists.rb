class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :day
      t.string :hour
      t.string :name

      t.belongs_to :stage

      t.timestamps
    end
  end
end
