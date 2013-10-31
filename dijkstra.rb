require 'rubygems'
require 'algorithms'

# Uses the graph from http://www.youtube.com/watch?v=8Ls1RqHCOPw

infinity = 999999

start_node = 0;
end_node = nil; # Will print out path + distance from start to end, if nil will print all paths

node_labels = ["A", "B", "C", "D", "E", "F", "G", "H"]

edge_weights = [
#     A         B         C         D         E         F         G         H
  [       0,       20, infinity,       80, infinity, infinity, infinity, infinity], # A
  [infinity,        0, infinity, infinity, infinity,       10, infinity, infinity], # B
  [infinity, infinity,        0,       10, infinity,       50, infinity,       20], # C
  [infinity, infinity,       10,        0, infinity, infinity,       20, infinity], # D
  [infinity,       50, infinity, infinity,        0, infinity,       30, infinity], # E
  [infinity, infinity,       10,       40, infinity,        0, infinity, infinity], # F
  [      20, infinity, infinity, infinity, infinity, infinity,        0, infinity], # G
  [infinity, infinity, infinity, infinity, infinity, infinity, infinity,        0]  # H
]

visited_node = Array.new(8, false)

distance_from_start = Array.new(8, infinity)
distance_from_start[start_node] = 0;

previous_node_for_node = Array.new(8, nil)

priority_queue = Containers::PriorityQueue.new

priority_queue.push(start_node, distance_from_start[start_node] * -1)

while !priority_queue.empty?
  next_node = priority_queue.pop
  visited_node[next_node] = true
  edge_weights[next_node].each_with_index do |edge_weight,i|
    if edge_weight != 0 && edge_weight != infinity
      new_distance = distance_from_start[next_node] + edge_weight
      if new_distance < distance_from_start[i] && !visited_node[i]
        distance_from_start[i] = new_distance
        previous_node_for_node[i] = next_node
        priority_queue.push(i, new_distance * -1)
      end
    end
  end
end

# Print of results
if end_node.nil?
  puts "Distance from start:"
  node_labels.each_with_index do |node_label, i|
    if distance_from_start[i] == infinity
      puts "#{node_label}: infinity"
    else 
      puts "#{node_label}: #{distance_from_start[i]}"
    end
  end

  puts "--------------------"

  puts "Paths:"
  node_labels.each_with_index do |node_label, i|
    if previous_node_for_node[i].nil?
      puts "#{node_label}: none"
    else
      print "#{node_label}: "
      current_node = i
      while current_node != start_node
        print "#{node_labels[current_node]} < "
        current_node = previous_node_for_node[current_node]
      end
      puts node_labels[start_node]
    end
  end
else
  puts "Distance from #{node_labels[start_node]} to #{node_labels[end_node]}: #{distance_from_start[end_node]}"
  puts "--------------------"
  puts "Path from #{node_labels[start_node]} to #{node_labels[end_node]}:"
  current_node = end_node
  while current_node != start_node
    print "#{node_labels[current_node]} < "
    current_node = previous_node_for_node[current_node]
  end
  puts node_labels[start_node]
end