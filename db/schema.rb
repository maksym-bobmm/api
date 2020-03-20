#%RAML 0.8
# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_191_221_121_149) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'excavators', force: :cascade do |t|
    t.json 'excavator', null: false
    t.bigint 'ticket_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['ticket_id'], name: 'index_excavators_on_ticket_id'
  end

  create_table 'tickets', force: :cascade do |t|
    t.string 'request_number', null: false
    t.string 'sequence_number', null: false
    t.string 'request_type', null: false
    t.json 'date_times', null: false
    t.json 'service_area', null: false
    t.json 'digsite_info', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'excavators', 'tickets'
end
