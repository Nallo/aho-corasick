#!/usr/bin/env ruby -wKU
#
#
# Created on Oct 25 2014
# Author: Nallo 
#
#
# The Node class is used to abstract the graph node concept.
class Node
    # Class constructor.
    #
    # ==== Attributes
    #
    # * +id+         The Node identifier
    # * +neighbors+  The set of neighbors (key,value) pairs
    # * +failure+    The failure function used by Aho-Corasick
    # * +output+     The output function used by Aho-Corasick
    # * +goto_value+ The set of neighbors we can reach using the edge id.
    #
    def initialize(id)
        @id         = id
        @neighbors  = {}
        @failure    = 0
        @output     = []
        @goto_value = {}
    end

    # ==== Return
    #
    # The Node identifier.
    #
    def get_id
        @id        
    end

    # ==== Return
    #
    # The neighbors of the given Node.
    #
    def get_neighbors!
        @neighbors
    end

    # ==== Return
    #
    # The value of the failure function.
    #
    def get_failure
        @failure
    end

    # ==== Return
    #
    # The value of the output function.
    #
    def get_output
        @output
    end

    # Get the value of the goto function.
    #
    # ==== Attributes
    #
    # * +edge_id+  The edge identifier.
    #
    # ==== Return
    #
    # * The identifier of the reachable Node using the given edge_id.
    # * nil on failure
    #
    def get_goto(edge_id)
        @goto_value[edge_id]
    end

    # Connect two nodes by using an edge.
    # 
    # ==== Attributes
    #
    # * +node_id+ The node we want connect to.
    # * +edge_id+ The id of the created edge.
    #
    # ==== Usage
    #
    #    n1 = Node.new(1)
    #    n2 = Node.new(2)
    #    n1.connect_to(2,"edge 1-->2")
    #
    def connect_to(node_id, edge_id)
        if ( not @neighbors.include?(node_id) )
            @neighbors[node_id]  = edge_id
            @goto_value[edge_id] = node_id 
        end
    end

    # ==== Attributes
    #
    # * +edge_id+ The edge id we want to find.
    #
    # ==== Return
    #
    # True if the node has an edge with the give identifier, false otherwise.
    #
    def has_edge_with_id?(edge_id)
        return (@neighbors.values.include?(edge_id))
    end

    # ==== Attributes
    #
    # * +node_id+ The Node we want to find.
    #
    # ==== Return
    #
    # True if the node is connected to node_id, false otherwise.
    #
    def is_connected_to?(node_id)
        return (@neighbors.keys.include?(node_id))
    end
end


# The Graph class is used to abstract the graph concept.
class Graph
    # Class constructor.
    #
    # ==== Attributes
    #
    # * +nodes+     The set of the nodes.
    #
    def initialize
        @nodes = {}
    end
    
    # Add a new node to the Graph.
    # If the Node already exists the function does not succeed.
    #
    # ==== Attributes
    #
    # * +id+     The Node identifier.
    #
    def add_node(id)
        @nodes[id] = Node.new(id) if not @nodes.include?(id)
    end

    # ==== Return
    #
    # The list of nodes.
    #
    def get_all_nodes
        @nodes.values
    end

    # ==== Attributes
    #
    # * +id+     The Node identifier.
    #
    # ==== Return
    #
    # The pointer to the identified node.
    #
    def get_node!(id)
        @nodes[id]
    end

    # Add an edge between two nodes.
    # If one of the two nodes does not exist the function fails.
    #
    # ==== Attributes
    #
    # * +node_id_from+  The node where the edge starts from.
    # * +node_id_to+    The node where the edge ends to.
    # * +edge_id+       The edge identifier.
    #
    # ==== Return
    #
    # On success it creates the edge.
    #
    def add_edge(node_id_from, node_id_to, edge_id)
        if (not @nodes.include?(node_id_from)) || (not @nodes.include?(node_id_to))
            puts "(#{node_id_from},#{node_id_to}) One of the nodes does not exist"
        else
            @nodes[node_id_from].connect_to(node_id_to, edge_id)
        end
    end
end