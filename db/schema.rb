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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120414231958) do

  create_table "events", :force => true do |t|
    t.integer  "event_id"
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.integer  "state_id"
    t.string   "venue"
    t.integer  "venue_id"
    t.datetime "date"
    t.string   "map_url"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "grandchild_category_id"
    t.integer  "team_id"
  end

  add_index "events", ["event_id"], :name => "index_events_on_event_id"
  add_index "events", ["team_id"], :name => "index_events_on_team_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "team_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "grandchild_category_id"
  end

  add_index "teams", ["team_id"], :name => "index_teams_on_team_id"

  create_table "ticket_splits", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "split"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ticket_splits", ["ticket_id"], :name => "index_ticket_splits_on_ticket_id"

  create_table "tickets", :force => true do |t|
    t.integer  "event_id"
    t.integer  "ticket_id"
    t.string   "notes"
    t.string   "row"
    t.string   "section"
    t.integer  "quantity"
    t.string   "ticket_type"
    t.decimal  "price"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tickets", ["event_id"], :name => "index_tickets_on_event_id"
  add_index "tickets", ["ticket_id"], :name => "index_tickets_on_ticket_id"

end
