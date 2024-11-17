class CreateEquipaments < ActiveRecord::Migration[7.2]
  def change
    create_table :equipaments do |t|
      t.string :name

      t.timestamps
    end
  end
end
