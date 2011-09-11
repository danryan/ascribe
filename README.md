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

### Setting types

The type is the second argument of the `attribute` class method. Type should always be a class name, as Ascribe checks that the assigned value is an instance of the class. Type can be a single class name, or an array of classes

```ruby
class Foo
  attribute :bar, String
  attribute :baz, [String, Symbol]
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