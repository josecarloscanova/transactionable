# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140108213120) do

  create_table "transactionable_bank_accounts", force: true do |t|
    t.integer  "bank_accountable_id"
    t.string   "bank_accountable_type"
    t.string   "account_number"
    t.string   "name"
    t.string   "bank_name"
    t.string   "description"
    t.string   "account_type"
    t.boolean  "can_debit"
    t.boolean  "verified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactionable_credit_cards", force: true do |t|
    t.integer  "credit_cardable_id"
    t.string   "credit_cardable_type"
    t.string   "name"
    t.string   "description"
    t.integer  "last_four"
    t.string   "brand"
    t.integer  "expiration_month"
    t.integer  "expiration_year"
    t.date     "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactionable_remote_entities", force: true do |t|
    t.string   "uri"
    t.string   "service_name"
    t.integer  "local_entity_id"
    t.string   "local_entity_type"
    t.time     "synced_at"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactionable_transactions", force: true do |t|
    t.integer  "transactionable_id"
    t.string   "transactionable_type"
    t.integer  "transaction_loggable_id"
    t.string   "transaction_loggable_type"
    t.integer  "credit_id"
    t.integer  "debit_id"
    t.decimal  "amount",                    precision: 8, scale: 2
    t.string   "status"
    t.string   "description"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
