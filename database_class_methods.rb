require "active_support"
require "active_support/inflector"

module DatabaseClassMethods
  
  def add(options={})
    column_names = options.keys
    values = options.values
    

    column_names_for_sql = column_names.join(", ")
    individual_values_for_sql = []
    values.each do |value|
      #another way to do it values.to_s.delete("\[\]")
      if value.is_a?(String)
        individual_values_for_sql << "'#{value}'"
      else
        individual_values_for_sql << value
      end
    end
    values_for_sql = individual_values_for_sql.join(", ")
    
        table_name = self.to_s.pluralize.underscore
        
    DATABASE.execute("INSERT INTO #{table_name} (#{column_names_for_sql}) VALUES (#{values_for_sql});")
    
    id = DATABASE.last_insert_row_id
    options["id"] = id
    self.new(options)
  end
  
  def all
    table_name = self.to_s.pluralize.underscore
    results = DATABASE.execute("SELECT * FROM #{table_name}")
    
    results_as_objects = []
    
    results.each do |result_hash|
      results_as_objects << self.new(result_hash)
    end
    return results_as_objects
  end  
  
  def find(id)
    table_name = self.to_s.pluralize.underscore
    results = DATABASE.execute("SELECT * FROM #{table_name} WHERE id = #{id}").first
    self.new(results)
  end
  
  def delete_row(id)
    table_name = self.to_s.pluralize.underscore
    DATABASE.execute("DELETE FROM #{table_name} WHERE id = #{id}")
  end
  
  def delete_table
    table_name = self.to_s.pluralize.underscore
    DATABASE.execute("DROP TABLE #{table_name}")
  end
end