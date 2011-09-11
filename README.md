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

First, a quick example to demonstrate several of Ascribe's features:

```ruby
class User
  include Ascribe::Attributes
  
  attribute :name, String, :required => true
  attribute :admin, [TrueClass, FalseClass], :default => false
end

user = User.new
user.valid?
# => false 

user.errors
# => #<ActiveModel::Errors:0x007fdbc4010f20 @base=#<User:0x007fdbc4013f68 @name=nil, @admin=false, @validation_context=nil, @errors=#<ActiveModel::Errors:0x007fdbc4010f20 ...>>, @messages={:name=>["can't be blank"]}>

user = User.new(:name => "joe", :admin => true)
user.valid?
# => true

```
### Declaring Attributes

Use the `attribute` class method to define attributes on your model. The sole requirements are the name and type of the attribute.

```
attribute :name>, type, [options]
```

```ruby
class User
  include Ascribe::Attributes
  
  attribute :name, String
  attribute :email, String
  end
```