#work in progess markdown
#Inventory Manager

The project was to build an inventory management system that a shopkeeper might use to keep track of everthing they might keep in their shop. It should be able to create records, edit records, fetch and read records. A long with it it should be to do the same for location and category. I created for this project I created a database with three tables and connected to those tables are 3 classes for each table and a driver app for all the inputs.

## Good Class

We initialize several agruments for a instant method:
- good_id: A Integer Primary Key
- serial_number: a String to keep track of item goods
- distributor_id: A Integer foreign key for the Distributor table
- product_id: A Integer foreign key for the Product table
- name: A String that holds the name for the good
- description: A String that holds the description for the good
- cost: A Integer that holds the cost for the good
- quantity: A Integer that holds the quantity for the good
```ruby
  def initialize(good_id=nil, serial_number=nil, distributor_id=nil, product_id=nil, name=nil, discription=nil, cost=nil, quantity=nil)
    @good_id = good_id
    @serial_number = serial_number
    @distributor_id = distributor_id
    @product_id = product_id
    @name = name
    @description = description
    @cost = cost
    @quantity = quantity
  end
  ```
The next method is to find the item based on this id integer in the table. This method is used in the driver to find the item and be able to change it in the table.
```ruby
  def self.find(good_id)
    @good_id = good_id
    result = DATABASE.execute("SELECT * FROM goods WHERE id = #{@good_id};").first
    temp_serial_number = result["serial_number"]
    temp_distributor_id = result["distributor_id"]
    temp_product_id = result["product_id"]
    temp_name = result["name"]
    temp_description = result["description"]
    temp_cost = result["cost"]
    temp_quantity = result["quantity"]
    
    Good.new(good_id, temp_serial_number, temp_distributor_id, temp_product_id, temp_name, temp_description, temp_cost, temp_quantity)
  end
  ```
Because we are trying to limit how many times to pull from the database we even have a save funcation to save to the actual databased to save the temp data in ruby we create for the database.

```ruby
def self.all
    results = DATABASE.execute('SELECT * FROM goods;')
    
    results_as_objects = []
    
    results.each do |result_hash|
      results_as_objects << Good.new(result_hash["id"], result_hash["serial_number"], result_hash["distributor_id"], result_hash["product_id"], result_hash["name"], result_hash["description"], result_hash["cost"], result_hash["quantity"])
    
    end
    return results_as_objects
  end
  ```
The method here is to add new data for the table in the database. Using the class we create a good object to hold this data.

```ruby
def self.add(serial_number, distributor_id, product_id, name, description, cost, quantity)
    DATABASE.execute("INSERT INTO goods (serial_number, distributor_id, product_id, name, description, cost, quantity) VALUES ('#{serial_number}', #{distributor_id}, #{product_id}, '#{name}', '#{description}', #{cost}, #{quantity});")
    
    good_id = DATABASE.last_insert_row_id
    Good.new(good_id, serial_number, distributor_id, product_id, name, description, cost, quantity)
  end
  ```
The last two methods in the goods class are delete functions. The first one is just a method to be able delete the row in the database by it's ID.
```ruby
def self.delete_good(good_id)
    DATABASE.execute("DELETE FROM goods WHERE id = #{good_id};")
  end
  ```
  The last one is to drop the whole table in the database. Though I need to create a ablitiy to create a new table after it's drop here. Part of the future to do list for this class.
  ```ruby
    def self.delete
    DATABASE.execute("DROP TABLE goods")
  end
  ```

Add info about other classes here

## Driver

Starting off we call to SQLite3 gem and the rightstuf database. From there we create the tables of goods, distributors, and products. Then ask for the reative require classes associated with them.

```ruby

require "sqlite3"
#
# Database holding three tables Goods, Products, and Distributors.
DATABASE ||= SQLite3::Database.new("rightstuf.db")

DATABASE.execute("CREATE TABLE IF NOT EXISTS goods (id INTEGER PRIMARY KEY, serial_number STRING,
distributor_id INTEGER, product_id INTEGER, name STRING, description STRING, cost REAL,
quantity INTEGER);")
 
DATABASE.execute("CREATE TABLE IF NOT EXISTS distributors (id INTEGER PRIMARY KEY, company STRING);")
 
DATABASE.execute("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, type STRING);")
 
DATABASE.results_as_hash = true
 
require_relative "goods.rb"
require_relative "distributors.rb"
require_relative "products.rb"
 ```
