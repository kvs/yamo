# -*- mode: ruby; tab-width: 2; indent-tabs-mode: nil; -*-

require 'yamo/validator'

module Yamo; end

# Yamo::Object is a base-class for a data-object, externally stored in YAML,
# with a Kwalify-schema and optional validation-hooks.
class Yamo::Object
  attr_reader :data

  def self.schema(schema)
    @validator = Yamo::Validator.new(schema)
    @validator.hook = self

    create_accessors(@validator.schema["mapping"])
  end

  def self.validator
    @validator
  end
  
  def self.create_accessors(schema, obj=nil)
    # Generate instance accessor methods
    schema.each_pair do |key, value|
      # We either generate methods on the Class instance of this object, or on a simple instance-object.
      receiver = (obj.nil?) ? self : (class << obj ; self; end)
      receiver.send :define_method, key.gsub('-', '_') do
        retval = (obj ? obj[key] : @data[key]) || value["default"]
        if value["type"] == "map"
          retval = retval.nil? ? Hash.new : retval.dup
          Yamo::Object.create_accessors(value["mapping"], retval)
        end
        retval
      end
    end
  end

  # Load and validate +file+. Source is either eval'd or YAML, depending on +yaml+
  def self.load_and_validate_file(file, yaml=false); load_and_validate_source(file, yaml, true); end

  # Validate +data+. Source is either eval'd or YAML, depending on +yaml+
  def self.validate_data(data, yaml=false); load_and_validate_source(data, yaml, false); end

  # Validate +src+, interpreting it as a file if +file+ is true, or as a String to eval if +file+ is false.
  def self.load_and_validate_source(src, yaml, file)
    @validator.load_and_validate_source(src, yaml, file)
  end
end
