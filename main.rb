require "./rubySimpleActor"

class RingNode < RubySimpleActor

  def setId(id)
    @id = id
  end

  def set_next(next_node)
    @next = next_node
  end

  def on_receive msg

    puts "Node@#{@id}: #{msg}"

    if(@next)
      @next.send("pong")
    end
  end
end


nodes = []
(0..10).each do |n|
  node = RingNode.new
  node.setId(n)
  nodes = nodes.push(node)
end

(0..10).each do |n|
  nodes[n].set_next(nodes[(n+1)%nodes.size])
end

nodes[0] < "pong"
nodes[0].join()

puts("End actor program")