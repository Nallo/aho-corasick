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
    def id
        @id        
    end

    # ==== Return
    #
    # The neighbors of the given Node.
    #
    def neighbors
        @neighbors
    end

    # ==== Return
    #
    # The value of the failure function.
    #
    def failure
        @failure
    end

    # Set the value of the the failure function.
    #
    # ==== Attributes
    #
    # * +value+ The value we want to set.
    #
    def failure=(value)
        @failure = value        
    end

    # ==== Return
    #
    # The value of the output function.
    #
    def output
        @output
    end

    # Set the value of the the output function.
    #
    # ==== Attributes
    #
    # * +output+ The value we want to set.
    #
    def output=(output)
        @output = output
    end

    # Add the keyword to the output of the give node.
    #
    # ==== Attributes
    #
    # * +keyword+  The keyword to add.
    #
    def add_output(keyword)
        @output << keyword
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
    def goto(edge_id)
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
    # Initialize a generic Graph.
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
    def nodes
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
    def node!(id)
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
            node!(node_id_from).connect_to(node_id_to, edge_id)
        end
    end

    # Build the the Aho-Corasick Graph.
    #
    # http://en.wikipedia.org/wiki/Aho%E2%80%93Corasick_string_matching_algorithm
    #
    # The basic Graph needs to be created before calling this method.
    #
    # ==== Attributes
    #
    # * +keywords+  The list of keywords.
    #
    # ==== Return
    #
    # The Aho-Corasick Graph.
    #
    def build_aho_corasick_graph!(keywords)
        add_node(0)
        new_state = node!(0).id

        keywords.each do |keyword|
            new_state = enter!(keyword, new_state)
        end

        compute_aho_corasick_failure()
    end

# Functions for Debug Purpose.

    #
    # For each Node in the Graph, display the value of the output function.
    #
    def display_outputs
        @nodes.values.each do |n|
            puts "Node #{n.id} --> #{n.output}" if n.output.size > 0
        end
    end

    #
    # For each Node in the Graph, display the neighbors.
    #
    def display_neighbors
        @nodes.values.each do |n|
            puts "Node #{n.id} --> #{n.neighbors}" if n.neighbors.size > 0
        end
    end

    #
    # Display the entire Graph.
    # For each node, display the neighbors and the value of the
    # output function.
    #
    def display_graph
        @nodes.values.each do |n|
            puts "Node #{n.id}"
            puts  " --> #{n.neighbors}"   if n.neighbors.size  > 0
            puts  " --> #{n.output}"  if n.output.size > 0
            puts  " --> #{n.failure}" if n.failure    != 0
            puts
        end
        
    end

private
    def enter!(keyword, new_state)
        state = node!(0)
        keyword_index = 0
        
        while state.goto( keyword[keyword_index] )
            state_id = state.goto( keyword[keyword_index] )
            state    = node!( state_id )
            keyword_index += 1
        end

        keyword_index.upto(keyword.length - 1) { |i|
            new_state += 1
            add_node(new_state)
            add_edge(state.id, new_state, keyword[i])
            state = node!(new_state)
        }
        state.add_output(keyword)
        return new_state
    end

    def compute_aho_corasick_failure()
        queue = []

        node!(0).neighbors.each do |first_level_neighbor|
            neighbor_id = first_level_neighbor[0]
            queue      << node!( neighbor_id )
            # we do not need to set f(first_level_neighbor) to 0
            # because it is done by the default constructor.
        end

        while queue.size > 0 do
            r = queue.shift

            r.neighbors.each do |r_neighbor|
                r_neighbor_id   = r_neighbor[0]
                r_neighbor_edge = r_neighbor[1]
                queue << node!( r_neighbor_id )
                state  = r.failure

                while state!=0 && node!(state).goto(r_neighbor_edge)==nil
                    state =  node!(state).failure
                end
                
                if node!(state).goto(r_neighbor_edge)
                    node!(r_neighbor_id).failure=(node!(state).goto(r_neighbor_edge))
                end

                s = node!(r_neighbor_id).failure

                output1 = node!(r_neighbor_id).output
                output2 = node!(      s      ).output
                node!(r_neighbor_id).output=( output1 |= output2 )
            end
        end
    end
end