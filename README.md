# Ascribe

Simple attributes for your Ruby objects.

## Why?

It seems there comes a point during all of my projects where I end up hacking up some sort of attribute and validation system into my models. I decided it was finally time I extracted my hacks into a library that provided a consistent way to add attributes to my classes that offered more than simple accessor methods. Models aren't always tied to an ORM that does this magic for you :)

## Installation

```bash
gem install ascribe
```

If you're using Bundler, make sure you add it to your Gemfile:

```ruby
gem 'ascribe', '>= 0.0.2'
```

## Usage

To use Ascribe in a model, just make your class look like this:

```ruby
require 'ascribe'

class Foo
  include Ascribe::Attributes
  
end
```
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


### Validation options

Ascribe can validate attributes in a number of ways

```ruby
class Post
  attribute :title, String, :required => true                                       # presence
  attribute :body, String, :length => { :min => 0, :max => 1000 }                   # length
  attribute :hits, Integer, :numeric => true                                        # numericality
  attribute :email, String, :format => /\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/  # format
  attribute :tags, Array, :in => ["foo", "bar"], :not_in => ["baz", "qux"]          # inclusion/exclusion
end
```

### Bonus options

If any attributes not explicitly stated are included in the hash used to instantiate your object, they won't throw an error or be discarded; instead, they get assigned to the @options instance variable (handy if you need arbitrary attributes sometimes):

```ruby
class Foo
  attribute :bar, String
end

foo = Foo.new(:bar => "asdf", :baz => "qwer", :qux => "zxcv")
foo.attributes #=> {"bar" => "asdf"}
foo.options #=> {"baz"=>"qwer", "qux"=>"zxcv"}
```