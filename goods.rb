# Here we got the goods class we made a table for. The methods here we add, change and list again. Nothing too hard
require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"
class Good
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  attr_reader :id
  attr_accessor :serial_number, :distributor_id, :product_id, :name, :description, :cost, :quantity
  # Initializes a new goods object
  #
  # good_options - Hash containing key/values.
  # id (optional) - Integer Primary key in the 'goods' table.
  # serial_number (optional) - String to keep track of item in                                  'goods' table.
  # distributor_id - Integer of the foreign key connected to the 'distributor'
  #                  table in the 'goods' table.
  # product_id - Integer of the foreign key connected to the 'product' table in
  #              the 'goods table.
  # name (optional) - String of the item's name in the 'goods' table.
  # description - String of the item's description in the 'goods' table.
  # cost - Float of the item's cost in the 'goods' table.
  # quantity - Integer of the item's quantity in the 'goods' table.
  #
  # Returns a Good object.
  # def initialize(id=nil, serial_number=nil, distributor_id=nil, product_id=nil, name=nil, discription=nil, cost=nil, quantity=nil)
    def initialize(good_options={})
    @id = good_options["id"]
    @serial_number = good_options["serial_number"]
    @distributor_id = good_options["distributor_id"]
    @product_id = good_options["product_id"]
    @name = good_options["name"]
    @description = good_options["description"]
    @cost = good_options["cost"]
    @quantity = good_options["quantity"]
  end
  # Method to find a good based on its ID.
  #
  # id - The Integer ID of the good table to return.
  #
  # Returns a Good object.
  
  # Updates the database with all the values for the good table.
  #
  # Returns an empty Array.

  # Method to select a row and deletes the row in goods.
  #
  # Returns Nil

  # Method to delete entire goods table.
  #
  # Returns blank Array
end

