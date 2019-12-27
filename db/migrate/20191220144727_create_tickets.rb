# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :request_number, null: false
      t.string :sequence_number, null: false
      t.string :request_type, null: false
      t.json :date_times, null: false
      t.json :service_area, null: false
      t.json :digsite_info, null: false

      t.timestamps
    end
  end
end
