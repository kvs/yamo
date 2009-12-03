# -*- mode: ruby; tab-width: 2; indent-tabs-mode: nil; -*-

require 'kwalify'
require 'shellwords'

module Yamo; end

class Yamo::ValidateError < Exception; end

class Yamo::Validator
  attr_reader :schema
  attr_reader :hook

  def initialize(schema)
    @hook = nil

    metavalidator = Kwalify::MetaValidator.instance
    parser = Kwalify::Yaml::Parser.new(metavalidator)
    @schema = parser.parse_file(schema)
    
    if parser.errors and !parser.errors.empty?
      raise Yamo::ValidateError, parser.errors
    end

    @validator = Kwalify::Validator.new(@schema)
  end

  def hook=(klass)
    @hook = klass

    @validator.define_singleton_method :validate_hook do |v,r,p,e|
      klass.validate_hook(v,r,p,e) if klass.respond_to? :validate_hook
    end
  end

  def load_and_validate_source(src, yaml, file)
    errors = nil
    doc = nil
    
    if yaml
      parser = Kwalify::Yaml::Parser.new(validator)
      if file
        doc = parser.parse_file(src)
      else
        doc = parser.parse(src)
      end
      errors = parser.errors()
    else
      if file
        doc = eval(IO.readlines(src).join(""))
      else
        doc = eval(src)
      end

      if doc.class != Hash
        raise Yamo::ValidateError, "data did not produce a Hash"
      end

      doc = if @hook.respond_to?(:pre_validate) then @hook.pre_validate(doc) else doc end
      errors = @validator.validate(doc)
    end

    if errors and !errors.empty?
      raise Yamo::ValidateError, "\n#{file ? src : 'input'} did not validate:\n" + errors.join("\n")
    end

    if @hook.respond_to?(:post_validate) then @hook.post_validate(doc) else doc end
  end
end
