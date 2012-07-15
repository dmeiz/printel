require "printel/version"
require 'rails_erd/diagram'
require 'sequel'
require 'sqlite3'

DB = Sequel.connect('sqlite://printel.db')

class PrintelDiagram < RailsERD::Diagram
  each_relationship do |relationship|
    puts relationship.source
    puts relationship.cardinality.name
    puts relationship.destination
  end
end 

module Printel
  class Model < Sequel::Model
  end
end
