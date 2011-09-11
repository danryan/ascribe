module Ascribe
  class Attribute
    attr_accessor :name, :type, :options, :default_value
  
    def initialize(*args)
      options = args.extract_options!
      @name, @type = args.shift.to_s, args.shift
      self.options = (options || {}).symbolize_keys
      self.default_value = self.options[:default]
    end

    def get(value)
      if value.nil? && !default_value.nil?
        if default_value.respond_to?(:call)
          return default_value.call
        else
          return Marshal.load(Marshal.dump(default_value))
        end
      end
      value
    end
    
    def set(value)
      if type.kind_of?(Array)
        if !value.nil? && !type.nil? && !type.include?(value.class)
          raise Mastermind::ValidationError, "#{name} must be an instance of #{type}"
        end
      elsif type.kind_of?(Class)
        if !value.nil? && !type.nil? && (!value.kind_of?(type) || type == nil)
          raise Mastermind::ValidationError, "#{name} must be an instance of #{type}"
        end
      end
      value
    end
  end
end