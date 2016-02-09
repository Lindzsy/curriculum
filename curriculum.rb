# - Maybe add ::
#   - More git
#   - [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/how-to-os-x.md][How to OSX]]
#   - [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/nix.md][Intro to Unix]]

#   - [[http://computers.tutsplus.com/tutorials/navigating-the-terminal-a-gentle-introduction--mac-3855][Navigating the Terminal: A Gentle Introduction]]
#   - Enumerables
#   - [[https://vimeo.com/130811302][Various Games]]
#   - a fun first day to help them see where their skills are going to take them
#     - https://twitter.com/josh_cheek/status/664795920467300352
#     - https://www.govtrack.us/developers/api
#     - https://github.com/phoet/asin
#     - https://www.ruby-toolbox.com/categories/api_clients
#     - https://www.ruby-toolbox.com/categories/visualizing_data
#     - https://www.ruby-toolbox.com/categories/by_name
#     - https://www.libgosu.org/

require 'active_record'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :documents do |t|
    t.string :license
  end

  create_table :topics do |t|
    t.string :topic
  end

  create_table :phase_topics do |t|
    t.integer :phase_id
    t.integer :topic_id
  end

  create_table :week_topics do |t|
    t.integer :week_id
    t.integer :topic_id
  end

  create_table :activity_topics do |t|
    t.integer :activity_id
    t.integer :topic_id
  end

  create_table :phases do |t|
    t.integer :order
    t.string  :title
    t.integer :document_id
  end

  create_table :weeks do |t|
    t.integer :phase_id
    t.integer :number
  end

  create_table :activities do |t|
    t.integer :week_id
    t.string  :name
    t.string  :contents
  end
end

class Document < ActiveRecord::Base
  has_many :phases
end

class Phase < ActiveRecord::Base
  belongs_to :document
  has_many :weeks
  has_many :phase_topics
  has_many :topics, through: :phase_topics
end

class PhaseTopic < ActiveRecord::Base
  belongs_to :phases
  belongs_to :topic
end

class Topic < ActiveRecord::Base
  def self.forall(topics)
    topics.map { |t| self.for t }
  end
  def self.for(topic)
    find_or_create_by! topic: topic
  end
end

class WeekTopic < ActiveRecord::Base
  belongs_to :week
  belongs_to :topic
end

class Week < ActiveRecord::Base
  belongs_to :phase
  has_many :week_topics
  has_many :topics, through: :week_topics
  has_many :activities
end

class ActivityTopic < ActiveRecord::Base
  belongs_to :activity
  belongs_to :topic
end

class Activity < ActiveRecord::Base
  belongs_to :week
  has_many :activity_topics
  has_many :topics, through: :activity_topics
end


document = Document.create! do |document|
  document.license = 'Unless otherwise noted, this curriculum by Josh Cheek is licensed under - [Creative Commons Attribution-NonCommercial-ShareAlike 3.0](http://creativecommons.org/licenses/by-nc-sa/3.0/)'
end

