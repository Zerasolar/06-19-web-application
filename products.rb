# Here we got the products class we made a table for. The methods here we add, change and list again. Nothing too hard.
require_relative "database_class_methods.rb"
class Product
  extend DatabaseClassMethods
  attr_reader :id
  attr_accessor :type
  # Initializes a new product object
  #
  # id (optional) - Integer Primary key in the 'products' table.
  # type (optional) - String of the type of 'goods' items in the 'products' table.
  #
  # Returns a Product object.
  def initialize(product_options={})
    @id = product_options["id"]
    @type = product_options["type"]
  end
  # Method to find a product based on its ID.
  #
  # id - The Integer ID of the product table to return.
  #
  # Returns a Product object.
  
  # Updates the database with all the values for the products table.
  #
  # Returns an empty Array.
  
  # Get all the products records from the database.
  #
  # Returns an Array containing Product objects.

  # This method adds to the table
  #
  # Returns hash of product row

  # This method deletes one product row from the table
  #
  # Returns Nil

  # Deletes the entire products table
  #
  # Returns blank Array

end
