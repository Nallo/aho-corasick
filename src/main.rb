#!/usr/bin/env ruby -wKU

load 'Graph.rb'

g = Graph.new()

g.add_node(0)
g.add_node(1)
g.add_node(2)
g.add_node(3)

puts "All nodes"
g.get_all_nodes.each do |n|
    puts n.get_id
end
puts

puts "Add edge 1-2 t"
g.add_edge(1,2,'t')

puts "Add edge 1-3 w"
g.add_edge(1,3,'w')

puts "Neighbors of 1"
puts g.get_node!(1).get_neighbors!
puts

n = g.get_node!(1)
puts "1--t--> #{n.has_edge_with_id?('t')}"
puts "1--w--> #{n.has_edge_with_id?('w')}"
puts "1--q--> #{n.has_edge_with_id?('q')}"
puts

puts n.is_connected_to?(2)
puts n.is_connected_to?(3)
puts n.is_connected_to?(0)
puts

puts n.get_goto('t')
puts n.get_goto('w')

if n.get_goto('q')
	puts "ok"
else
	puts "ko"
end
