# [RubySimpleActor]()

**RubySimpleActor** is a simple implementation of actors in Ruby. The goal of this project is to provide actor's architecture to some script that I run on computing grid. On this grid, I don't have access to all the ruby library, that is why I wanted to have a kind of actors that doesn't require any dependency.

I made this for personal use, so this should not be used in "serious project".

## Quick start

### Installation

import the file in your project: if you put it in a lib folder, add this a the beginning of your script:

```
require "./lib/rubySimpleActor"
```

you are now able to use RubySimpleActor in you program.

### Ring example

```

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

```