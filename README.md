# Ascribe

Ascribe is a library for adding attributes to your classes when you don't have the luxury of ORM magic handling attributes and validations for you.

## Installation

```bash
gem install ascribe
```

If you're using Bundler, make sure you add it to your Gemfile:

```ruby
gem 'ascribe', '>= 0.0.1'
```

class Foo
  include Ascribe::Attributes
  
  attribute :name, String, :required => true, :default => "NAME"
  attribute :stuff, String, :required => true
end

foo = Foo.new(:name => "bar", :type => "baz")
foo.name