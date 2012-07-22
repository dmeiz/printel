require "printel/version"
require 'rails_erd/diagram'
require 'sequel'
require 'sqlite3'
require 'sinatra/base'

DB = Sequel.connect('sqlite:///Users/dhensgen/src/printel/sample/printel.db')

module Printel
  class Model < Sequel::Model
    set_primary_key :id
  end

  class Relationship < Sequel::Model
    set_primary_key :id
    many_to_one :source, :class => Model
    many_to_one :destination, :class => Model
  end

  class Diagram < RailsERD::Diagram
    each_relationship do |relationship|
      puts relationship.source, relationship.cardinality.name, relationship.destination

      source = Model.find_or_create(:name => relationship.source.name)
      destination = Model.find_or_create(:name => relationship.destination.name)
      Relationship.create(:source => source, :destination => destination, :type => relationship.cardinality.name)
    end
  end 

  class Server < Sinatra::Base
    get '/' do
      'Hello from Printel!'
    end
  end
end

