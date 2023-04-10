class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :profile_image
      t.integer :user_id
      t.string :place
      t.text :introduce
      t.timestamps
    end
  end
end
