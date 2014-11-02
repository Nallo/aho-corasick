#!/usr/bin/env ruby -wKU
#
#
# Created on Oct 25 2014
# Author: Nallo 


# ==== Node Class

class Node

    attr_reader :name, :edges

    def initialize(name="")
        @name  = name
        @edges = {}
    end

    def connect_to(node_ptr, edge)
        unless ( not node_ptr ) ||
               ( not edge ) || ( edge.length==0 if edge.instance_of?(String) ) ||
               ( @edges[edge] == node_ptr ) # avoid two identical edges insisting on the same node
            @edges[edge] = node_ptr
        end
    end

    def has_edge?(edge)
        return ( @edges.has_key?(edge) )
    end

end

# ==== Graph Class

class Graph

    attr_reader   :nodes
    attr_accessor :nodes_count

    def initialize
        @nodes       = {}
        @nodes_count = 0
    end
    
    def add_node(with_name)
        unless ( not with_name ) ||
               ( with_name.length==0 if with_name.instance_of?(String) ) ||
               ( @nodes.has_key?(with_name) )
            @nodes[with_name] = Node.new( with_name )
            @nodes_count += 1
        end
    end

    def node(name)
        unless ( not name ) || ( name.length==0 if name.instance_of?(String) )
            @nodes[name]
        end
    end

    def add_edge(from, to, edge)
        unless ( not from ) || ( from.length==0 if from.instance_of?(String) ) || 
               ( not to   ) || (   to.length==0 if   to.instance_of?(String) ) ||
               ( not edge ) || ( edge.length==0 if edge.instance_of?(String) ) ||
               ( not @nodes.has_key?(from) ) || ( not @nodes.has_key?(to) )
            node_to_ptr = @nodes[to]
            node(from).connect_to(node_to_ptr, edge)            
        end
    end
end