The whole menus system is a huge boolean with smaller ones on the inside of it. Breaking it down, we start with the first one that holds the main menu which has the goods table. You can ask for the list of the table, add to the table, change a row value in the table, either go to the distributors table ir products table, delete a row in the table or delete the whole table and last and not least quit out of the program.
From there we have a whole selections of choices to pick. We are going to look at what comes first in the code.
 ```ruby
puts "Choose action: (l)ist goods from database, (a)dd a good, (c)hange a good,
go to d(i)stributors listings, go to p(r)oducts listings, dele(t)e or (q)uit"
answer = gets.chomp
```
Starting this off with the while statement if input answer isn't a q string we will go on to the if statement that does have the string. This while loop keeps the user in the program as long as they want, but it they want to quit out they could.
```ruby
while answer != "q" do
```
First if statement is the delete function. It's in a small while loop for it since you have a choice to either delete a row or delete a table.
```ruby
  if answer == "t"
    puts "Choose action: Delete ro(w), Delete ta(b)le or (q)uit"
    question = gets.chomp
    while question != "q" do
      ```
      If you are deleting the row you'll get a question asked of which row you want to delete. We use the Good class method called "all" called here to pull the whole list which we put down 3 columns from all the rows for the user to see and to select which one to delete. From there the user select the one and that gets deleted from the database.
      ``` ruby
      if question == "w"
        puts "Which one do you want to delete?"
        Good.all.each do |good_hash|
          puts "#{good_hash.good_id} - #{good_hash.serial_number} - #{good_hash.name}"
        end
        
        delete = gets.chomp.to_i
        Good.delete_good(delete)
      end
  ```
  This here we are deleting the whole table. Though we still need to add a function after deleting the table it would recreate a blank new one again. After either funication we bring the user back to the delete menu again.
    ```ruby
      if question == "b"
        Good.delete
      end
      
      puts "Choose action: Delete ro(w), Delete ta(b)le or (q)uit"
      question = gets.chomp
    end
  end
  ```
 Going back to what the main menu. We got the if statement that holds the add to the goods table. Here we ask the user each part of the row the value they want to input into the table. We ask for the serial number, distributor id number, product id number, the name of the good, the description of the book, dvd ect., cost of the item, and the quantity of the items. The at the end we added it to the goods table with the add function from the good class.
  ```ruby
  if answer == "a"
    puts "What is the serial number for the good?"
    serial_num = gets.chomp
     
    puts "What is the distributor id number?"
    dis_id = gets.chomp.to_i
     
    puts "What is the product id number?"
    prod_id = gets.chomp.to_i
     
    puts "What is the name of the product?"
    name = gets.chomp
     
    puts "Description about the series?"
    discription = gets.chomp
     
    puts "Cost of the good item?"
    cost = gets.chomp.to_f
     
    puts "How many do you have in the warehouse"
    quantity = gets.chomp
  
    Good.add(serial_num, dis_id, prod_id, name, discription, cost, quantity)
  end
  ```
  Continue on the options the user could pick. We can list all that is in the goods table right now. Calling on the all method again from the good class we pull all the tables and list each one in a Array with id rows and information they were put in.
  ```ruby
  if answer == "l"
    
    Good.all.each do |list|
      puts "#{list.good_id} - #{list.serial_number} - #{list.distributor_id} - #{list.product_id} - #{list.name} - #{list.description} - #{list.cost} - #{list.quantity}"
    end        
  end
  ````
  Next option is changing one value in one row for the goods table. So what ever column user picked next it would list that all the values in the coulmn for the user to pick the one to change. After picking one the driver pull the input change the field value for that row, but then we have to push it on to the database. With the save funication we get that save into the database. This is exactly the same for all fields in the goods table.
  ```ruby
  if answer == "c"
    puts "Change (s)erial_number, change (d)istributor_id, change (p)roduct_id,
    change (n)ame, change d(e)scription, change (c)ost, change (q)uantity"
    answer = gets.chomp
    
    if answer == "s"
      puts "Choose a good to change it's serial number"
      
      Good.all.each do |good_hash|
        puts "#{good_hash.good_id} - #{good_hash.serial_number} - #{good_hash.name}"
      end
      
      picked_good = gets.chomp.to_i
      
      puts "Okay, What's the new serial number?"
      new_serial_number = gets.chomp
      
      goods = Good.find(picked_good)
      goods.serial_number = new_serial_number
      goods.save
    end
   
    if answer == "d"
      puts "Choose a good to change it's distributor id"
      
      Good.all.each do |good_hash|
        puts "#{good_hash.good_id} - #{good_hash.serial_number} - #{good_hash.distributor_id} - #{good_hash.name}"
      end
      
      picked_good = gets.chomp.to_i
      
      puts "Okay, What's the new distributor id?"
      new_dist_id = gets.chomp
      
      goods = Good.find(picked_good)
      goods.distributor_id = new_dist_id
      goods.save
    end
    
    if answer == "q"
      puts "Choose a good to change it's quantity"
      
      Good.all.each do |good_hash|
        puts "#{good_hash.good_id} - #{good_hash.serial_number} - #{good_hash.name} - #{good_hash.quantity}"
      end
      
      picked_good = gets.chomp.to_i
      
      puts "Okay, What's the new quantity?"
      new_quantity = gets.chomp
      
      goods = Good.find(picked_good)
      goods.quantity = new_quantity
      goods.save
    end
  end
  ```
  Next if statement is brings up the options for the distributors for the distributors table. It has the same options as the main menu. So the user can see the list of distributors from the database, add a new distributor, change a distributor or delete either the row or the table and last is to quit which quits out of the menu and bring the user back to the main menu.
  
  ```ruby
  if answer == "i"
    puts "Choose action: (l)ist distributors from database, (a)dd a distributor,
    (c)hange a distributor, dele(t)e or (q)uit"
    input = gets.chomp
    while input != "q" do
