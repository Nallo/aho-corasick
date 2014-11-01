#!/usr/bin/env ruby -wKU
#
#
# Created on Oct 25 2014
# Author: Nallo 
#
#
# The Node class is used to abstract the graph node concept.
class Node

    attr_reader   :name, :edges, :output
    attr_accessor :failure

    def initialize(name="")
        @name       = name
        @edges      = {}
        @failure    = 0
        @output     = []
    end

    def add_output(keyword)
        unless (not keyword) || (keyword.length==0)
            @output << keyword
        end
    end

    def goto(edge)
        unless (not edge) || (not edge)
            @edges[edge]
        end
    end

    # ==== Attributes
    #
    # * +node_ptr+ Pointer to the node we want connect to.
    # * +edge+     The tag of the created edge.
    #
    def connect_to(node_ptr, edge)
        unless (not node_ptr) ||
               (not edge) || (edge.length==0 if edge.instance_of?(String)) ||
               ( @edges[edge] == node_ptr )     # avoid two identical edges to the same node
            @edges[edge] = node_ptr
        end
    end

    def has_edge?(edge)
        return (@edges.include?(edge))
    end

end


# The Graph class is used to abstract the graph concept.
class Graph

    attr_reader   :nodes

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
    def add_node(with_name)
        unless ( not with_name ) ||
               ( with_name.length==0 if with_name.instance_of?(String) ) ||
               ( @nodes.include?(with_name) )
            @nodes[with_name] = Node.new(with_name)
        end
    end

    def node!(name)
        unless ( not name ) || ( name.length==0 if name.instance_of?(String) )
            @nodes[name]
        end
    end

    # Add an edge between two nodes.
    # If one of the two nodes does not exist the function fails.
    #
    # ==== Attributes
    #
    # * +from+  The node where the edge starts from.
    # * +to+    The node where the edge ends to.
    # * +edge+  The edge name.
    #
    # ==== Return
    #
    # On success it creates the edge.
    #
    def add_edge(from, to, edge)
        unless ( not from ) || ( from.length==0 if from.instance_of?(String) ) || 
               ( not to   ) || (   to.length==0 if   to.instance_of?(String) ) ||
               ( not edge ) || ( edge.length==0 if edge.instance_of?(String) ) ||
               ( not @nodes.include?(from) ) || ( not @nodes.keys.include?(to) )
            node_to_ptr = @nodes[to]
            node!(from).connect_to(node_to_ptr, edge)            
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
        #compute_aho_corasick_failure()
    end

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

    def find(needle)
        state = node!(0)
        index = 0

        index.upto(needle.length - 1){ |i|
            c = needle[i]

            if(not state.has_edge_with_id?(c))
                return false
            end

            state_id = state.goto(c)
            state = node!(state_id)
            puts "- #{state.id}"
        }
        return state.output.include?(needle)
    end

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