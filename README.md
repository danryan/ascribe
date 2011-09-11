class Foo
  include Ascribe::Attributes
  
  attribute :name, String, :required => true, :default => "NAME"
  attribute :stuff, String, :required => true
end

foo = Foo.new(:name => "bar", :type => "baz")
foo.name