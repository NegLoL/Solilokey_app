class CreatePrivateposts < ActiveRecord::Migration[6.0]
  def change
    create_table :privateposts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.string :image_name

      t.timestamps
    end
  end
end
