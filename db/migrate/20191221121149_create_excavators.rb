class CreateExcavators < ActiveRecord::Migration[5.1]
  def change
    create_table :excavators do |t|
      t.json :excavator, null: false
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
