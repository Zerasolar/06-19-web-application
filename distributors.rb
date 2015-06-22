# Here we got the distributors class we made a table for. The methods here we add, change and list again. Nothing too hard. We initialize with the id to be the primary key for the table.
require_relative "database_class_methods.rb"
class Distributor
  extend DatabaseClassMethods
  attr_reader :id
  attr_accessor :company
  # Initializes a new distributor object
  #
  # id (optional) - Integer Primary key in the 'distributor' table.
  # company - (optional) - String of the name of companies in 'distributor'                             table.
  # Returns a Company object.
  def initialize(distributor_options={})
    @id = distributor_options["id"]
    @company = distributor_options["company"]
  end
  # Method to find a company based on its ID.
  #
  # id - The Integer ID of the distributor table to return.
  #
  # Returns a Company object.
  def self.find_object(id)
    result = Distributor.find(id)
    
    temp_company = result["company"]
    
    dist_id = DATABASE.last_instert_row_id
    
    Distributor.new(dist_id, temp_company)
  end
  # Updates the database with all values for the distributors.
  #
  # Returns an empty Array.
  def save
    DATABASE.execute("UPDATE distributors SET company = '#{@company}' WHERE id = #{@id};")
  end
  # Method that gets all the distributors records from the database.
  #
  # Returns an Array containing Company objects.

  # Adds a new company into the database
  #
  # id (optional) - Integer Primary key in the 'distributor' table.
  # company - (optional) - String of the name of companies in 'distributor'                             table.
  # Returns a Company object.

  # This method select the row and deletes the row in distributors
  #
  # Returns Nil
 
  # Deletes entire distributors table
  #
  # Returns blank Array
 
end
