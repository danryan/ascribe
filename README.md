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

## Usage

### Declaring Attributes

Use the `attribute` class method to define attributes on your model. The sole requirements are the name and type of the attribute.

```ruby
class User
  include Ascribe::Attributes
  
  attribute :name, String
  attribute :email, String
end
```

### Specifying defaults

Defaults can be set via the :default key for an attribute. Defaults can either be a standard values (strings, arrays, hashes, etc), or they can be anything that responds to `#call`, like Procs.

```ruby
class Pants
  attribute :on, [TrueClass, FalseClass], :default => false
end

pants = Pants.new
pants.on #=> false
```