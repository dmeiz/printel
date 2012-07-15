  # As an example, a diagram class that generates code that can be used with
  # yUML (http://yuml.me) can be as simple as:
  #
  #   require "rails_erd/diagram"
  #
  #   class YumlDiagram < RailsERD::Diagram
  #     setup { @edges = [] }
  #
  #     each_relationship do |relationship|
  #       return if relationship.indirect?
  #
  #       arrow = case
  #       when relationship.one_to_one?   then "1-1>"
  #       when relationship.one_to_many?  then "1-*>"
  #       when relationship.many_to_many? then "*-*>"
  #       end
  #
  #       @edges << "[#{relationship.source}] #{arrow} [#{relationship.destination}]"
  #     end
  #
  #     save { @edges * "\n" }
  #   end
  #
  # Then, to generate the diagram (example based on the domain model of Gemcutter):
  #
  #   YumlDiagram.create
  #   #=> "[Rubygem] 1-*> [Ownership]
  #   #    [Rubygem] 1-*> [Subscription]
  #   #    [Rubygem] 1-*> [Version]
  #   #    [Rubygem] 1-1> [Linkset]
  #   #    [Rubygem] 1-*> [Dependency]
  #   #    [Version] 1-*> [Dependency]
  #   #    [User] 1-*> [Ownership]
  #   #    [User] 1-*> [Subscription]
  #   #    [User] 1-*> [WebHook]"
require 'rails_erd/diagram'

class PrintelDiagram < RailsERD::Diagram
  each_relationship do |relationship|
    puts relationship.source
    puts relationship.cardinality.name
    puts relationship.destination
  end
end 

desc 'Generate printel data'
task :printel => ['erd:load_models'] do
  PrintelDiagram.create
end
