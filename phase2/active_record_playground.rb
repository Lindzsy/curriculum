require 'active_record'
require 'logger'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
ActiveRecord::Base.logger = Logger.new $stdout
ActiveSupport::LogSubscriber.colorize_logging = false

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users do |t|
    t.string :name
  end

  create_table :posts do |t|
    t.string :name
    t.integer :user_id
  end
end

class User < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end

user = User.create! name: 'Josh'
user.posts = [Post.new(name: 'yo ho ho'), Post.new(name: 'and a bottle of rum')]
# => [#<Post:0x007ffa9c0c33e0 id: 1, name: "yo ho ho", user_id: 1>,
#     #<Post:0x007ffa9d3c2b58 id: 2, name: "and a bottle of rum", user_id: 1>]

# >> D, [2016-03-22T12:33:47.007201 #81548] DEBUG -- :    (0.4ms)  CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar)
# >> D, [2016-03-22T12:33:47.007785 #81548] DEBUG -- :    (0.1ms)  CREATE TABLE "posts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "user_id" integer)
# >> D, [2016-03-22T12:33:47.045935 #81548] DEBUG -- :    (0.1ms)  begin transaction
# >> D, [2016-03-22T12:33:47.052020 #81548] DEBUG -- :   SQL (0.1ms)  INSERT INTO "users" ("name") VALUES (?)  [["name", "Josh"]]
# >> D, [2016-03-22T12:33:47.052425 #81548] DEBUG -- :    (0.1ms)  commit transaction
# >> D, [2016-03-22T12:33:47.075706 #81548] DEBUG -- :   Post Load (0.2ms)  SELECT "posts".* FROM "posts" WHERE "posts"."user_id" = ?  [["user_id", 1]]
# >> D, [2016-03-22T12:33:47.076001 #81548] DEBUG -- :    (0.1ms)  begin transaction
# >> D, [2016-03-22T12:33:47.079994 #81548] DEBUG -- :   SQL (0.1ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "yo ho ho"], ["user_id", 1]]
# >> D, [2016-03-22T12:33:47.080677 #81548] DEBUG -- :   SQL (0.0ms)  INSERT INTO "posts" ("name", "user_id") VALUES (?, ?)  [["name", "and a bottle of rum"], ["user_id", 1]]
# >> D, [2016-03-22T12:33:47.080943 #81548] DEBUG -- :    (0.0ms)  commit transaction
