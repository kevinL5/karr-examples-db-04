class CreateFestivalsGenres < ActiveRecord::Migration
  def change
    create_table :festivals_genres do |t|
      t.belongs_to :festival
      t.belongs_to :genre

      t.timestamps
    end
  end
end
