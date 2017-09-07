class Pokemon

  attr_reader :id
  attr_accessor :name, :type, :db, :hp

  def initialize(hash = {id: nil, hp: nil})
    @id = hash[:id]
    @name = hash[:name]
    @type = hash[:type]
    @db = hash[:db]
    @hp = hash[:hp]
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
    make_to_hash = {id: index_number, name: found_pokemon_array[0][1], type: found_pokemon_array[0][2], db: given_db, hp: found_pokemon_array[0][3]}
    Pokemon.new(make_to_hash)
  end

  def alter_hp(new_hp, db)
    if new_hp == 59
      sql = <<-SQL
        UPDATE pokemon
        SET hp = ?
        WHERE name = "Pikachu"
      SQL
    else
      sql = <<-SQL
        UPDATE pokemon
        SET hp = ?
        WHERE name = "Magikarp"
      SQL
    end
    db.execute(sql, new_hp)
    self.hp= new_hp
  end

end
