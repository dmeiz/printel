require 'sequel'

class Printel < Thor
  DB = Sequel.connect('sqlite://sample/printel.db')

  desc 'db_reset', 'Create and migrate the database'
  def db_reset
    FileUtils.rm_f('sample/printel.db')

    DB.create_table(:models) do
      primary_key :id
      String :name
    end

    DB.create_table(:relationships) do
      primary_key :id
      Integer :source_id
      Integer :destination_id
      String :type
    end

    DB.create_table(:drawings) do
      primary_key :id
      String :name
    end

    DB.create_table(:model_widgets) do
      primary_key :id
      Integer :drawing_id
      Integer :model_id
      Integer :x
      Integer :y
    end
  end
end
