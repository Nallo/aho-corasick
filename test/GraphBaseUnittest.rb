#!/usr/bin/env ruby -wKU
#
# Created on Nov 1 2014
# Author: Nallo 
#
# run with:
#
# ruby -vI src/lib test/GraphBaseUnittest.rb

require 'simplecov'
SimpleCov.start

require 'test/unit'
require 'GraphBase'


class TestNode < Test::Unit::TestCase

    def test_node_constructor
        # positive tests
        n = Node.new("Node Name")
        assert_equal("Node Name", n.name)
        assert_equal({}, n.edges)

        # negative tests
        n = Node.new()
        assert_equal("", n.name)
    end

    def test_connect_to
        n1 = Node.new("from")
        n2 = Node.new("to")

        # positive tests
        assert_not_equal(nil, n1.connect_to(n2,"n1->n2"))
        assert_equal(    nil, n1.connect_to(n2,"n1->n2"))
        assert_not_equal(nil, n1.connect_to(n2 , 0))

        # negative tests
        assert_equal(nil, n1.connect_to(nil, "n1->nil"))
        assert_equal(nil, n1.connect_to(n2 , nil))
        assert_equal(nil, n1.connect_to(n2 , ""))
        assert_equal(nil, n1.connect_to(nil, nil))
    end

    def test_has_edge?
        n1 = Node.new("from")
        n2 = Node.new("to")
        n1.connect_to(n2, "n1->n2")

        # positive tests
        assert_equal(true, n1.has_edge?("n1->n2"))
    
        # negative tests
        assert_equal(false, n1.has_edge?("does not exist"))
    end
end

class TestGraph < Test::Unit::TestCase

    def test_graph_constructor
        g = Graph.new()

        assert_equal(0,  g.nodes_count)
    end    

    def test_add_node
        g = Graph.new()
        
        # positive tests
        assert_not_equal(nil, g.add_node("node1"))
        assert_not_equal(nil, g.add_node(0))
        assert_equal(2, g.nodes_count)

        # negative tests
        assert_equal(nil, g.add_node(nil))
        assert_equal(nil, g.add_node(""))
        assert_equal(nil, g.add_node("node1")) # already inserted
    end

    def test_node
        g = Graph.new()
        g.add_node("first node")
        g.add_node("second node")

        # positive tests
        assert_not_equal(nil, g.node("first node"))
        assert_not_equal(nil, g.node("second node"))

        # negative tests
        assert_equal(nil, g.node(""))
        assert_equal(nil, g.node(nil))
    end

    def test_add_edge
        g = Graph.new()
        g.add_node("n1")
        g.add_node("n2")

        # positive tests
        assert_not_equal(nil, g.add_edge("n1", "n2", "n1->n2"))
        assert_equal(true, g.nodes["n1"].has_edge?("n1->n2"))
        
        # negative tests
        assert_equal(nil, g.add_edge(nil, "n2", "1->2"))
        assert_equal(nil, g.add_edge( "", "n2", "1->2"))

        assert_equal(nil, g.add_edge("n1", nil, "1->2"))
        assert_equal(nil, g.add_edge("n1",  "", "1->2"))

        assert_equal(nil, g.add_edge("n1", "n2", nil))
        assert_equal(nil, g.add_edge("n1", "n2",  ""))

        assert_equal(nil, g.add_edge("n1", "invalid", "n1->n2"))
        assert_equal(nil, g.add_edge("invalid", "n1", "n1->n2"))

        assert_equal(false, g.nodes["n1"].has_edge?("n1->does not exist"))
    end
end