#!/usr/bin/env ruby -wKU

# run with:
#
# ruby -I src test/aho-corasick-unittest.rb 

require 'test/unit'
require 'Text'


class TestText < Test::Unit::TestCase

	def simple_test
		assert_equal(true, true)
	end

end