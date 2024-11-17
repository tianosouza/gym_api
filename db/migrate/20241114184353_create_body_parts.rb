class CreateBodyParts < ActiveRecord::Migration[7.2]
  def change
    create_table :body_parts do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
