class CreateTickets < ActiveRecord::Migration[5.1]
  enable_extension 'hstore' unless extension_enabled?('hstore')
  def change
    create_table :tickets do |t|
      t.string :RequestNumber
      t.string :SequenceNumber
      t.string :RequestType
      t.hstore 'DateTimes'
      t.hstore 'ServiceArea'
      t.hstore 'DigsiteInfo'

      t.timestamps
    end
  end
end
