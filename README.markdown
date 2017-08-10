# よくない

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

Add some configuration for where you want to keep things:

```yml
# config/development.yml
---
template_dir: web/views
asset_dir: web/assets
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
