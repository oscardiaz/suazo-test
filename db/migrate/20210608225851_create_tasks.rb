class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :group, foreign_key: { on_update: :cascade, on_delete: :cascade }, index: true
      t.string :title
      t.string :description
      t.integer :status, limit: 1, default: 0

      t.timestamps
    end
  end
end
