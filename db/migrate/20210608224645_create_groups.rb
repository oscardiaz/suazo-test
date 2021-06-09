class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.references :user, foreign_key: { on_update: :cascade, on_delete: :cascade }, index: true
      t.string :title

      t.timestamps
    end
  end
end
