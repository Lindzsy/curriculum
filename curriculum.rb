require 'active_record'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :topics do |t|
    t.string :topic
  end

  create_table :section_topics do |t|
    t.integer :section_id
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

  create_table :sections do |t|
    t.integer :order
    t.string  :title
  end

  create_table :weeks do |t|
    t.integer :section_id
    t.integer :number
  end

  create_table :activities do |t|
    t.integer :week_id
    t.string  :name
    t.string  :contents
  end
end

class Section < ActiveRecord::Base
  has_many :weeks
  has_many :section_topics
  has_many :topics, through: :section_topics
end

class SectionTopic < ActiveRecord::Base
  belongs_to :section
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
  belongs_to :section
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


Section.create! order: 1, title: "Introduction to programming with Ruby" do |section|
  section.topics = Topic.forall ["Environment", "Ruby", "Problem Solving", "Good Habits"]

  section.weeks.build do |week|
    week.number = 1
    week.topics = Topic.forall ['Editor', 'Ruby', 'Terminal']
    week.activities.build do |activity|
      activity.name   = "Set expectations"
      activity.topics = Topic.forall ["positive behaviour", "collaboration", "grit"]
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
      activity.name = 'Set up the terminal'
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

  section.weeks.build do |week|
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
      Something like [this](https://github.com/JumpstartLab/tdd-class-8-dec/blob/master/12-dec-faker.rb)
      CONTENTS
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

  section.weeks.build do |week|
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

  section.weeks.build do |week|
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

  section.weeks.build do |week|
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

  section.weeks.build do |week|
    week.number = 6
    week.topics = Topic.forall ['HTTP']
    week.activities.build do |activity|
      activity.name = 'Project: HTTP / webserver'
      activity.topics = Topic.forall ['blocks']
      activity.contents = <<-CONTENTS.strip_heredoc
      (or hashes https://github.com/turingschool/data_structures_and_algorithms/tree/master/hash_tables)

      [Webserver project](https://github.com/turingschool/curriculum/blob/master/source/projects/http_yeah_you_know_me.markdown)

      If any of their other work can be given a web interface, lets do that!
      CONTENTS
    end
  end
  
  section.weeks.build do |week|
    week.number = 7
    week.topics = Topic.forall ['Databases', 'templating languages']
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
  end
  
  section.weeks.build do |week|
    week.number = 8
    week.topics = Topic.forall ['Rails']
    week.activities.build do |activity|
      activity.name = 'Intro to Rails'
      activity.topics = Topic.forall ['Rails']
      activity.contents = 'High level (what are the pieces, why are they there, how do they fit together?)'
    end
    week.activities.build do |activity|
      activity.name = 'ActiveRecord in Rails'
      activity.topics = Topic.forall ['ActiveRecord', 'migrations', 'models']
      activity.contents = 'ActiveRecord in Rails (migrations, models)'
    end
    week.activities.build do |activity|
      activity.name = 'Rails in isolation'
      activity.topics = Topic.forall ['Rails']
      activity.contents = 'Various Rails pieces in isolation [[https://github.com/JoshCheek/playgrounds][Example]]'
    end
    week.activities.build do |activity|
      activity.name = 'Rails project'
      activity.topics = Topic.forall ['Rails']
    end
  end
  
  section.weeks.build do |week|
    week.number = 9
    week.topics = Topic.forall ['APIs']
  end

  section.weeks.build do |week|
    week.number = 10
  end
  section.weeks.build do |week|
    week.number = 11
  end
end

# Section.create! order: 1, title: "Introduction to programming with Ruby" do |section|
#   section.topics = Topic.forall ["Environment", "Ruby", "Problem Solving", "Good Habits"]

# Section2 example:
# https://gist.github.com/JoshCheek/a754fce5d1d5e5bb88a6
# ** (2/3) Internet / Rails
# - Early Topics::
#   - DOM / [[http://www.codecademy.com/en/tracks/web][Codecademy's HTML / CSS track]]
#   - [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/submitting-forms.md][Forms]]
#   - MVC
#   - [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/html.md][HTML]]
#   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/how_the_web_works.markdown][Intro to the web]] Looks like it could be good, so does [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/networking.md][Ada's networking material]]
#   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/introduction_to_bootstrap.markdown][Intro to bootstrap]]
#   - [[https://github.com/turingschool/challenges/blob/master/parsing_html.markdown][Nokogiri Challenge]]
#   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/feature_testing_in_sinatra_with_capybara.markdown][Capybara]] / [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/feature_testing_rails_minitest_rspec.markdown][Feature Testing]] / [[https://gist.github.com/JoshCheek/f71d7d5d749401733a5e][Minimal Testing Example]]
#   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/database_design_modeling.markdown][Database Design & Modeling]] / [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/database_schema_design.markdown][Database / Schema design]]
#   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/rest_routing_and_controllers_in_rails.markdown][REST]]
#   - [[https://github.com/turingschool/challenges/blob/master/models_databases_relationships_routes_controllers_oh_my.markdown][Rails Basics Challenge]]
#   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/forms_and_route_helpers_in_rails.markdown][Form and Route helpers]]
#   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/sessions_cookies_and_flashes.markdown][Sessions / Cookies / Flashes]] / [[https://gist.github.com/JoshCheek/7b1c1eb231dfa83098be][Decrypting a Rails Session]] / [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/rails/session..md][Ada's sessions]]
#   - [[http://guides.rubyonrails.org/action_controller_overview.html#filters][Controller Filters]]
#   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/authentication.markdown][Turing's Authentication]] / [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/user-authentication.md][Ada's authentication]]
#   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/authorization.markdown][Authorization]]
#   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/rails_views_tips_and_techniques.markdown][Rails Views]]
#   - Extracting logic from the view/controller/model
#   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/intro_to_the_asset_pipeline.markdown][Asset Pipeline]]
#   - [[https://github.com/turingschool/lesson_plans/blob/master/ruby_02-web_applications_with_ruby/transactions_scopes_callbacks.markdown][Transactions/callbacks/scopes]]
#   - [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/rails/active_record.md][ActiveRecord]]
#   - [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/rails/active_record_practice.md][ActiveRecord practice]]
#   - [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/carrierwave.md][Carrierwave]]
#   - Sqlite / Postgresql
#   - Heroku
#   - [[https://gist.github.com/JoshCheek/cb48fcdd063e45bf5185][quiz topics]]
#   - N+1 queries and other improvements
# - Late Topics ::
#   - [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/web-api-101.md][API examples]]
#   - [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/consuming-an-api.md][Consuming an API]]
#   - [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/consuming-an-api.md#practice][Consuming an API]]
#   - [[https://github.com/Ada-Developers-Academy/daily-curriculum/blob/f3688db58b98237e6df6602179a7051d65ddd284/topic_resources/omniauth.md][Authentication w/ Omniauth]]
# - Project Ideas::
#   - THOUGHT: What if they build their own mini web framework, and then, before learning something in Rails, they add it to their framework? (is there time for that?)
#     - CONCLUSION: Do this!
#   - Traffic Spy
#   - Task Manager
#   - Implement sessions
#   - Implement Authentication
#   - [[https://github.com/Ada-Developers-Academy/C3Projects--bEtsy][Betsy]]
#   - [[https://github.com/Ada-Developers-Academy/C3Projects--SeeMore][See More]]

Section.order(:order).each do |section|
  puts section.title
  puts "Topics: #{section.topics.map(&:topic)}"
  section.weeks.order(:number).each do |week|
    puts "  Week #{week.number}"
    puts "    Topics: #{week.topics.map(&:topic)}" if week.topics.any?
    week.activities.each do |activity|
      puts "    #{activity.name}"
      puts activity.contents.gsub(/^/, '      ') if activity.contents
    end
  end
end

__END__


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


__END__
** (3/3) Frontend / Javascript
*** Week 12 - Core JavaScript
- Show them where the MDN docs are.
  - https://developer.mozilla.org/en-US/docs/Web/JavaScript
  - https://developer.mozilla.org/en-US/docs/Web/Reference/API
- Getting feedback
  - Setup node so they can have a REPL
  - Show them a few tricks:
    - functions to strings
    - reflective methods (eg Object.keys)
- Gaining context
  - https://github.com/mdn/advanced-js-fundamentals-ck/tree/1266706b188590da8d682cca046227ae5a307842/tutorials/01-array-prototype-methods
  - Give them some challenges that require them to play with Arrays, Strings, Numbers, Objects, true, false, undefined, null, so that we don't spend a long time covering ideas they are already famiilar with (ie show them their Ruby knowledge translates and begin getting comfortable with JS)
  - Cover Array prototype methods for the same reason, and b/c they're very useful, and it will give them an opportunity to ask any questions from the above.
  - Cover anonymous functions / blocks to
  - priming for JS Object model.
  - Some DOM manipulation (gain context into where / how this is commonly used)
  - Should there be more of an intro to the DOM? (We can play with it from Ruby, possibly build our own model like we've done with other examples)
- Functional Paradigm
  - https://github.com/mdn/advanced-js-fundamentals-ck/tree/gh-pages/tutorials/02-functions
  - This style is common in JS, and in functional languages (and it shows up from time to time in Ruby, too)
  - It's also a gentler introduction, allowing them to be productive without knowing all the ins and outs of the object model.
  - 01-calling-functions.md
    - var vs fn, hoisting, first-class, reference vs invocation, cursory behaviour of `this`
  - 03-what-is-this.md
    - 4 rules of this
    - call and apply (2 interfaces to do the same thing)
    - write your own bind
    - edge case: callbacks (TODO: discuss what a calback is)
  - 02-currying-and-partial-application.md
    - Partial application (have them discover this)
    - Closures and scope
    - Examples / context
  - 04-recursion.md
  - 05-generators.md
    - Async / Generators
    - Understanding generators to better define what async is and where its boundaries are
    - (find that video where they define these constructs -- event queue)
- Challenges
  - redo linked list with toplevel functions + objects
  - Something with jQuery and the DOM to get them playing with it and see something practical they can apply these ideas to. Might be nice to introduce these things first, and then have their challenges be in this context so that as they learn the topics, they can contemplate how they might be used to manipulate the DOM, something they can see the effects of.
*** Week 13 - Advanced JS, the web
- Object Oriented JS (mechanics and paradigms)
  - https://github.com/mdn/advanced-js-fundamentals-ck/tree/gh-pages/tutorials/03-object-oriented-javascript
  - 01-introduction-to-object-oriented-javascript.md
    - JS Object Model
    - new keyword (have them implement their own?)
    - Constructors
    - `this` in an OO context
    - implicit return of the instance
    - Capitalization is convention
  - 02-building-a-chainable-api.md
    - Common interface patterns (eg jQuery)
    - Contemplating abstraction
  - 03-canvas-and-object-oriented-javascript.md
    - (as a vehicle for talking about OOJS)
    - First see what it looks like procedurally
    - Add the constraint to do this 10x
    - Refactoring to OO
- Challenge
  - Redo linked list with a constructor / prototype
  - If we wind up introducing other data structures, we can have them swap out which one they do, we'll be doing this one frequently enough that we can expand on it and do something more fun like binary search trees.
- Events / working with the DOM
  - https://github.com/mdn/advanced-js-fundamentals-ck/tree/1266706b188590da8d682cca046227ae5a307842/tutorials/04-events
  - 01-basic-events.md
    - also builtin querying api
    - event listeners
  - 02-event-bubbling.md / 03-adding-and-removing.md / 05-event-delegation.md
    - Maybe have them do the experiment and then define their own set of rules to explain it
    - Patterns for avoiding repetition (eg defining the event listener on the pre-existing elements and also on ones you add later)
  - 04-keycodes.md
    - some exercises to do interesting stuff
  - 06-data-attributes.md
    - "Another thing I thought about for JS that I tried to teach all the time is proper use of DOM selectors for JS behavior.  Classes and Ids are often used by designers so attaching to them for JS behavior becomes fragile, since they may rename or move the classes for style changes.  I always like to use data-ids and then communicate that if you see a data-id that means JS is attached there.  Any other part of it -- the HTML or the CSS is still liable to change. This also implies to not have your JS be dependent on a specific HTML structure as designers can change that a lot too." -- Ben Voss
    - C style namespacing
- Also discuss npm, lodash, (browserify | webpack) -- find a good resource for the basics of these things
  - Not necessary to know all their ins and outs, just enough to support the game time below
- Project
  - Build their own game
  - https://github.com/turingschool/lesson_plans/blob/master/ruby_04-apis_and_scalability/gametime_project.markdown
  - TODO: Some kind of project where JS is used to add dynamic functionality to a Rails app?
*** Week 14/15 - Capstone Project
- Objectives
  - Work on a team
  - Practice project management / agile on a larger scale
- Possibilities
  - Something that integrates a Rails backend with Google Maps
*** Week 16 - Leaving this open
- I historically understimate, so it makes sense to shoot for less time rather than perfect time.  Leaving this open to be allocated as appropriate.

Unless otherwise noted, this curriculum by Josh Cheek is licensed under - [[http://creativecommons.org/licenses/by-nc-sa/3.0/][Creative Commons Attribution-NonCommercial-ShareAlike 3.0]]