```

      if input == "t"
        puts "Choose action: Delete ro(w), Delete ta(b)le or (q)uit"
        question = gets.chomp
        while question != "q" do

          if question == "w"
            puts "Which one do you want to delete?"
            Distributor.all.each do |dist_hash|
              puts "#{dist_hash.dist_id} - #{dist_hash.company}"
            end

            delete = gets.chomp.to_i
            Distributor.delete_distributor(delete)
          end

          if question == "b"
            Distributor.delete
          end
          
          puts "Choose action: Delete ro(w), Delete ta(b)le or (q)uit"
          question = gets.chomp
        end
      end
         
      if input == "l"

        Distributor.all.each do |dist|
          puts "#{dist.dist_id} - #{dist.company}"
        end        
      end

      if input == "a"
        puts "What is the distributor you want to add?"
        company_list = gets.chomp
    
        Distributor.add(company_list)
      end

      if input == "c"
        puts "Choose a company you want to change"

        Distributor.all.each do |dis_hash|
          puts "#{dis_hash.dist_id} - #{dis_hash.company}"
        end
      
        picked_company = gets.chomp.to_i
      
        puts "Okay, What's the new company?"
        new_company = gets.chomp
        dis = Distributor.find(picked_company)
        dis.company = new_company
        dis.save
      end
      puts "Choose action: (l)ist distributors from database, (a)dd a distributor,
      (c)hange a distributor, dele(t)e or (q)uit"
      input = gets.chomp
    end
  end
  
  if answer == "r"
    puts "Choose action: (l)ist products from database, (a)dd a product,
    (c)hange a product, dele(t)e or (q)uit"
    pick = gets.chomp
    while pick != "q" do

      if pick == "t"
        puts "Choose action: Delete ro(w), Delete ta(b)le or (q)uit"
        question = gets.chomp
        while question != "q" do
      
          if question == "w"
            puts "Which one do you want to delete?"
            Product.all.each do |prod_hash|
              puts "#{prod_hash.prod_id} - #{prod_hash.type}"
            end

            delete = gets.chomp.to_i
            Product.delete_product(delete)
          end
          
          if question == "b"
            Product.delete
          end
          
          puts "Choose action: Delete ro(w), Delete ta(b)le or (q)uit"
          question = gets.chomp
        end
      end

      if pick == "l"
        Product.all.each do |products|
          puts "#{products.prod_id} - #{products.type}"
        end        
      end

      if pick == "a"
        puts "What is the type you want to add?"
        type = gets.chomp
    
        Product.add(type)
      end

      if pick == "c"
        puts "Choose a type you want to change"
        
        Product.all.each do |product_hash|
          puts "#{product_hash.prod_id} - #{product_hash.type}"
        end
      
        picked_type = gets.chomp.to_i
      
        puts "Okay, What's the new type?"
        new_type = gets.chomp
      
        product = Product.find(picked_type)
        product.type = new_type
        product.save
      end
      puts "Choose action: (l)ist products from database, (a)dd a product,
      (c)hange a product, dele(t)e or (q)uit"
      pick = gets.chomp 
    end
  end

  puts "Choose action: (l)ist goods from database, (a)dd a good, (c)hange a good,
  go to d(i)stributors listings, go to p(r)oducts listings,  dele(t)e or (q)uit"
  answer = gets.chomp
end