class Citty
  attr_reader :id
  attr_accessor :name, :train_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @train_id = attributes.fetch(:train_id)
    @id = attributes.fetch(:id)
  end
  def ==(citty_to_compare)
    if citty_to_compare != nil
      (self.name() == citty_to_compare.name()) && (self.train_id() == citty_to_compare.train_id())
    else
      false
    end
  end
  def self.all
    returned_citties = DB.exec("SELECT * FROM citties;")
    citties = []
    returned_citties.each() do |citty|
      name = citty.fetch("name")
      train_id = citty.fetch("train_id").to_i
      id = citty.fetch("id").to_i
      citties.push(Citty.new({:name => name, :train_id => train_id, :id => id}))
    end
    citties
  end
  def save
    result = DB.exec("INSERT INTO citties (name, train_id) VALUES ('#{@name}', #{@train_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
  def self.find(id)
    citty = DB.exec("SELECT * FROM citties WHERE id = #{id};").first
    if citty
      name = citty.fetch("name")
      train_id = citty.fetch("train_id").to_i
      id = citty.fetch("id").to_i
      Citty.new({:name => name, :train_id => train_id, :id => id})
    else
      nil
    end
  end
  def update(name, train_id)
    @name = name
    @train_id = train_id
    DB.exec("UPDATE citties SET name = '#{@name}', train_id = #{@train_id} WHERE id = #{@id};")
  end
  def delete
    DB.exec("DELETE FROM citties WHERE id = #{@id};")
  end
  def self.clear
    DB.exec("DELETE FROM citties *;")
  end
  def self.find_by_train(trn_id)
  citties = []
  returned_citties = DB.exec("SELECT * FROM citties WHERE train_id = #{trn_id};")
  returned_citties.each() do |citty|
    name = citty.fetch("name")
    id = citty.fetch("id").to_i
    citties.push(Citty.new({:name => name, :train_id => trn_id, :id => id}))
  end
  citties
end
def train
  Train.find(@train_id)
end
end
