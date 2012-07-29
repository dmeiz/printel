require "printel/version"
require 'rails_erd/diagram'
require 'sequel'
require 'sqlite3'
require 'sinatra/base'
require 'sinatra/reloader'
require 'json'
require 'ruby-debug'

DB = Sequel.connect('sqlite:///Users/dhensgen/src/printel/sample/printel.db')

module Printel
  class Model < Sequel::Model
  end

  class Relationship < Sequel::Model
    many_to_one :source, :class => Model
    many_to_one :destination, :class => Model
  end

  class Drawing < Sequel::Model
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
    register Sinatra::Reloader
    enable :sessions

    get '/' do
      @drawings = Drawing.all
      erb :index
    end

    post '/drawings' do
      Drawing.create(:name => params[:name])
      redirect to('/')
    end

    get '/drawings/:id/edit' do
      @models = Model.all
      @drawing = Drawing[params[:id]]
      erb :edit
    end

    post '/drawings/:id' do
      @drawing = Drawing[params[:id]]
#      @drawing.remove_all_model_widgets
#      data = JSON.parse(params[:data])
      @drawing.name = params[:name]
      @drawing.save
      session[:flash] = "Saved #{@drawing.name}"
      redirect to("/drawings/#{@drawing.id}/edit")
    end
  end
end

