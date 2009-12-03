# -*- mode: ruby; tab-width: 2; indent-tabs-mode: nil; -*-

require 'yamo/object'
require 'singleton'

module Yamo; end

class Yamo::Singleton < Yamo::Object
  include Singleton

  def self.object(file)
    @@data = self.load_and_validate_file(file)
    @object = file
  end

  def initialize
    @data = @@data
  end
end
