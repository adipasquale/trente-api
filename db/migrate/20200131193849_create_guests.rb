class CreateGuests < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.string :name
      t.string :email
      t.string :browser_uuid

      t.timestamps
    end
  end
end
