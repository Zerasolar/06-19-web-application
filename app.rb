#Need to run pry to test the driver and sinatra to connect it for the web.
require "pry"
require "sinatra"
require "sinatra/reloader"
#Empowering it with SQLite
require "sqlite3"

DATABASE ||= SQLite3::Database.new("rightstuf.db")

DATABASE.execute("CREATE TABLE IF NOT EXISTS goods (id INTEGER PRIMARY KEY, serial_number STRING, distributor_id INTEGER, product_id INTEGER, name STRING, description STRING, cost REAL,
quantity INTEGER);")
 
DATABASE.execute("CREATE TABLE IF NOT EXISTS distributors (id INTEGER PRIMARY KEY, company STRING);")
 
DATABASE.execute("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, type STRING);")
 
DATABASE.results_as_hash = true

#_______________________________________________________________________________________

require_relative "goods.rb"
require_relative "distributors.rb"
require_relative "products.rb"


# ##################################BEGIN WEB UX #######################################

#______________________________________________________________________________________
# Menu
#--------------------------------------------------------------------------------------

get "/home" do
  erb :"mainmenu"
end

# Add a good

get "/add_good" do
  erb :"add_good_form"
end

get "/list_good" do
  erb :"list_good"
end

get "/save_good" do
  dist = Distributor.new(params["company"])
  prod = Product.new(params["type"])
  @new_good = Good.add({"serial_number" => params["serial_number"], "distributor_id" => params["distributor_id"].to_i, "product_id" => params["product_id"].to_i, "name" => params["name"], "description" => params["description"], "cost" => params["cost"].to_f, "quantity" => params["quantity"].to_i})
  
  erb :"added"
end

# get "/change_good" do
#   erb :"good"
# end
#
# get "/serial_number" do
#   erb :"serial_number"
# end
#
# get"/change_serial_number_form/:x" do
#   erb :"change_serial_number_form"
# end
#
# get"/change_serial_number" do
#
#   good = Good.find(params["x"].to_i)
#   good.serial_number = params["serial_number"]
#   good.save
#   erb :"changed"
# end
get "/good_to_change" do
  erb :"change_good"
end

get "/change_good_form/:x" do
  @good_instance = Good.find(params["x"])
  erb :"good"
end

get "/edit_save" do
  @good_instance = Good.find(params["id"])
  if !params["serial_number"].empty?
    @good_instant.serial_number = params["serial_number"]
  end
  if !params["distributor_id"].empty?
    @good_instant.distributor_id = params["distributor_id"].to_i
  end
  if !params["product_id"].empty?
    @good_instant.product_id = params["product_id"].to_i
  end
  if !params["name"].empty?
    @good_instant.name = params["name"]
  end
  if !params["descriptioin"].empty?
    @good_instant.description = params["description"]
  end
  if !params["cost"].empty?
    @good_instant.cost = params["cost"].to_f
  end
  if !params["quantity"].empty?
    @good_instant.quantity = params["quantity"].to_i
  end
  @good_instant.save
  erb :"changed"
  
end

# get "/dist_id" do
#   erb :"dist_id"
# end
#
# get"/change_dist_id_form/:x" do
#   erb :"change_dist_id_form"
# end
#
# get"/change_dist_id" do
#
#   good = Good.find(params["x"].to_i)
#   good.distributor_id = params["distributor_id"]
#   good.save
#   erb :"changed"
# end
#
# get "/prod_id" do
#   erb :"prod_id"
# end
#
# get"/change_prod_id_form/:x" do
#   erb :"change_dist_id_form"
# end
#
# get"/change_prod_id" do
#
#   good = Good.find(params["x"].to_i)
#   good.product_id = params["product_id"]
#   good.save
#   erb :"changed"
# end
#
# get "/name" do
#   erb :"name"
# end
#
# get"/change_name_form/:x" do
#   erb :"change_name_form"
# end
#
# get"/change_name" do
#
#   good = Good.find(params["x"].to_i)
#   good.name = params["name"]
#   good.save
#   erb :"changed"
# end
#
# get "/description" do
#   erb :"description"
# end
#
# get"/change_description_form/:x" do
#   erb :"change_description_form"
# end
#
# get"/change_description" do
#
#   good = Good.find(params["x"].to_i)
#   good.description = params["description"]
#   good.save
#   erb :"changed"
# end
#
# get "/cost" do
#   erb :"dist_id"
# end
#
# get"/change_cost_form/:x" do
#   erb :"change_cost_form"
# end
#
# get"/change_cost" do
#
#   good = Good.find(params["x"].to_i)
#   good.cost = params["cost"]
#   good.save
#   erb :"changed"
# end
#
# get "/quantity" do
#   erb :"quantity"
# end
#
# get"/change_quantity_form/:x" do
#   erb :"change_quantity_form"
# end
#
# get"/change_quantity" do
#
#   good = Good.find(params["x"].to_i)
#   good.quantity = params["quantity"]
#   good.save
#   erb :"changed"
# end

get "/delete" do
  erb :"delete_menu"
end

get"/del_good" do
  erb :"del_good"
end

get"/gone_good" do
  params["good"].each do |good|
    Good.delete_row(good)
  end
  erb :"gone"
end

get"/del_dist" do
  erb :"del_dist"
end

get"/gone_dist" do
  params["dist"].each do |dist|
    Distributor.delete_row(dist)
  end
  erb :"gone"
end

get"/del_prod" do
  erb :"del_prod"
end

get"/gone_prod" do
  params["prod"].each do |prod|
    Product.delete_row(prod)
  end
  erb :"gone"
end

get "/dist_menu" do
  erb :"dist_menu"
end
get "/list_dist" do
  erb :"list_dist"
end

get "/add_dist" do
  erb :"add_dist_form"
end

get "/save_dist" do
  @new_dist = Distributor.add({"company" => params["company"]})
  erb :"added"
end

get "/change_dist" do
  erb :"company"
end

get"/change_company_form/:x" do
  erb :"change_company_form"
end

get"/change_company" do

  dist = Distributor.find(params["x"].to_i)
  dist.company = params["company"]
  dist.save
  erb :"changed"
end

get "/prod_menu" do
  erb :"prod_menu"
end

get "/list_prod" do
  erb :"list_prod"
end

get "/add_prod" do
  erb :add_prod_form
end

get "/save_prod" do
  @new_prod = Product.add({"type" => params["type"]})
  erb :added
end

get "/change_prod" do
  erb :"type"
end

get"/change_type_form/:x" do
  erb :"change_type_form"
end

get"/change_type" do

  prod = Product.find(params["x"].to_i)
  prod.type = params["type"]
  prod.save
  erb :"changed"
end