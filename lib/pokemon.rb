class Pokemon

  attr_reader :id
  attr_accessor :name, :type, :db

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @type = hash[:type]
    @db = hash[:db]
  end

  def self.save(given_name, given_type, db)
    sql_string = <<-SQL
		  INSERT INTO pokemon (name, type)
		  VALUES (?, ?)
		SQL
		db.execute(sql_string, given_name, given_type)
  end

  def self.find(index_number, given_db)
    sql_string = <<-SQL
      SELECT *
      FROM pokemon
      WHERE pokemon.id = ?
    SQL
    found_pokemon_array = given_db.execute(sql_string, index_number)
    make_to_hash = {id: index_number, name: found_pokemon_array[0][1], type: found_pokemon_array[0][2], db: given_db}
    Pokemon.new(make_to_hash)
  end

end
