Rails Structure
===============

```
.
├── Gemfile       Bundler uses this file to keep your gems in sync
├── Gemfile.lock  Bundler's resolved file
├── README.rdoc   Explain the purpose of the app, add a license, tell new devs how to get started (I usually swap this over to a markdown file)
├── Rakefile      Tasks you can run (there are others that it loads from Rails code)
├── app                               Your Rails related code will be in here.
│   ├── assets                        Where you put images, javascript, stylesheets (CSS and others)
│   ├── controllers                   The entry point to your code, for each request
│   │   └── application_controller.rb All controllers inherit from this
│   ├── helpers                       1-off methods to help keep code in the views simple
│   ├── mailers                       For sending emails
│   ├── models                        For talking to the database
│   └── views                         For storing body templates
│       └── layouts                   Other views get rendered inside of these
│           └── application.html.erb  The default layout (requires stylesheets, wraps views in a generally good HTML layout0
├── bin                               Executables go here (Rails prepopulates it with the executables it ships with)
├── config
│   ├── database.yml   Configure your database
│   ├── environments   Configure Rails for your development / test / production environments
│   ├── initializers   Configuration of things other than Rails itself
│   ├── locales        For working with multiple languages
│   ├── routes.rb      When an HTTP request comes in, this chooses which code handles it
│   └── secrets.yml    For loading sensitive data (take a look through it, what do you notice?)
├── config.ru                Hook your server up to Rails
├── db
│   ├── development.sqlite3  If you are using sqlite, the database is stored here
│   ├── migrate              Changes to the structure of your database
│   ├── schema.rb            The currently known structure of your database (this file is generated, don't edit it!)
│   └── seeds.rb             Insert default data into your database
├── lib               Code relevant to your app that is not directly related to Rails
│   └── tasks         Rake tasks that you make
├── log               Information that Rails spits out while running
├── public            Files that get served exactly as they are
├── test              Write your tests here
├── tmp               Files generated while running, that aren't part of your app
└── vendor            Gems and other dependencies that you want locally, but aren't part of your app
```
