require "sequel"

Sequel.migration do
  change do
    unless table_exists?(:pokemons)
      create_table :pokemons do
        primary_key :id
        Integer :number
        index :number, unique: true
        String :name
        index :name
        String :description
        Float :hight
        Float :weight
        String :category
        Text :abilities
        Text :gender
        Text :types
        Text :weakness
        Text :stats
        Time :created_at
        Time :updated_at
      end
    end
  end
end
