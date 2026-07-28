class CreateQuests < ActiveRecord::Migration[7.2]
  def change
    create_table :quests do |t|
      t.string :title, null: false
      t.text :description
      t.string :difficulty, null: false
      t.integer :xp_reward, null: false
      t.boolean :completed, null: false, default: false
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
