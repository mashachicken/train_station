require 'pry'
class Train
  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end
  # overreide the equal operator so that when we compare the 2 objects w the same attributes it is equal
  def ==(other)
    self.class.eql?(other.class) & self.name.eql?(other.name)
  end
  # takes all train names and ids from a database and saves them all in a variable, then pushing it into an array and returning it
  def self.all
    database_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    database_trains.each() do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end
  # takes a name from a query and inserts it into a trains table, passing in a new id that has been assigned by the database
  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
  # clear the result from a database (used for tests)
  def self.clear
    DB.exec("DELETE FROM trains *;")
  end
  # looks for a train by the user inputted ID. Only returns the first resut. Then grabs the name and an id attrb of that result. Then make a new Train obj with those method returns as parameters
  def self.find(id)
    train= DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    name = train.fetch("name")
    id = train.fetch("id").to_i
    Train.new({:name => name, :id => id})
  end
  # Match the name in a database to the name in our app
  def update(name)
    @name = name
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
  end
  # Deletes a train from a database by an ID
  def delete
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
    DB.exec("DELETE FROM citties WHERE train_id = #{@id};")
  end
  def citties
  Citty.find_by_train(self.id, self.name)
end

end
