require 'rubygems'
require 'test/unit'

TESTDIR = File.dirname(__FILE__)
$LOAD_PATH.unshift(TESTDIR)
$LOAD_PATH.unshift(File.join(TESTDIR, '..', 'lib'))

require 'yamo'

class CollectionTest < Yamo::Collection
  schema "#{TESTDIR}/data/schemas/collection.yaml"
  objectdir "#{TESTDIR}/data/collection"
end

class SingletonTest < Yamo::Singleton
  schema "#{TESTDIR}/data/schemas/singleton.yaml"
  object "#{TESTDIR}/data/singleton.conf"
end
