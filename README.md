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

user = User.new(:name => "joe", :admin => true)
user.valid?
# => true

```
