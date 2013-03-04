require 'thread'


class RubySimpleActor

  @@MAX_MESSAGE_PER_LOOP = 10

  def on_receive(msg); raise "Method on_receive(msg) is not implemented"; end

  def dequeue
    count = 0

    #puts "#{MSG_QUEUE.size}"

    while(MSG_QUEUE.size > 0)

      if(count > @@MAX_MESSAGE_PER_LOOP)
        count = 0
        sleep(0.05)
      end

      value = MSG_QUEUE.pop
      on_receive value
      count = count + 1
    end
  end

  MSG_QUEUE = Queue.new

  def initialize
    @MSG_LISTENER = Thread.new(self) do |ref|

      while(true)
        ref.dequeue()
        Thread.stop
      end
    end
    @MSG_LISTENER.run
  end


  def send msg
    MSG_QUEUE.push(msg)
    if(@MSG_LISTENER.stop?)
      @MSG_LISTENER.run
    end
  end

  def < msg
    self.send(msg)
  end

  def join
    @MSG_LISTENER.join
    rescue Exception => msg
  end
end




