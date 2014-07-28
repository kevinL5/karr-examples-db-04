class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      t.string  :name
      t.integer :price_per_day

      t.timestamps
    end
  end
end
