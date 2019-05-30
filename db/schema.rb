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

ActiveRecord::Schema.define(version: 2019_02_05_173140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "ancestry"
    t.boolean "imputable", default: false, null: false
    t.string "names_depth_cache", default: "", null: false
    t.string "nature", default: "patrimonial", null: false
    t.index ["ancestry"], name: "index_accounts_on_ancestry"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "house_number"
    t.string "neighborhood"
    t.string "block"
    t.string "floor"
    t.string "number_department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "provider_id"
    t.bigint "city_id"
    t.bigint "province_id"
    t.bigint "country_id"
    t.index ["city_id"], name: "index_addresses_on_city_id"
    t.index ["country_id"], name: "index_addresses_on_country_id"
    t.index ["provider_id"], name: "index_addresses_on_provider_id"
    t.index ["province_id"], name: "index_addresses_on_province_id"
  end

  create_table "auth_tokens", force: :cascade do |t|
    t.text "token"
    t.datetime "expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "background_jobs", force: :cascade do |t|
    t.string "job_id"
    t.string "detailed_status"
    t.string "error_msg"
    t.integer "status", default: 0, null: false
    t.integer "progress", default: 0
    t.string "job_item_type"
    t.bigint "job_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_item_type", "job_item_id"], name: "index_background_jobs_on_job_item_type_and_job_item_id"
  end

  create_table "balancers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_balancers_on_name", unique: true
  end

  create_table "billing_exports", force: :cascade do |t|
    t.integer "export_type", default: 0, null: false
    t.datetime "datetime"
    t.decimal "total_amount", precision: 15, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "background_job_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "product_id"
    t.index ["category_id"], name: "index_categories_products_on_category_id"
    t.index ["product_id"], name: "index_categories_products_on_product_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "province_id"
    t.integer "ucrm_id"
    t.integer "contabilium_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "firstname", default: "", null: false
    t.string "lastname", default: "", null: false
    t.integer "number", null: false
    t.integer "ucrm_id"
    t.integer "contabilium_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_name"
    t.integer "iva_condition", default: 0, null: false
    t.integer "client_type", default: 0, null: false
    t.integer "document_type", default: 0, null: false
    t.bigint "document_number"
    t.string "phone"
    t.string "email"
    t.integer "country_id"
    t.integer "province_id"
    t.integer "city_id"
    t.string "address"
    t.string "floor_dept"
    t.text "notes"
    t.string "postal_code"
    t.integer "organization_id"
    t.index ["ucrm_id"], name: "index_clients_on_ucrm_id", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "provider_id"
    t.string "type_phone"
    t.bigint "telephone_type_id"
    t.index ["provider_id"], name: "index_contacts_on_provider_id"
    t.index ["telephone_type_id"], name: "index_contacts_on_telephone_type_id"
  end

  create_table "corporate_cellphones", force: :cascade do |t|
    t.bigint "phone", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone"], name: "index_corporate_cellphones_on_phone", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "contabilium_id"
    t.integer "ucrm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "deposit_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "deposits", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.bigint "city_id"
    t.bigint "province_id"
    t.bigint "country_id"
    t.bigint "deposit_type_id"
    t.index ["city_id"], name: "index_deposits_on_city_id"
    t.index ["country_id"], name: "index_deposits_on_country_id"
    t.index ["deposit_type_id"], name: "index_deposits_on_deposit_type_id"
    t.index ["province_id"], name: "index_deposits_on_province_id"
  end

  create_table "devices", force: :cascade do |t|
    t.inet "ip_address"
    t.string "model", default: "", null: false
    t.string "serial_number", default: "", null: false
    t.integer "ucrm_device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "families", force: :cascade do |t|
    t.string "name"
    t.bigint "producer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["producer_id"], name: "index_families_on_producer_id"
  end

  create_table "ground_wire_setup_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_ground_wire_setup_types_on_name", unique: true
  end

  create_table "group_permissions", force: :cascade do |t|
    t.integer "group_id"
    t.integer "permission_id"
    t.integer "permission_code", default: 0, null: false
    t.index ["group_id", "permission_id"], name: "index_group_permissions_on_group_id_and_permission_id", unique: true
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.integer "organization_id"
    t.index ["name"], name: "index_groups_on_name", unique: true
  end

  create_table "inventories", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "deposit_id"
    t.string "firmware_version"
    t.string "serial_number"
    t.string "mac_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "provider_id"
    t.boolean "product_exist"
    t.string "status"
    t.index ["deposit_id"], name: "index_inventories_on_deposit_id"
    t.index ["product_id"], name: "index_inventories_on_product_id"
    t.index ["provider_id"], name: "index_inventories_on_provider_id"
  end

  create_table "invoice_items", force: :cascade do |t|
    t.integer "invoice_id"
    t.integer "quantity", default: 1, null: false
    t.decimal "iva", default: "0.21", null: false
    t.decimal "amount", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "discount", precision: 15, scale: 2, default: "0.0", null: false
    t.string "description", default: "", null: false
    t.integer "contaibilium_id"
    t.integer "ucrm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "net_amount", precision: 17, scale: 4, default: "0.0", null: false
    t.decimal "iva_amount", precision: 17, scale: 4, default: "0.0", null: false
    t.integer "concept_id", null: false
    t.string "account_code", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "client_id"
    t.integer "billing_export_id"
    t.integer "voucher_type", default: 9, null: false
    t.integer "sale_condition", default: 0, null: false
    t.integer "sale_point", default: 4, null: false
    t.datetime "emission_date"
    t.datetime "expiry_date"
    t.text "notes", default: ""
    t.integer "contabilium_id"
    t.integer "ucrm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mode", default: 0, null: false
    t.decimal "total_amount", precision: 15, scale: 2, default: "0.0", null: false
  end

  create_table "move_details", force: :cascade do |t|
    t.bigint "inventory_id"
    t.bigint "move_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "site_from_id"
    t.bigint "site_to_id"
    t.index ["inventory_id"], name: "index_move_details_on_inventory_id"
    t.index ["move_id"], name: "index_move_details_on_move_id"
    t.index ["site_from_id"], name: "index_move_details_on_site_from_id"
    t.index ["site_to_id"], name: "index_move_details_on_site_to_id"
  end

  create_table "moves", force: :cascade do |t|
    t.datetime "move_date"
    t.bigint "user_register_id"
    t.bigint "user_take_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "voucher_type"
    t.string "voucher_number"
    t.bigint "voucher_type_id"
    t.index ["user_register_id"], name: "index_moves_on_user_register_id"
    t.index ["user_take_id"], name: "index_moves_on_user_take_id"
    t.index ["voucher_type_id"], name: "index_moves_on_voucher_type_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "account_code", default: "", null: false
    t.integer "concept_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ucrm_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "title"
    t.string "category"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "organization_filter", default: false, null: false
    t.text "custom_actions"
  end

  create_table "plan_services", force: :cascade do |t|
    t.string "name", null: false
    t.integer "ucrm_plan_service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_plan_services_on_name", unique: true
    t.index ["ucrm_plan_service_id"], name: "index_plan_services_on_ucrm_plan_service_id", unique: true
  end

  create_table "producers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "product_number"
    t.string "name"
    t.string "description"
    t.boolean "ac"
    t.string "power_in"
    t.string "power_out"
    t.string "poe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "producer_id"
    t.string "dbi"
    t.bigint "category_id"
    t.bigint "family_id"
    t.bigint "product_type_id"
    t.integer "stock_min_default"
    t.integer "reorder_point_default"
    t.string "unit"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["family_id"], name: "index_products_on_family_id"
    t.index ["producer_id"], name: "index_products_on_producer_id"
    t.index ["product_type_id"], name: "index_products_on_product_type_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_name"
    t.string "email"
    t.string "website"
    t.string "tax_category_number"
    t.string "identification_number"
    t.boolean "withholdingstatus", default: false
    t.bigint "tax_category_id"
    t.index ["tax_category_id"], name: "index_providers_on_tax_category_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.integer "country_id"
    t.string "name"
    t.integer "contabilium_id"
    t.integer "ucrm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "stock_min"
    t.integer "reorder_point"
    t.bigint "deposit_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deposit_id"], name: "index_stocks_on_deposit_id"
    t.index ["product_id"], name: "index_stocks_on_product_id"
  end

  create_table "support_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_support_types_on_name", unique: true
  end

  create_table "surge_protector_setup_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_surge_protector_setup_types_on_name", unique: true
  end

  create_table "system_configurations", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "development_value", default: "", null: false
    t.string "production_value", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_system_configurations_on_name", unique: true
  end

  create_table "tax_categories", force: :cascade do |t|
    t.string "name"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "technical_service_corporate_cellphones", force: :cascade do |t|
    t.integer "technical_service_id", null: false
    t.integer "corporate_cellphone_id", null: false
    t.index ["technical_service_id", "corporate_cellphone_id"], name: "technical_service_corporate_cellphone_unique", unique: true
  end

  create_table "technical_service_technicians", force: :cascade do |t|
    t.integer "technical_service_id", null: false
    t.integer "technician_id", null: false
    t.index ["technical_service_id", "technician_id"], name: "technical_service_technician_unique", unique: true
  end

  create_table "technical_service_work_types", force: :cascade do |t|
    t.integer "technical_service_id", null: false
    t.integer "work_type_id", null: false
    t.index ["technical_service_id", "work_type_id"], name: "technical_service_work_type_unique", unique: true
  end

  create_table "technical_services", force: :cascade do |t|
    t.integer "work_order_number", default: 0, null: false
    t.string "router_model"
    t.string "router_serial_number"
    t.string "wifi_ssid"
    t.string "wifi_password"
    t.decimal "cable_length", precision: 15, scale: 2, default: "0.0", null: false
    t.integer "plug_adapter_quantity", default: 0, null: false
    t.time "arrival_time"
    t.time "departure_time"
    t.string "google_maps_url"
    t.decimal "labour_cost", precision: 15, scale: 2, default: "0.0", null: false
    t.decimal "equipment_cost", precision: 15, scale: 2, default: "0.0", null: false
    t.string "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "city_id"
    t.integer "client_id"
    t.integer "tower_id"
    t.integer "transmitter_id"
    t.integer "balancer_id"
    t.integer "support_type_id"
    t.integer "plan_service_id"
    t.integer "ground_wire_setup_type_id"
    t.integer "surge_protector_setup_type_id"
    t.datetime "datetime", null: false
    t.integer "device_id"
    t.decimal "total_cost", precision: 15, scale: 2, default: "0.0", null: false
    t.integer "billing_export_id"
    t.integer "invoice_item_id"
    t.integer "invoice_id"
    t.integer "organization_id", default: 1
    t.integer "user_id"
  end

  create_table "technicians", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firstname", default: "", null: false
    t.string "lastname", default: "", null: false
    t.boolean "active", default: true, null: false
    t.index ["firstname", "lastname"], name: "index_technicians_on_firstname_and_lastname", unique: true
  end

  create_table "telephone_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "towers", force: :cascade do |t|
    t.string "name", null: false
    t.integer "ucrm_site_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "contact_info"
    t.text "notes"
    t.decimal "gps_lat", precision: 15, scale: 12, default: "0.0", null: false
    t.decimal "gps_lon", precision: 15, scale: 12, default: "0.0", null: false
    t.index ["name"], name: "index_towers_on_name", unique: true
    t.index ["ucrm_site_id"], name: "index_towers_on_ucrm_site_id", unique: true
  end

  create_table "transmitters", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_transmitters_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.integer "group_id"
    t.integer "technician_id"
    t.string "firstname", default: "", null: false
    t.string "lastname", default: "", null: false
    t.string "username", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "voucher_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "withholding_taxes", force: :cascade do |t|
    t.string "withholding"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "withholdings", force: :cascade do |t|
    t.bigint "provider_id"
    t.bigint "withholding_tax_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider_id"], name: "index_withholdings_on_provider_id"
    t.index ["withholding_tax_id"], name: "index_withholdings_on_withholding_tax_id"
  end

  create_table "work_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_work_types_on_name", unique: true
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "countries"
  add_foreign_key "addresses", "providers"
  add_foreign_key "addresses", "provinces"
  add_foreign_key "contacts", "providers"
  add_foreign_key "contacts", "telephone_types"
  add_foreign_key "deposits", "cities"
  add_foreign_key "deposits", "countries"
  add_foreign_key "deposits", "deposit_types"
  add_foreign_key "deposits", "provinces"
  add_foreign_key "families", "producers"
  add_foreign_key "inventories", "deposits"
  add_foreign_key "inventories", "products"
  add_foreign_key "inventories", "providers"
  add_foreign_key "move_details", "deposits", column: "site_from_id"
  add_foreign_key "move_details", "deposits", column: "site_to_id"
  add_foreign_key "move_details", "inventories"
  add_foreign_key "move_details", "moves"
  add_foreign_key "moves", "users", column: "user_register_id"
  add_foreign_key "moves", "users", column: "user_take_id"
  add_foreign_key "moves", "voucher_types"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "families"
  add_foreign_key "products", "producers"
  add_foreign_key "products", "product_types"
  add_foreign_key "providers", "tax_categories"
  add_foreign_key "stocks", "deposits"
  add_foreign_key "stocks", "products"
  add_foreign_key "withholdings", "providers"
  add_foreign_key "withholdings", "withholding_taxes"
end
