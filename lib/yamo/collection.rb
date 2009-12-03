# -*- mode: ruby; tab-width: 2; indent-tabs-mode: nil; -*-

require 'yamo/object'
require 'singleton'

module Yamo; end

class Yamo::Collection < Yamo::Object
  extend Enumerable

  attr_reader :name

  def initialize(name, data)
    @name = name
    @data = data
  end

  def self.objectdir(objectdir)
    @objectdir = objectdir
  end

  def self.get(name)
    begin
      self.new(name, load_and_validate_file("#{@objectdir}/#{name}"))
    rescue Errno::ENOENT
      nil
    end
  end

  def self.each
    Dir.foreach(@objectdir) do |o|
      next if o.match(/^\./)
      yield get(o)
    end
  end

  # Include name in +to_s+
  def to_s
    return '#<' + self.class.to_s + ":" + self.name + '>'
  end
end
