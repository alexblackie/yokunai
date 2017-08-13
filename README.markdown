# よくない [![Build Status](https://ci.blackieops.com/buildStatus/icon?job=yokunai-tests)](https://ci.blackieops.com/job/yokunai-tests/)

It's not very good.

Please don't actually use this.

## How to use it

Add the dependency:

```ruby
# Gemfile
source "https://rubygems.org/"

gem "yokunai"
```

Run `bundle`, of course. Then make a controller:

```ruby
# lib/my_app.rb
require "yokunai"

ROUTES = {
  %r{^/$} => {class: "HomeController", methods: ["GET"]}
}.freeze

class HomeController < Yokunai::AbstractController
  def get
    respond body: "It works!"
  end
end
```

Now just make a rackup config so we can run something:

```ruby
# config.ru
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))
require "my_app"

run Yokunai::Application.new(
  route_map: ROUTES,
  base_dir: File.dirname(__FILE__)
)
```

Then just `bundle exec rackup` and you're gold, Ponyboy.

## Configuration

You can configure Yokunai via a YAML file. Create `config/development.yml`
(where `development` is whatever environment you want to configure). Anything in
this file will be populated into the `Yokunai::Config` helper, so you can fetch
things easily with `Yokunai::Config.get("my_key")` anywhere in your app.

For example,

```yml
# config/development.yml
---
template_dir: web/htmls
some_secret_key: abc123
```

Some values have defaults to make setup easier, feel free to override any of
them. An exhaustive list can be found [in the Config class
itself][config_defaults].

## Assets

You probably have frontend assets, if this is a web page. There's a controller
built-in for that if you want it. Just point a path with a capture called `name`
to `Yokunai::StaticController`.

```ruby
ROUTES = {
  %r{^/assets/(?<name>.+)$} => {class: "Yokunai::StaticController", methods: ["GET"]}
}
```

Now assets will be served out of the directory you set as your `asset_dir` in
the YAML config.

## Boot Hooks

If your app needs to do something on-boot (maybe seed a cache, ping an
orchestrator, etc.) then you can create a "boot hook" to do that. Just create a
PORO class with a `.run` method, which will be invoked when the app boots.

```
# lib/my_app/some_hook.rb
module MyApp
  class SomeHook
    def self.run
      puts "Got hooked"
    end
  end
end
```

Then pass the class in when you boot the app:

```
# config.ru
[...]

run Yokunai::Application(
  routes: ...,
  base_dir: ...,
  hooks: [MyApp::SomeHook]
)
```

[config_defaults]: ./lib/yokunai/config.rb
