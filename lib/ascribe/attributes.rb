require 'active_model'
require 'active_support/concern'
require 'active_support/hash_with_indifferent_access'
require 'ascribe/attribute'

module Ascribe
  module Attributes
    extend ActiveSupport::Concern
    include ActiveModel::Validations
    
    included do
      extend ActiveSupport::DescendantsTracker
    end
    
    module ClassMethods
      
      def inherited(base)
        base.instance_variable_set(:@attributes, attributes.dup)
        super
      end
      
      def attributes
        @attributes ||= {}
      end
      
      def attribute(*args)
        Ascribe::Attribute.new(*args).tap do |attribute|
          attributes[attribute.name.to_s] = attribute
          create_attribute_in_descendants(*args)
          create_validations_for(attribute)
        end
      end
      
    private
    
      def create_attribute_in_descendants(*args)
        descendants.each {|descendant| descendant.attribute(*args) }
      end
      
      def create_validations_for(attribute)
        name = attribute.name
        if attribute.options[:required]
          validates_presence_of(name)
        end
        if attribute.options[:numeric]
          number_options = attribute.type == Integer ? {:only_integer => true} : {}
          validates_numericality_of(name, number_options)
        end
        if attribute.options[:format]
          validates_format_of(name, :with => attribute.options[:format])
        end
        if attribute.options[:in]
          validates_inclusion_of(name, :in => attribute.options[:in])
        end
        if attribute.options[:not_in]
          validates_exclusion_of(name, :in => attribute.options[:not_in])
        end
        if attribute.options[:length]
          length_options = case attribute.type
          when Integer
            {:minimum => 0, :maximum => key.options[:length]}
          when Range
            {:within => key.options[:length]}
          when Hash
            key.options[:length]
          end
          validates_length_of(name, length_options)
        end          
      end
      
    end
    
    module InstanceMethods
      def initialize(attrs={})
        self.class.attributes.each_pair do |key, attribute|
          (class << self; self; end).class_eval do
            define_method(attribute.name) do |*value, &block|
              if !block.nil?
                write_attribute(attribute.name, block)
              elsif !value.blank?
                write_attribute(attribute.name, value.first)
              else
                read_attribute(attribute.name)
              end
            end
            define_method("#{attribute.name}=") do |*value, &block|
              if !block.nil?
                write_attribute(attribute.name, block)
              elsif !value.blank?
                write_attribute(attribute.name, value.first)
              end
            end 
          end
        end
        assign_attributes(attrs)
      end
      
      def options
        @options ||= {}
      end
      
      def assign_attributes(attrs)
        attribute_keys.each do |attr_key|
          value = read_attribute(attr_key)
          write_attribute(attr_key, value)
        end

        # Set all attributes supplied in the attrs hash
        attrs.each_pair do |key, value|
          if respond_to?(:"#{key}")
            val = 
            write_attribute(key, value)
          else
            options[key.to_s] = value
          end
        end
      end
      
      def update(attrs={})
        assign_attributes(attrs)
      end
      
      def read_attribute(name)
        if attribute = self.class.attributes[name.to_s]
          value = attribute.get(instance_variable_get(:"@#{name}"))
          instance_variable_set(:"@#{name}", value)
        end
      end
      
      def write_attribute(name, value)
        attribute = self.class.attributes[name.to_s]
        instance_variable_set(:"@#{name}", attribute.set(value))
      end
      
      def attributes
        attributes = {}
        
        self.class.attributes.each do |key, attribute|
          name = attribute.name
          attributes[name] = read_attribute(name) if respond_to?(name)
        end
        return attributes
      end
      
      def attributes=(attrs={})
        return if attrs.blank?
        
        attrs.each_pair do |key, value|
          if respond_to?(:"#{key}")
            write_attribute(key, value)
          end
        end
      end
      
      def attribute_keys
        self.class.attributes.keys
      end
      
      def to_hash
        attributes.merge("options" => options)
      end
      
      def inspect
        attrs = attributes.map do |attribute|
          "@#{attribute[0]}=#{attribute[1] ? attribute[1] : "nil"}"
        end
        result = attrs + ["@options=#{options}]
        "#<#{self.class.name} #{result.join(" ")}>"
      end
      
    end
  end
end