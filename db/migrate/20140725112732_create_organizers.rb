class CreateOrganizers < ActiveRecord::Migration
  def change
    create_table :organizers do |t|
      t.string :name
      t.string :email
      t.string :password

      t.belongs_to :festival

      t.timestamps
    end
  end
end
