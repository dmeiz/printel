require 'sequel'

class Printel < Thor
  DB = Sequel.connect('sqlite://sample/printel.db')

  desc 'db_reset', 'Create and migrate the database'
  def db_reset
    FileUtils.rm_f('sample/printel.db')

    DB.create_table(:models) do
      Integer :id
      String :name
    end

    DB.create_table(:relationships) do
      Integer :id
      Integer :model_id
      String :type
    end

    DB.create_table(:drawings) do
      Integer :id
      String :name
    end

    DB.create_table(:model_widgets) do
      Integer :id
      Integer :drawing_id
      Integer :model_id
      Integer :x
      Integer :y
    end
  end
end
