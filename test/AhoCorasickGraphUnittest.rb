#!/usr/bin/env ruby -wKU
#
# Created on Nov 1 2014
# Author: Nallo
#
# run with:
#
# ruby -vI src/lib test/AhoCorasickGraphUnittest.rb

require 'simplecov'
SimpleCov.start

require 'test/unit'
require 'AhoCorasickGraph'

class TestAhoCorasickNode < Test::Unit::TestCase

    def test_constructor
        n = AhoCorasickNode.new("node")
        assert_equal("node", n.name)
        assert_equal(0,      n.failure)
        assert_equal([]    , n.output)

        n = AhoCorasickNode.new()
        assert_equal("", n.name)
    end

    def test_add_output
        n1 = AhoCorasickNode.new("from")

        # positive tests
        assert_not_equal(nil, n1.add_output("needle1"))
        assert_equal(["needle1"], n1.output)

        # negative tests
        assert_equal(nil, n1.add_output(nil))
        assert_equal(["needle1"], n1.output)
        
        assert_equal(nil, n1.add_output(""))
        assert_equal(["needle1"], n1.output)
    end

    def test_goto
        n1 = AhoCorasickNode.new("from")
        n2 = AhoCorasickNode.new("to")
        n1.connect_to(n2, "n1->n2")
        
        # positive tests
        assert_equal(n2, n1.goto("n1->n2"))

        # negative tests
        assert_equal(nil, n1.goto(nil))
        assert_equal(nil, n1.goto(""))
        assert_equal(nil, n1.goto("does not exist"))
    end
end

class TestAhoCorasickGraph < Test::Unit::TestCase

    def test_constructor
        g = AhoCorasickGraph.new()
        assert_equal(1, g.nodes_count)
    end

    def test_add_node
        g = AhoCorasickGraph.new()
        
        # positive tests
        assert_not_equal(nil, g.add_node("node1"))
        assert_not_equal(nil, g.add_node(0))
        assert_equal(3, g.nodes_count)

        # negative tests
        assert_equal(nil, g.add_node(nil))
        assert_equal(nil, g.add_node(""))
        assert_equal(nil, g.add_node("node1")) # already inserted
    end

    def test_add
        g = AhoCorasickGraph.new()

        g.add("abcd")
        assert_equal(5, g.nodes_count)

        g.add("abde")
        assert_equal(7, g.nodes_count)

        # negative tests
        assert_equal(nil, g.add(nil))
        g.add("") # no new nodes should be added
        assert_equal(7, g.nodes_count)
    end

    def test_has?
        g = AhoCorasickGraph.new()
        
        assert_equal(false, g.has?("this is not there"))
        assert_equal(false, g.has?(nil))

        g.add("he")
        g.add("she")
        g.add("his")
        g.add("hers")
        assert_equal(true, g.has?("he"))
        assert_equal(true, g.has?("she"))
        assert_equal(true, g.has?("his"))
        assert_equal(true, g.has?("hers"))

        #g.compute_failure()

        assert_equal([], g.node(1).output)
        assert_equal(["he"], g.node(2).output)
        assert_equal([], g.node(3).output)
        assert_equal([], g.node(4).output)
        assert_equal(["she"], g.node(5).output) # she, he - with failure computation
        assert_equal([], g.node(6).output)
        assert_equal(["his"], g.node(7).output)
        assert_equal([], g.node(8).output)
        assert_equal(["hers"], g.node(9).output)
    end
end