document.phases.create! order: 1, title: "Introduction to programming with Ruby" do |phase|
  phase.topics = Topic.forall ["Environment", "Ruby", "Problem Solving", "Good Habits"]

  phase.weeks.build do |week|
    week.number = 1
    week.topics = Topic.forall ['Editor', 'Ruby', 'Terminal']
    week.activities.build do |activity|
      activity.name     = "Expectations"
      activity.topics   = Topic.forall ["positive behaviour", "collaboration", "grit"]
      activity.contents = '[material](https://github.com/CodePlatoon/curriculum/blob/master/phase1/expectations.md)'
    end
    week.activities.build do |activity|
      activity.name = 'Get to know each other'
    end
    week.activities.build do |activity|
      activity.name = 'Become familiar with editor (What editor do we want to use? Probably Atom or Emacs, might depend on dev env, eg are we doing cloud based?)'
      activity.contents = <<-CONTENTS.strip_heredoc
      * Practice the mechanical skills of, making files, deleting them, editing them
      * Learn first Keybindings
      * Alternate between solving problems using [SiB](https://github.com/JoshCheek/seeing_is_believing) and practicing keybindings / editing
      * Demonstrate that you can perform these tasks
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Initial Setup'
      activity.contents = <<-CONTENTS.strip_heredoc
      Some stuff from my [setup instructions](https://github.com/JoshCheek/1508/blob/master/initial-setup.md) and probably [dotfiles](https://github.com/JoshCheek/dotfiles-for-students)
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Become familiar with the terminal'
      activity.contents = <<-CONTENTS.strip_heredoc
      Be able to perform [these katas](https://github.com/JoshCheek/team_grit/blob/master/cheatsheets_other/shell.md) by the end (mechanical practice)
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Become familiar with the OS (Mac?)'
      activity.contents = 'Practice poweruser keybindings'
    end
    week.activities.build do |activity|
      activity.name = 'Mindset of a learner'
      activity.contents = '[material](https://github.com/CodePlatoon/curriculum/blob/master/phase1/mindset_of_a_learner.md)'
    end
    week.activities.build do |activity|
      activity.name = 'Seeing Is Believing'
      activity.contents = <<-CONTENTS.strip_heredoc
      Introduce our laboratory
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Have them create cheatsheets for the primitives (String, Integer, Array, Hash, booleans)'
      activity.contents = <<-CONTENTS.strip_heredoc
      * [example](https://github.com/JoshCheek/ruby-kickstart/tree/master/cheatsheets)
      * Demonstrate an [ECM](http://orgmode.org/worg/org-faq.html#ecm) eg to show how map works:

        ```ruby
        ['a', 'b'].map { |c| c.upcase }  # => ["A", "B"]
        ```
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Structures for representing nouns'
      activity.contents = 'The JSON data types, across representations'
    end
    week.activities.build do |activity|
      activity.name = 'The power and danger of abstractions'
      activity.contents = '[material](phase1/the_power_and_danger_of_abstractions.md)'
    end
    week.activities.build do |activity|
      activity.name = 'Representing nouns'
      activity.contents = 'How to model data using the JSON data types.'
    end
    week.activities.build do |activity|
      activity.name = 'Exercises'
      activity.contents = <<-CONTENTS.strip_heredoc
      * Create a linked list using
        [toplevel methods and arrays](https://gist.github.com/JoshCheek/e8dfba74a0ec7e9d8400/53a6c7555284c2d3272bf5638f8d8efc78303ff9#file-15_ways_to_make_a_linked_list-rb-L31),
        tests will be provided
      * Create a linked list using
        [toplevel methods and hashes](https://gist.github.com/JoshCheek/e8dfba74a0ec7e9d8400/53a6c7555284c2d3272bf5638f8d8efc78303ff9#file-15_ways_to_make_a_linked_list-rb-L81),
        tests will be provided
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Structure of the Object Model'
      activity.contents = <<-CONTENTS.strip_heredoc
      [Structure of the Object Model](https://github.com/JoshCheek/object-model-hash-style#objects-are-just-linked-lists)

      * Toplevel methods, local variables, callstack, parameters
      * Objects (ivars/class)
      * Classes (superclass/methods/constants)
      CONTENTS
    end
  end

  phase.weeks.build do |week|
    week.number = 2
    week.topics = Topic.forall ['Ruby in context']
    week.activities.build do |activity|
      activity.name = 'Unix'
      activity.topics = Topic.forall ['$PATH', 'input/output streams', 'file permissions', 'executbales']
    end
    week.activities.build do |activity|
      activity.name = 'Ruby'
      activity.topics = Topic.forall ['$stdin', '$stdout', '$stderr', 'ARGV', 'ENV']
    end
    week.activities.build do |activity|
      activity.name = 'Unix'
      activity.topics = Topic.forall ['environment variables', 'pipes', 'redirecting input/output']
    end
    week.activities.build do |activity|
      activity.name = 'Ruby Miniprojects'
      activity.contents = <<-CONTENTS.strip_heredoc
      Create these programs:

      * [wc](https://github.com/JoshCheek/team_grit/blob/master/katas/wc.rb)
      * [echo](https://github.com/JoshCheek/team_grit/blob/master/katas/echo.rb)
      * [cat](https://github.com/JoshCheek/team_grit/blob/master/katas/cat.rb)
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Ruby ecosystem'
      activity.topics = Topic.forall ['Namespacing', 'multiple files in Ruby (load path)', 'naming conventions across files and classes']
    end
    week.activities.build do |activity|
      activity.name = 'Pry'
      activity.contents = <<-CONTENTS.strip_heredoc
      [Pry](https://github.com/turingschool/curriculum/blob/master/source/topics/debugging/debugging.markdown#pry)

      * Show how to add it to an existing program
      * Practice imporant commands (whereami, show-source, ls, cd)
      * Recognize that the shell / editor keybindings work here as well
      * Create [pwd](https://github.com/JoshCheek/team_grit/blob/master/katas/pwd.rb)
        by exploring in pry (no looking up docs, we have to make guesses and check them to see if they
      * Use pry to explore objects based on what we predict from the object model
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Exploring gems using pry'
      activity.contents = <<-CONTENTS.strip_heredoc
      Go through [Discovery With Pry](https://vimeo.com/151341394),
      along with me, where we figure out the FFaker gem by looking around in pry.
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Nokogiri Challenge'
      activity.contents = 'https://github.com/turingschool/challenges/blob/master/parsing_html.markdown'
    end
    week.activities.build do |activity|
      activity.name = 'Git fundamentals'
      activity.contents = <<-CONTENTS.strip_heredoc
      * The basic model to use when thinking
      * My cardinal rule of git: "run git status after everything you do"
      * Practice the commit workflow (I've got it written down somewhere, will have to find it)
      * "Get over yourself" aka commit constantly
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Ruby exercieses'
      activity.contents = <<-CONTENTS.strip_heredoc
      Various [ruby exercises](https://github.com/turingschool/ruby-exercises) (probably objects and methods)

      * To practice modeling domains using objects
      * To practice using git to commit
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Maybe refactoring exercises'
      activity.contents = <<-CONTENTS.strip_heredoc
      Probably this materail: [material](https://github.com/JoshCheek/1508/blob/master/katas/blowing_bubbles_part1.rb)
      Here is a video of me doing it: [https://vimeo.com/137837006](https://vimeo.com/137837006).
      CONTENTS
    end
  end

  phase.weeks.build do |week|
    week.number = 3
    week.topics = Topic.forall ['Testing and More objects']
    week.activities.build do |activity|
      activity.name = 'Mechanics of testing'
      activity.topics = Topic.forall ['testing']
      activity.contents = <<-CONTENTS.strip_heredoc
      [Mechanics of testing](https://github.com/JoshCheek/how-to-test) (the hard skills)

      * TODO: Do we want to use minitest or RSpec, or don't care?
      * Have them demonstrate they can repeat all the hard skills
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'How to explore'
      activity.topics = Topic.forall ['explore', 'pry', 'testing']
      activity.contents = <<-CONTENTS.strip_heredoc
      Exploring with pry (to see how feedback is useful, and build intuition)
      We'll use pry to go in and figure out how minitest runs our tests
      (if we use RSpec instead, then it's probably not worth it,
      b/c RSpec is much larger and more sophisticated, not ripe for entry level discovery)
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Starting a project'
      activity.topics = Topic.forall ['project management', 'bdd']
      activity.contents = 'Discuss how to start a project [bdd](https://gist.github.com/JoshCheek/37e4cf3bea6541023bab)'
    end
    week.activities.build do |activity|
      activity.name = 'Mindset of testing'
      activity.topics = Topic.forall ['testing', 'tdd']
      activity.contents = <<-CONTENTS.strip_heredoc
      Show how this manifests in the [mindset of testing](https://github.com/JoshCheek/how-to-test#watch-me-build-a-calculator-in-this-way) (the soft skills)

      * How to think about testing
      * What tests to write
      * Watch me do it
      * Students repeat it
      * Demonstrate they can mimic my process and thought patterns
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Mechanics of testing'
      activity.topics = Topic.forall ['testing', 'exercise', 'git']
      activity.contents = 'Use testing and git on a linked list that uses toplevel methods and objects'
    end
    week.activities.build do |activity|
      activity.name = 'Mechanics of testing'
      activity.topics = Topic.forall ['testing', 'refactoring']
      activity.contents = <<-CONTENTS.strip_heredoc
      Use testing and git on a linked list where the behaviour is moved into the objects

      * This will likely lead to test pain because each test probably uses the
        interface directly. So we'll get to talk about tdd (in this case,
        refactor the tests to introduce abstractions, then move the methods 1 at a time)
      * Maybe have them set it aside and go through more
        [refactoring exercises](https://github.com/JoshCheek/1508/blob/master/katas/blowing_bubbles_part2.rb)
        (video of me doing it https://vimeo.com/137837005)
      * Maybe them do both iterative solutions and recursive solutions,
        pushing the logic down into the node.
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Object Model: singleton classes'
      activity.topics = Topic.forall ['object model', 'singleton classes']
    end
    week.activities.build do |activity|
      activity.name = 'HTTP Parser'
      activity.topics = Topic.forall ['testing', 'project']
      activity.contents = <<-CONTENTS.strip_heredoc
      [HTTP Parser](https://github.com/JoshCheek/programming_is_fun/blob/master/spec/request_spec.rb)
      (uses streams, strings, testing, and we can define the interface as `ParseHttp.call`
      which will use singleton classes, and starts prepping them for the web)
      CONTENTS
    end
  end

  phase.weeks.build do |week|
    week.number = 4
    week.topics = Topic.forall ['How to approach a project']
    week.activities.build do |activity|
      activity.name = 'Practice starting a project'
      activity.topics = Topic.forall ['project management', 'tdd']
      activity.contents = <<-CONTENTS.strip_heredoc
      Practice starting a project the way I do

      * Watch me do Chisel, a markdown parser.
        * [project](http://tutorials.jumpstartlab.com/projects/chisel.html)
        * [video](https://vimeo.com/131588133)
      * They attempt to mimic my approach
      * Watch me do chisel again
      * They attempt to mimic my approach again
      * Watch me do chisel again (this time in 20ish minutes)
      * They practice on one they haven't seen me do, [Character Count](https://vimeo.com/139372804)
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Project: Building a gem'
      activity.contents = <<-CONTENTS.strip_heredoc
      Project: [building a gem](https://github.com/turingschool/lesson_plans/tree/master/electives/building-a-gem)
      Uses all the stuff they learned last week + the stuff they learned this week,
      lets us talk about design
      CONTENTS
    end
  end

  phase.weeks.build do |week|
    week.number = 5
    week.topics = Topic.forall ['Modules', 'Blocks']
    week.activities.build do |activity|
      activity.name = 'Blocks'
      activity.topics = Topic.forall ['blocks']
      activity.contents = <<-CONTENTS.strip_heredoc
      * How they work
      * Follow the flow through the program
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Your own #each'
      activity.topics = Topic.forall ['blocks', 'enumerables']
      activity.contents = <<-CONTENTS.strip_heredoc
      Add `each` method to their linked list
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Discovering modules'
      activity.topics = Topic.forall ['object model', 'modules']
      activity.contents = <<-CONTENTS.strip_heredoc
      * Modules as mixins and namespaces
      * Have them infer the structure from their knowledge of the object model
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Enumerable#map'
      activity.topics = Topic.forall ['blocks', 'enumerables']
      activity.contents = 'Create Enumerable#map together'
    end
    week.activities.build do |activity|
      activity.name = 'Project'
      activity.topics = Topic.forall ['blocks', 'enumerables']
      activity.contents = <<-CONTENTS.strip_heredoc
      Project: create some subset of the Enumerable module
      [example](https://vimeo.com/133626457)

      Include it into their linked list so they can see that
      they get the `map` methods and so forth
      CONTENTS
    end
  end

  phase.weeks.build do |week|
    week.number = 6
    week.topics = Topic.forall ['HTTP']
    week.activities.build do |activity|
      activity.name = 'Project: HTTP / web framework / web server'
      activity.topics = Topic.forall ['blocks']
      activity.contents = <<-CONTENTS.strip_heredoc
      * [Webserver project](https://github.com/turingschool/curriculum/blob/master/source/projects/http_yeah_you_know_me.markdown)
      * [My reflections](https://gist.github.com/JoshCheek/9e5bf0ed673ed80ec010)
      * My web framework

      * Build the project in the way we described
      * Refactor to achieve clarity / modularity
      * Refactor to support the Rack interface?
      * Extract the server and framework into gems
      * Add more status code support

      If any of their other work can be given a web interface, lets do that!
      CONTENTS
    end
  end
end


document.phases.create!  order: 2, title: "Internet / Rails" do |phase|
  phase.topics = Topic.forall ['internet', 'rails'] # :P
  # Section2 example:
  # [Database Design & Modeling](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/database_design_modeling.markdown)
  # [Database / Schema design](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/database_schema_design.markdown)
  # [REST](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/rest_routing_and_controllers_in_rails.markdown)
  # [Rails Basics Challenge](https://github.com/turingschool/challenges/blob/master/models_databases_relationships_routes_controllers_oh_my.markdown)
  # [Authorization](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/authorization.markdown)
  # extracting logic from the view/controller/model
  # [Asset Pipeline] (https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/intro_to_the_asset_pipeline.markdown)
  # [Transactions/callbacks/scopes](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/transactions_scopes_callbacks.markdown)
  # [ActiveRecord](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/rails/active_record.md)
  # [ActiveRecord practice](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/rails/active_record_practice.md)
  # [Carrierwave](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/carrierwave.md)
  #   - Sqlite / Postgresql
  #   - Heroku
  #   - [[https://gist.github.com/JoshCheek/cb48fcdd063e45bf5185][quiz topics]]
  #   - N+1 queries and other improvements
  # - Project Ideas::
  #   - Implement sessions
  #   - Implement Authentication
  phase.weeks.build do |week|
    week.number = 7
    # Intro to the web
    #   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/how_the_web_works.markdown][Intro to the web]] Looks like it could be good, so does [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/networking.md][Ada's networking material]]
    #   Has a nice picture:
    #     https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/networking.md
    # HTML / CSS
    #   - DOM / [[http://www.codecademy.com/en/tracks/web][Codecademy's HTML / CSS track]]
    #   - [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/html.md][HTML]]
    # CSS
    #   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/introduction_to_bootstrap.markdown][Intro to bootstrap]]
    week.topics = Topic.forall ['Databases', 'templating languages', 'html']
    week.activities.build do |activity|
      activity.name = 'ActiveRecord without Rails'
      activity.topics = Topic.forall ['Seeing is Believing', 'ActiveRecord', 'db patterns', 'interfaces', 'CRUD', 'validating']
      activity.contents = '[example](https://gist.github.com/JoshCheek/53877049e76f98447249)'
    end
    week.activities.build do |activity|
      activity.name = 'Metaprogramming behind ActiveRecord'
      activity.topics = Topic.forall ['metaprogramming', 'ActiveRecord']
      activity.contents = 'Enough metaprogramming for AR to not be magic'
    end
    week.activities.build do |activity|
      activity.name = 'Erb'
      activity.topics = Topic.forall ['erb']
      activity.contents = 'ERB in plain Ruby'
    end
    week.activities.build do |activity|
      activity.name = 'Project: C is for cookie, and cookie is for me!'
      activity.topics = Topic.forall ['cookies']
      activity.contents = 'Add the ability to get / set cookies to their web framework'
    end
    week.activities.build do |activity|
      activity.name = 'Project: build our own active record'
      activity.topics = Topic.forall ['erb']
      activity.contents = 'Build our own ActiveRecord'
    end
  end

  phase.weeks.build do |week|
    week.number = 8
    week.topics = Topic.forall ['Rails', 'MVC', 'Cookies', 'Sessions', 'ActiveRecord', 'ActiveSupport', 'Migrations']
    week.activities.build do |activity|
      activity.name = 'Intro to Rails'
      activity.topics = Topic.forall ['Rails', 'MVC']
      activity.contents = 'High level (what are the pieces, why are they there, how do they fit together?) They need to be able to define the scaffolded pieces of Rails, by hand by the end of this.'
    end
    week.activities.build do |activity|
      activity.name = 'ActiveRecord in Rails'
      activity.topics = Topic.forall ['ActiveRecord', 'migrations', 'models']
      activity.contents = 'ActiveRecord in Rails migrations, config'
    end
    week.activities.build do |activity|
      activity.name = 'Rails in isolation'
      activity.topics = Topic.forall ['Rails']
      activity.contents = "Various Rails pieces in isolation [[https://github.com/JoshCheek/playgrounds][Example]];\n" +
      "Know how to discover What ActiveSuport gives them\n" +
      "Know how to discover what ViewHelpers give them\n" +
      "Routing\n" +
      "Query Params and forms\n"+ # maybe add this to their framework?
      "Forms\n"
    end
    week.activities.build do |activity|
      activity.name = 'Rails Views Tips and Techniques'
      activity.topics = Topic.forall ['Rails']
      activity.contents = "https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/rails_views_tips_and_techniques.markdown"
    end
    week.activities.build do |activity|
      activity.name = 'Build a single page Rails app that serves a linked list'
      activity.topics = Topic.forall ['Rails']
      activity.contents = "Using the ides from the prev lesson, we just need a nodes resource, where each node has the id of some other node. Then the show page contains a link to that node. They need to pattern match to be able to explain how this is a linked list."
    end
    week.activities.build do |activity|
      activity.name = 'Testing with Capybara'
      activity.topics = Topic.forall ['capybara', 'testing']
      activity.contents = <<-CONTENTS.strip_heredoc
      * [Minimal Testing Example](https://gist.github.com/JoshCheek/f71d7d5d749401733a5e)
      * [Feature Testing](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/feature_testing_rails_minitest_rspec.markdown)
      * [Capybara](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/feature_testing_in_sinatra_with_capybara.markdown)
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Rails project'
      activity.topics = Topic.forall ['Rails', 'MVC', 'Authentication']
      activity.contents = '[Betsy](https://github.com/Ada-Developers-Academy/C3Projects--bEtsy)'
    end
  end

  phase.weeks.build do |week|
    week.number = 9
    week.activities.build do |activity|
      activity.name  = 'Form / Route helpers'
      activity.topics = Topic.forall ['forms', 'routes']
      activity.contents = <<-CONTENTS.strip_heredoc
      [Forms](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/submitting-forms.md)
      [Form and Route helpers](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/forms_and_route_helpers_in_rails.markdown)
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Controller filters'
      activity.topics = Topic.forall ['Controller filters']
      activity.contents = <<-CONTENTS.strip_heredoc
      [Controller Filters][http://guides.rubyonrails.org/action_controller_overview.html#filters
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Validations'
      activity.topics = Topic.forall ['Validations']
      activity.contents = 'Test suite where they have to show they can use the 5 or so most common validations'
    end
    week.activities.build do |activity|
      activity.name = 'Authentication'
      activity.topics = Topic.forall ['Authentication', 'Sessions'] # <-- this is annoying, I don't want to tell them it's sessions, I want to tell them what authentication is, then have them discover sessions!
      activity.contents = <<-CONTENTS.strip_heredoc
        Tell them what authentication is.
        Have them figure out how to use it (eg, like below)
        The conceptual idea for discovering sessions, from my HYYKM notes:
        In the morning tell them "each user\'s hello_count needs to be unique", then the morning class is to guide their exploration until they realize they can do this with cookies. Afternoon is to implement the solution (code to parse and write cookies). Next day\'s class: have them figure out how to tamper with their hello count, then "Don\'t allow your hello count to be tampered with", guide their exploration until they think of encryption. Give them the smallest viable example, now go do it. Later, after they\'ve seen it in Rails, have them extract their session data.

        Then have them add it to their web app
        Use the image from here?:

        These might be relevant:
        * [https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/sessions_cookies_and_flashes.markdown](Sessions / Cookies / Flashes)
        * [https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/rails/session.md)

        Get code samples from here: [Ada's authentication](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/user-authentication.md)
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Authentication'
      activity.topics = Topic.forall ['Authentication', 'Rails']
      activity.contents = <<-CONTENTS.strip_heredoc
      Have them implement authentication in Rails
      [Turing's authentication](https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/authentication.markdown)

      Have them decrypt it from the browser (or put this later to remind them of the topic?)
      [Decrypting a Rails Session](https://gist.github.com/JoshCheek/7b1c1eb231dfa83098be)
      CONTENTS
    end

  end

  phase.weeks.build do |week|
    week.number = 10
    week.topics = Topic.forall ['APIs']

    week.activities.build do |activity|
      # 1 day
      activity.name = 'Consuming an API'
      activity.topics = Topic.forall ['APIs']
      activity.contents = <<-CONTENTS.strip_heredoc
        * [Consuming an API](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/consuming-an-api.md#practice)
        * Add a challenge for each of the APIs at the bottom of this page. eg:
          * Find me titles of books dealing with HTTP
        * What else can you find? (maybe make a mashup of several of these?)
      CONTENTS
    end

    week.activities.build do |activity|
      # 1 day - 1.5
      activity.name = 'Build an HTTP client'
      activity.topics = Topic.forall ['APIs', 'HTTP']
      activity.contents = 'Build Your own HTTP client'
    end

    week.activities.build do |activity|
      activity.name = 'Project: Ant sparring!'
      activity.topics = Topic.forall ['APIs', 'project']
      activity.contents = <<-CONTENTS.strip_heredoc
        * [Ant Sparring](https://github.com/slagyr/ant_sparring)

        * Use your HTTP client to talk to the ant game!
        * Practice separating the game logic from the API so that you can test it and play it w/o the server running
        * Work on designing your app so that you can do all of these things,
          but still have all the functionality available when the server is not runing
        * Prepare for Enova API by practicing against the ant game (assuming their project is similar)
      CONTENTS
    end
  end


  phase.weeks.build do |week|
    week.number = 11
    # Should we add some of this stuff: ?
    # - Late Topics ::
    #   [API examples](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/web-api-101.md)
    #   [Authentication w/ Omniauth](https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/omniauth.md)
    week.topics = Topic.forall ['API', 'OAuth', 'JRuby'] #, maybe sorting algorithms?
    week.activities.build do |activity|
      activity.name = 'API project'
      activity.topics = Topic.forall ['APIs']
      activity.contents = "https://github.com/Ada-Developers-Academy/C3Projects--SeeMore"
    end

    week.activities.build do |activity|
      activity.name = 'Make a sorting video with JRuby!'
      activity.topics = Topic.forall ['JRuby', 'Java', 'sorting', 'algorithms']
      activity.contents = <<-CONTENTS.strip_heredoc
        * Build sorting algorithms, then draw them using JRuby!
        * [Example](https://vimeo.com/channels/sortalgorithms)
        * We could do other fun JRuby things, eg Robot for automation, Swing for GUI apps,
          but this seems like a good one to me b/c it lets us do algorithms at the same
          time, and it lets us reflect on how different algorithms work!
      CONTENTS
    end
  end
end



document.phases.create! order: 3, title: "Frontend and Javascript" do |phase|
  phase.topics = Topic.forall ["Javascript", "Frontend"]

  phase.weeks.build do |week|
    week.number = 12
    week.topics = []
    week.activities.build do |activity|
      activity.name = 'Resources'
      activity.topics = Topic.forall ['javascript', 'documentation']
      activity.contents = <<-CONTENTS.strip_heredoc
       Show them where the MDN docs are.

       * [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
       * [Web](https://developer.mozilla.org/en-US/docs/Web/Reference/API)
       CONTENTS
    end

    week.activities.build do |activity|
      activity.name = 'Getting feedback'
      activity.topics = Topic.forall ['feedback']
      activity.contents = <<-CONTENTS.strip_heredoc
      * Setup node so they can have a REPL
      * Show them a few tricks:
        * functions to strings
        * reflective methods (eg Object.keys)
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Gaining context'
      activity.topics = Topic.forall ['arrays', 'DOM', 'functions']
      activity.contents = <<-CONTENTS.strip_heredoc
      * https://github.com/mdn/advanced-js-fundamentals-ck/tree/1266706b188590da8d682cca046227ae5a307842/tutorials/01-array-prototype-methods
      * Give them some challenges that require them to play with Arrays, Strings, Numbers, Objects, true, false, undefined, null, so that we don't spend a long time covering ideas they are already famiilar with (ie show them their Ruby knowledge translates and begin getting comfortable with JS)
      * Cover Array prototype methods for the same reason, and b/c they're very useful, and it will give them an opportunity to ask any questions from the above.
      * Cover anonymous functions / blocks to
      * priming for JS Object model.
      * Some DOM manipulation (gain context into where / how this is commonly used)
      * Should there be more of an intro to the DOM? (We can play with it from Ruby, possibly build our own model like we've done with other examples)
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'Functional Paradigm'
      activity.topics = Topic.forall ['functional programming']
      activity.contents = <<-CONTENTS.strip_heredoc
      * https://github.com/mdn/advanced-js-fundamentals-ck/tree/gh-pages/tutorials/02-functions
      * This style is common in JS, and in functional languages (and it shows up from time to time in Ruby, too)
      * It's also a gentler introduction, allowing them to be productive without knowing all the ins and outs of the object model.
      * 01-calling-functions.md
        * var vs fn, hoisting, first-class, reference vs invocation, cursory behaviour of `this`
      * 03-what-is-this.md
        * 4 rules of this
        * call and apply (2 interfaces to do the same thing)
        * write your own bind
        * edge case: callbacks (TODO: discuss what a calback is)
      * 02-currying-and-partial-application.md
        * Partial application (have them discover this)
        * Closures and scope
        * Examples / context
      * 04-recursion.md
      * 05-generators.md
        * Async / Generators
        * Understanding generators to better define what async is and where its boundaries are
        * (find that video where they define these constructs -- event queue)
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name = 'JavaScript Challenges'
      activity.topics = Topic.forall ['linked lists', 'jQuery', 'DOM']
      activity.contents = <<-CONTENTS.strip_heredoc
      * redo linked list with toplevel functions + objects
      * Something with jQuery and the DOM to get them playing with it and see something practical they can apply these ideas to. Might be nice to introduce these things first, and then have their challenges be in this context so that as they learn the topics, they can contemplate how they might be used to manipulate the DOM, something they can see the effects of.
      CONTENTS
    end
  end

  phase.weeks.build do |week|
    week.number = 13
    week.topics = Topic.forall ['advanced JS', 'the web']
    week.activities.build do |activity|
      activity.name  = 'Object Oriented JS (mechanics and paradigms)'
      activity.topics = Topic.forall []
      activity.contents = <<-CONTENTS.strip_heredoc
      * https://github.com/mdn/advanced-js-fundamentals-ck/tree/gh-pages/tutorials/03-object-oriented-javascript
      * 01-introduction-to-object-oriented-javascript.md
        * JS Object Model
        * new keyword (have them implement their own?)
        * Constructors
        * `this` in an OO context
        * implicit return of the instance
        * Capitalization is convention
      * 02-building-a-chainable-api.md
        * Common interface patterns (eg jQuery)
        * Contemplating abstraction
      * 03-canvas-and-object-oriented-javascript.md
        * (as a vehicle for talking about OOJS)
        * First see what it looks like procedurally
        * Add the constraint to do this 10x
        * Refactoring to OO
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name  = 'Challenge'
      activity.topics = Topic.forall []
      activity.contents = <<-CONTENTS.strip_heredoc
      * Redo linked list with a constructor / prototype
      * If we wind up introducing other data structures, we can have them swap out which one they do,
        we'll be doing this one frequently enough that we can expand on it and do something more fun like binary search trees.
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name  = 'Events / working with the DOM'
      activity.topics = Topic.forall []
      activity.contents = <<-CONTENTS.strip_heredoc
      * https://github.com/mdn/advanced-js-fundamentals-ck/tree/1266706b188590da8d682cca046227ae5a307842/tutorials/04-events
      * 01-basic-events.md
        * also builtin querying api
        * event listeners
      * 02-event-bubbling.md / 03-adding-and-removing.md / 05-event-delegation.md
        * Maybe have them do the experiment and then define their own set of rules to explain it
        * Patterns for avoiding repetition (eg defining the event listener on the pre-existing elements and also on ones you add later)
      * 04-keycodes.md
        * some exercises to do interesting stuff
      * 06-data-attributes.md
        * "Another thing I thought about for JS that I tried to teach all the time is proper use of DOM selectors for JS behavior.
          Classes and Ids are often used by designers so attaching to them for JS behavior becomes fragile,
          since they may rename or move the classes for style changes.  I always like to use data-ids and then
          communicate that if you see a data-id that means JS is attached there.  Any other part of it -- the HTML or the CSS is still liable to change.
          This also implies to not have your JS be dependent on a specific HTML structure as designers can change that a lot too." -- Ben Voss
        * C style namespacing
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name  = 'Environment'
      activity.topics = Topic.forall []
      activity.contents = <<-CONTENTS.strip_heredoc
      Npm, lodash, (browserify | webpack) -- find a good resource for the basics of these things
      * Not necessary to know all their ins and outs, just enough to support the game time below
      CONTENTS
    end
    week.activities.build do |activity|
      activity.name  = 'Project'
      activity.topics = Topic.forall []
      activity.contents = <<-CONTENTS.strip_heredoc
      * Build their own game
      * https://github.com/turingschool/lesson_plans/blob/master/ruby_04-apis_and_scalability/gametime_project.markdown
      * TODO: Some kind of project where JS is used to add dynamic functionality to a Rails app?
      CONTENTS
    end
  end

  phase.weeks.build do |week|
    week.number = 14
    week.activities.build do |activity|
      activity.name = 'Capstone Project'
      activity.topics = Topic.forall []
      activity.contents = <<-CONTENTS.strip_heredoc
      Objectives

      * Work on a team
      * Practice project management / agile on a larger scale

      Possibilities

      * Something that integrates a Rails backend with Google Maps
      CONTENTS
    end
  end

  phase.weeks.build do |week|
    week.number = 15
    week.activities.build do |activity|
      activity.name = 'Capstone Project'
      activity.topics = Topic.forall []
      activity.contents = 'Continue Capstone project'
    end
  end

  phase.weeks.build do |week|
    week.number = 16
    week.activities.build do |activity|
      activity.name = 'Unallocated'
      activity.topics = Topic.forall ['Leaving this open']
      activity.contents = 'I historically understimate, so it makes sense to shoot for less time rather than perfect time.  Leaving this open to be allocated as appropriate.'
    end
  end
end



puts "Code Platoon - Curriculum"
puts "========================="
puts

document.phases.order(:order).each do |phase|
  puts "Phase #{phase.order} - #{phase.title}\n-----------------\n\n"
  puts
  puts "Topics: #{phase.topics.map(&:topic).join(", ")}"
  puts
  phase.weeks.order(:number).each do |week|
    puts "### Week #{week.number}\n\n"
    puts
    puts "Topics: #{week.topics.map(&:topic).join(", ")}" if week.topics.any?
    puts
    week.activities.each do |activity|
      puts "#### #{activity.name}"
      puts
      puts "Topics: #{activity.topics.map(&:topic).join(", ")}\n" if activity.topics.any?
      puts activity.contents if activity.contents
      puts
    end
  end
end

puts
puts
puts 'License'
puts '-------'
puts document.license
