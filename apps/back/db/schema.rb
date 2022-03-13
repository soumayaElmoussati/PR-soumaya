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

ActiveRecord::Schema.define(version: 2021_10_28_154733) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.integer "people_count", default: 0
    t.integer "price_per_person", default: 0
    t.integer "additional_traveler_price", default: 0
    t.integer "additional_max_people", default: 0
    t.integer "max_people_count"
    t.integer "state", default: 0
    t.bigint "farmer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "departure_time", default: 16
    t.integer "arriving_time", default: 14
    t.integer "departure_min_time", default: 30
    t.integer "arriving_min_time", default: 0
    t.index ["farmer_id"], name: "index_activities_on_farmer_id"
  end

  create_table "activity_addresses", force: :cascade do |t|
    t.string "name"
    t.string "street_name"
    t.string "city"
    t.string "postal_code"
    t.string "country_code"
    t.float "lat"
    t.float "lng"
    t.bigint "activity_id"
    t.string "area_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["activity_id"], name: "index_activity_addresses_on_activity_id"
  end

  create_table "activity_agriculture_types", force: :cascade do |t|
    t.bigint "activity_id"
    t.boolean "biological", default: false
    t.boolean "permaculture", default: false
    t.boolean "agroecology", default: false
    t.boolean "agroecological", default: false
    t.boolean "conventional", default: false
    t.boolean "ringing", default: false
    t.boolean "durable", default: false
    t.boolean "reliability", default: false
    t.boolean "hydroponics", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_agriculture_types_on_activity_id"
  end

  create_table "activity_animals", force: :cascade do |t|
    t.bigint "activity_id"
    t.boolean "cow", default: false
    t.boolean "milk_cow", default: false
    t.boolean "sheep", default: false
    t.boolean "goat", default: false
    t.boolean "pig", default: false
    t.boolean "rabbit", default: false
    t.boolean "duck", default: false
    t.boolean "goose", default: false
    t.boolean "turkey", default: false
    t.boolean "chicken", default: false
    t.boolean "donkey", default: false
    t.boolean "snail", default: false
    t.boolean "horse", default: false
    t.boolean "bee", default: false
    t.boolean "lama", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_animals_on_activity_id"
  end

  create_table "activity_bookings", force: :cascade do |t|
    t.integer "status"
    t.integer "people_count"
    t.date "arrival_date"
    t.date "departure_date"
    t.integer "total"
    t.integer "comission_fee", default: 0
    t.string "promo_code"
    t.bigint "client_id"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_bookings_on_activity_id"
    t.index ["client_id"], name: "index_activity_bookings_on_client_id"
  end

  create_table "activity_descriptions", force: :cascade do |t|
    t.bigint "activity_id"
    t.string "residence"
    t.string "farmer"
    t.string "activities"
    t.string "farm"
    t.boolean "discovery", default: false
    t.boolean "meeting_animals", default: false
    t.boolean "milking_animals", default: false
    t.boolean "tasting", default: false
    t.boolean "birth_animal", default: false
    t.boolean "stroll", default: false
    t.boolean "harvest", default: false
    t.boolean "craft", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_descriptions_on_activity_id"
  end

  create_table "activity_farm_types", force: :cascade do |t|
    t.bigint "activity_id"
    t.boolean "breeder", default: false
    t.boolean "cereal", default: false
    t.boolean "horticulturist", default: false
    t.boolean "market_gardener", default: false
    t.boolean "cheese_production", default: false
    t.boolean "winegrower", default: false
    t.boolean "brewer", default: false
    t.boolean "arborist", default: false
    t.boolean "oyster_farmer", default: false
    t.boolean "mushroom_grower", default: false
    t.boolean "beekeeper", default: false
    t.boolean "cider_maker", default: false
    t.boolean "riding_stable", default: false
    t.boolean "agroforestry", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_farm_types_on_activity_id"
  end

  create_table "activity_settlements", force: :cascade do |t|
    t.bigint "activity_id"
    t.boolean "baby_suitable", default: false
    t.boolean "child_suitable", default: false
    t.boolean "smooking_allowed", default: false
    t.boolean "parties_allowed", default: false
    t.string "additional_rules"
    t.boolean "animals_welcome", default: false
    t.boolean "accessible", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_settlements_on_activity_id"
  end

  create_table "activity_tags", force: :cascade do |t|
    t.bigint "activity_id"
    t.boolean "playful", default: false
    t.boolean "pedagogic", default: false
    t.boolean "unusual", default: false
    t.boolean "public", default: false
    t.boolean "gustatory", default: false
    t.boolean "animal", default: false
    t.boolean "dirty", default: false
    t.boolean "rewarding", default: false
    t.boolean "depth", default: false
    t.boolean "intensive", default: false
    t.boolean "quick", default: false
    t.boolean "physical", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_activity_tags_on_activity_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "name"
    t.string "street_name"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "country_code"
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "offer_id"
    t.string "area_code"
    t.index ["area_code"], name: "index_addresses_on_area_code"
    t.index ["offer_id"], name: "index_addresses_on_offer_id"
  end

  create_table "admins", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "annexe_services", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price"
    t.bigint "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unity", default: "1"
    t.index ["offer_id"], name: "index_annexe_services_on_offer_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "status"
    t.bigint "client_id"
    t.bigint "offer_id"
    t.integer "people_count"
    t.datetime "arrival_date"
    t.datetime "departure_date"
    t.integer "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "commission_fee", default: 0
    t.integer "service_fee", default: 0
    t.integer "offer_price_per_night", default: 0
    t.integer "sub_total", default: 0
    t.integer "total_services", default: 0
    t.integer "occupancy_tax", default: 0
    t.integer "lodging_cost", default: 0
    t.string "promo_code"
    t.integer "farmer_deposit"
    t.string "stripe_token"
    t.integer "adult_count"
    t.integer "child_count"
    t.boolean "breakfast_opt", default: false
    t.boolean "linens_opt", default: false
    t.boolean "cleaning_opt", default: false
    t.string "contact_number"
    t.text "message"
    t.integer "annexe_services_total", default: 0
    t.integer "panier_nb"
    t.text "panier_msg"
    t.integer "panier_total"
    t.integer "bike_rent_nb"
    t.integer "bike_rent_price"
    t.text "bike_rent_msg"
    t.integer "breakfast_nb"
    t.integer "breakfast_price"
    t.text "breakfast_msg"
    t.integer "packed_lunch_nb"
    t.integer "packed_lunch_price"
    t.text "packed_lunch_msg"
    t.integer "cooking_workshop_nb"
    t.integer "cooking_workshop_price"
    t.text "cooking_workshop_msg"
    t.integer "serenity_nb"
    t.integer "serenity_price"
    t.text "serenity_msg"
    t.integer "spa_nb"
    t.integer "spa_price"
    t.text "spa_msg"
    t.integer "car_rent_nb"
    t.integer "car_rent_price"
    t.text "car_rent_msg"
    t.integer "station_ride_nb"
    t.integer "station_ride_price"
    t.text "station_ride_msg"
    t.integer "animal_space_nb"
    t.integer "animal_space_price"
    t.text "animal_space_msg"
    t.integer "host_table_nb"
    t.integer "host_table_price"
    t.text "host_table_msg"
    t.string "channel"
    t.boolean "managed", default: false
    t.integer "washing_kit_nb"
    t.integer "washing_kit_price"
    t.text "washing_kit_msg"
    t.integer "bbq_nb"
    t.integer "bbq_price"
    t.text "bbq_msg"
    t.integer "riding_lesson_nb"
    t.integer "riding_lesson_price"
    t.text "riding_lesson_msg"
    t.integer "horse_ride_nb"
    t.integer "horse_ride_price"
    t.text "horse_ride_msg"
    t.integer "riding_course_nb"
    t.integer "riding_course_price"
    t.text "riding_course_msg"
    t.integer "riding_introduction_nb"
    t.integer "riding_introduction_price"
    t.text "riding_introduction_msg"
    t.integer "immersion_nb"
    t.integer "immersion_price"
    t.text "immersion_msg"
    t.integer "breakfast_total", default: 0
    t.integer "linens_total", default: 0
    t.integer "cleaning_total", default: 0
    t.string "receipt_url"
    t.boolean "housework", default: false
    t.integer "housework_price"
    t.index ["arrival_date"], name: "index_bookings_on_arrival_date"
    t.index ["client_id"], name: "index_bookings_on_client_id"
    t.index ["departure_date"], name: "index_bookings_on_departure_date"
    t.index ["offer_id"], name: "index_bookings_on_offer_id"
    t.index ["status"], name: "index_bookings_on_status"
  end

  create_table "clients", force: :cascade do |t|
    t.bigint "user_id"
    t.boolean "solvent", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bookings_count"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "cloud_activity_pictures", force: :cascade do |t|
    t.string "public_id"
    t.string "url"
    t.integer "order", default: 1
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_cloud_activity_pictures_on_activity_id"
  end

  create_table "cloud_expense_pictures", force: :cascade do |t|
    t.string "public_id"
    t.string "url"
    t.bigint "expense_id"
    t.integer "order", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_cloud_expense_pictures_on_expense_id"
  end

  create_table "cloud_offer_pictures", force: :cascade do |t|
    t.string "public_id"
    t.string "url"
    t.integer "order", default: 1
    t.bigint "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_cloud_offer_pictures_on_offer_id"
  end

  create_table "cloud_pictures", force: :cascade do |t|
    t.bigint "offer_id"
    t.integer "order", default: 1
    t.string "public_id"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_type", default: "offer"
    t.index ["offer_id"], name: "index_cloud_pictures_on_offer_id"
  end

  create_table "cloud_profile_pictures", force: :cascade do |t|
    t.string "public_id"
    t.string "url"
    t.bigint "farmer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order", default: 1
    t.index ["farmer_id"], name: "index_cloud_profile_pictures_on_farmer_id"
  end

  create_table "cloud_review_pictures", force: :cascade do |t|
    t.string "public_id"
    t.string "url"
    t.integer "order", default: 1
    t.bigint "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_cloud_review_pictures_on_review_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "arrival_date"
    t.datetime "departure_date"
    t.bigint "offer_id"
    t.integer "booking_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_events_on_offer_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "responsable"
    t.bigint "offer_id"
    t.date "expense_date"
    t.float "total_ttc"
    t.float "total_ht"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", default: 1
    t.index ["offer_id"], name: "index_expenses_on_offer_id"
  end

  create_table "external_activity_bookings", force: :cascade do |t|
    t.string "uid"
    t.datetime "start"
    t.datetime "end"
    t.string "source"
    t.text "notes"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_external_activity_bookings_on_activity_id"
  end

  create_table "external_bookings", force: :cascade do |t|
    t.bigint "offer_id"
    t.string "uid", null: false
    t.datetime "start", null: false
    t.datetime "end", null: false
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.index ["offer_id"], name: "index_external_bookings_on_offer_id"
  end

  create_table "farmer_equipments", force: :cascade do |t|
    t.bigint "farmer_id"
    t.boolean "english", default: false
    t.boolean "spanish", default: false
    t.boolean "german", default: false
    t.boolean "italian", default: false
    t.boolean "portuguese", default: false
    t.boolean "russian", default: false
    t.boolean "dutch", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "french", default: false
    t.index ["farmer_id"], name: "index_farmer_equipments_on_farmer_id"
  end

  create_table "farmer_incomes", force: :cascade do |t|
    t.bigint "offer_id"
    t.integer "state", default: 0
    t.date "start_date"
    t.date "end_date"
    t.string "period_name"
    t.text "note"
    t.float "expenses_balance"
    t.float "lodging_income_balance"
    t.float "farmer_balance"
    t.float "housework_income_balance"
    t.float "annexes_incomes_balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stay_count"
    t.float "total_farmer_balance"
    t.float "total_offer_income"
    t.float "farmer_expenses"
    t.index ["offer_id"], name: "index_farmer_incomes_on_offer_id"
  end

  create_table "farmer_organisations", force: :cascade do |t|
    t.boolean "adb", default: false
    t.boolean "bbc", default: false
    t.boolean "fairefrance", default: false
    t.bigint "farmer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["farmer_id"], name: "index_farmer_organisations_on_farmer_id"
  end

  create_table "farmer_reviews", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "cleanliness"
    t.integer "communication"
    t.integer "respect"
    t.integer "experience"
    t.boolean "welcome"
    t.integer "state", default: 1
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "booking_id"
    t.string "full_name"
    t.index ["booking_id"], name: "index_farmer_reviews_on_booking_id"
  end

  create_table "farmers", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "stripe_user_id"
    t.boolean "agriculteur_de_bretagne", default: false
    t.string "stripe_link"
    t.boolean "payments_authorisation", default: false
    t.index ["user_id"], name: "index_farmers_on_user_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "offer_adjectifs", force: :cascade do |t|
    t.bigint "offer_id"
    t.boolean "rustic", default: false
    t.boolean "luxurious", default: false
    t.boolean "confortable", default: false
    t.boolean "clean", default: false
    t.boolean "friendly", default: false
    t.boolean "calm", default: false
    t.boolean "exotic", default: false
    t.boolean "romantic", default: false
    t.boolean "cheap", default: false
    t.boolean "insolit", default: false
    t.boolean "simple", default: false
    t.boolean "luminous", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_offer_adjectifs_on_offer_id"
  end

  create_table "offer_agriculture_types", force: :cascade do |t|
    t.bigint "offer_id"
    t.boolean "biological", default: false
    t.boolean "permaculture", default: false
    t.boolean "agroecology", default: false
    t.boolean "agroecological", default: false
    t.boolean "conventional", default: false
    t.boolean "ringing", default: false
    t.boolean "durable", default: false
    t.boolean "reliability", default: false
    t.boolean "hydroponics", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_offer_agriculture_types_on_offer_id"
  end

  create_table "offer_animals", force: :cascade do |t|
    t.bigint "offer_id"
    t.boolean "cow", default: false
    t.boolean "milk_cow", default: false
    t.boolean "sheep", default: false
    t.boolean "goat", default: false
    t.boolean "pig", default: false
    t.boolean "rabbit", default: false
    t.boolean "duck", default: false
    t.boolean "goose", default: false
    t.boolean "turkey", default: false
    t.boolean "chicken", default: false
    t.boolean "donkey", default: false
    t.boolean "snail", default: false
    t.boolean "horse", default: false
    t.boolean "bee", default: false
    t.boolean "lama", default: false
    t.index ["offer_id"], name: "index_offer_animals_on_offer_id"
  end

  create_table "offer_benefits", force: :cascade do |t|
    t.boolean "cleaning_kit"
    t.boolean "toilet_paper"
    t.boolean "soap"
    t.boolean "household_linen"
    t.bigint "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_offer_benefits_on_offer_id"
  end

  create_table "offer_descriptions", force: :cascade do |t|
    t.text "residence"
    t.text "farmer"
    t.text "activities"
    t.bigint "offer_id"
    t.string "farm"
    t.boolean "discovery", default: false
    t.boolean "meeting_animals", default: false
    t.boolean "milking_animals", default: false
    t.boolean "tasting", default: false
    t.boolean "birth_animal", default: false
    t.boolean "stroll", default: false
    t.boolean "harvest", default: false
    t.boolean "craft", default: false
    t.index ["offer_id"], name: "index_offer_descriptions_on_offer_id"
  end

  create_table "offer_equipments", force: :cascade do |t|
    t.bigint "offer_id"
    t.boolean "kitchen", default: false
    t.boolean "wifi", default: false
    t.boolean "tv", default: false
    t.boolean "washing_machine", default: false
    t.boolean "fireplace", default: false
    t.boolean "parking", default: false
    t.boolean "swimming_pool", default: false
    t.boolean "domestic_animals", default: false
    t.boolean "english_speaking", default: false
    t.boolean "private_garden", default: false
    t.boolean "shared_garden", default: false
    t.boolean "internet", default: false
    t.boolean "dvd_player", default: false
    t.boolean "games", default: false
    t.boolean "dryer", default: false
    t.boolean "hair_dryer", default: false
    t.boolean "drying_rack", default: false
    t.boolean "iron", default: false
    t.boolean "wardrobe", default: false
    t.boolean "shower", default: false
    t.boolean "bath", default: false
    t.boolean "baby_bath", default: false
    t.boolean "heater", default: false
    t.boolean "clim", default: false
    t.boolean "fitness", default: false
    t.boolean "garden_lounge", default: false
    t.boolean "bbq", default: false
    t.boolean "oven", default: false
    t.boolean "hotplates", default: false
    t.boolean "microwaves", default: false
    t.boolean "toaster", default: false
    t.boolean "kettle", default: false
    t.boolean "coffee_machine", default: false
    t.boolean "cutlery", default: false
    t.boolean "dishwasher", default: false
    t.boolean "baby_chair", default: false
    t.boolean "fridge", default: false
    t.boolean "freezer", default: false
    t.boolean "garage", default: false
    t.boolean "secure_local", default: false
    t.boolean "deep_freezer", default: false
    t.boolean "train", default: false
    t.index ["offer_id"], name: "index_offer_equipments_on_offer_id"
  end

  create_table "offer_farm_types", force: :cascade do |t|
    t.bigint "offer_id"
    t.boolean "breeder", default: false
    t.boolean "cereal", default: false
    t.boolean "horticulturist", default: false
    t.boolean "market_gardener", default: false
    t.boolean "cheese_production", default: false
    t.boolean "winegrower", default: false
    t.boolean "brewer", default: false
    t.boolean "arborist", default: false
    t.boolean "oyster_farmer", default: false
    t.boolean "mushroom_grower", default: false
    t.boolean "beekeeper", default: false
    t.boolean "cider_maker", default: false
    t.boolean "riding_stable", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "agroforestry", default: false
    t.index ["offer_id"], name: "index_offer_farm_types_on_offer_id"
  end

  create_table "offer_price_discounts", force: :cascade do |t|
    t.bigint "offer_id"
    t.integer "percentage_discount", default: 0
    t.integer "min_nights", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_offer_price_discounts_on_offer_id"
  end

  create_table "offer_price_periods", force: :cascade do |t|
    t.bigint "offer_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "price_period", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "min_days", default: 0
    t.boolean "use_discount", default: false
    t.index ["offer_id"], name: "index_offer_price_periods_on_offer_id"
  end

  create_table "offer_price_weekends", force: :cascade do |t|
    t.bigint "offer_id"
    t.integer "price"
    t.boolean "both_days", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_offer_price_weekends_on_offer_id"
  end

  create_table "offer_promotions", force: :cascade do |t|
    t.bigint "offer_id"
    t.date "start_date"
    t.date "end_date"
    t.integer "amount"
    t.boolean "statut", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_offer_promotions_on_offer_id"
  end

  create_table "offer_rooms", force: :cascade do |t|
    t.bigint "offer_id"
    t.integer "simple_bed", default: 0
    t.integer "double_bed", default: 0
    t.boolean "private_bathroom", default: false
    t.index ["offer_id"], name: "index_offer_rooms_on_offer_id"
  end

  create_table "offer_services", force: :cascade do |t|
    t.bigint "offer_id"
    t.boolean "breakfast", default: false
    t.integer "breakfast_price", default: 0
    t.boolean "linens", default: false
    t.integer "linens_price", default: 0
    t.boolean "cleaning", default: false
    t.integer "cleaning_price", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "host_table", default: false
    t.integer "host_table_price", default: 0
    t.string "esprit_link"
    t.boolean "esprit_ferme", default: false
    t.boolean "breakfastopt", default: false
    t.boolean "linensopt", default: false
    t.boolean "cleaningopt", default: false
    t.index ["offer_id"], name: "index_offer_services_on_offer_id"
  end

  create_table "offer_settlements", force: :cascade do |t|
    t.bigint "offer_id"
    t.boolean "baby_suitable", default: false
    t.boolean "child_suitable", default: false
    t.boolean "smooking_allowed", default: false
    t.boolean "parties_allowed", default: false
    t.string "additional_rules"
    t.boolean "animals_welcome", default: false
    t.boolean "accessible", default: false
    t.index ["offer_id"], name: "index_offer_settlements_on_offer_id"
  end

  create_table "offer_tags", force: :cascade do |t|
    t.bigint "offer_id"
    t.boolean "playful", default: false
    t.boolean "pedagogic", default: false
    t.boolean "unusual", default: false
    t.boolean "public", default: false
    t.boolean "gustatory", default: false
    t.boolean "animal", default: false
    t.boolean "dirty", default: false
    t.boolean "rewarding", default: false
    t.boolean "depth", default: false
    t.boolean "intensive", default: false
    t.boolean "quick", default: false
    t.boolean "physical", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_offer_tags_on_offer_id"
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "farmer_id"
    t.string "name"
    t.string "slug"
    t.integer "people_count", default: 0
    t.integer "residence_type", default: 0
    t.integer "price_per_person", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tax", default: 0
    t.integer "additional_traveler_price", default: 0
    t.integer "additional_max_people", default: 0
    t.integer "min_days", default: 1
    t.integer "deposit", default: 0
    t.integer "max_people_count"
    t.integer "toilets_count", default: 1
    t.integer "sleeps_count", default: 0
    t.integer "bathrooms_count", default: 1
    t.integer "rooms_count", default: 1
    t.integer "state", default: 1
    t.integer "departure_time", default: 11
    t.integer "arriving_time", default: 14
    t.integer "departure_min_time", default: 0
    t.integer "arriving_min_time", default: 0
    t.string "icalendar_urls", default: [], array: true
    t.boolean "certificated", default: false
    t.string "product_token"
    t.float "tourist_tax", default: 0.0
    t.boolean "manager", default: false
    t.boolean "instant_booking", default: false
    t.float "inverseur_percentage"
    t.integer "impressions_count", default: 1
    t.text "annexe_information"
    t.index ["farmer_id"], name: "index_offers_on_farmer_id"
    t.index ["max_people_count"], name: "index_offers_on_max_people_count"
    t.index ["price_per_person"], name: "index_offers_on_price_per_person"
    t.index ["residence_type"], name: "index_offers_on_residence_type"
    t.index ["slug"], name: "index_offers_on_slug"
    t.index ["state"], name: "index_offers_on_state"
  end

  create_table "pictures", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.integer "order", default: 0
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"
  end

  create_table "promocodes", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.boolean "state", default: false
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count", default: 0
    t.integer "max_usage"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "star"
    t.integer "residence_type"
    t.text "comment"
    t.date "stay_date"
    t.string "first_name"
    t.string "last_name"
    t.string "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "booking_id"
    t.string "situation"
    t.string "lodging"
    t.string "activity"
    t.string "services"
    t.string "contact"
    t.string "process"
    t.text "trip_note"
    t.boolean "reference"
    t.string "recipient"
    t.string "street_name"
    t.string "city"
    t.string "postal_code"
    t.string "country_code"
    t.float "lat"
    t.float "lng"
    t.integer "state", default: 1
    t.index ["booking_id"], name: "index_reviews_on_booking_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "birthdate"
    t.string "phone"
    t.string "cellphone"
    t.json "tokens"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.boolean "allow_password_change", default: false
    t.string "unconfirmed_email"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean "ambassador", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "activities", "farmers"
  add_foreign_key "activity_addresses", "activities"
  add_foreign_key "activity_agriculture_types", "activities"
  add_foreign_key "activity_animals", "activities"
  add_foreign_key "activity_bookings", "activities"
  add_foreign_key "activity_bookings", "clients"
  add_foreign_key "activity_descriptions", "activities"
  add_foreign_key "activity_farm_types", "activities"
  add_foreign_key "activity_settlements", "activities"
  add_foreign_key "activity_tags", "activities"
  add_foreign_key "admins", "users"
  add_foreign_key "annexe_services", "offers"
  add_foreign_key "bookings", "clients"
  add_foreign_key "bookings", "offers"
  add_foreign_key "clients", "users"
  add_foreign_key "cloud_activity_pictures", "activities"
  add_foreign_key "cloud_expense_pictures", "expenses"
  add_foreign_key "cloud_offer_pictures", "offers"
  add_foreign_key "cloud_pictures", "offers"
  add_foreign_key "cloud_profile_pictures", "farmers"
  add_foreign_key "cloud_review_pictures", "reviews"
  add_foreign_key "events", "offers"
  add_foreign_key "expenses", "offers"
  add_foreign_key "external_activity_bookings", "activities"
  add_foreign_key "external_bookings", "offers"
  add_foreign_key "farmer_equipments", "farmers"
  add_foreign_key "farmer_incomes", "offers"
  add_foreign_key "farmer_organisations", "farmers"
  add_foreign_key "farmer_reviews", "bookings"
  add_foreign_key "farmers", "users"
  add_foreign_key "offer_adjectifs", "offers"
  add_foreign_key "offer_agriculture_types", "offers"
  add_foreign_key "offer_benefits", "offers"
  add_foreign_key "offer_equipments", "offers"
  add_foreign_key "offer_farm_types", "offers"
  add_foreign_key "offer_price_discounts", "offers"
  add_foreign_key "offer_price_periods", "offers"
  add_foreign_key "offer_price_weekends", "offers"
  add_foreign_key "offer_promotions", "offers"
  add_foreign_key "offer_rooms", "offers"
  add_foreign_key "offer_services", "offers"
  add_foreign_key "offer_settlements", "offers"
  add_foreign_key "offer_tags", "offers"
  add_foreign_key "offers", "farmers"
  add_foreign_key "reviews", "bookings"
end
