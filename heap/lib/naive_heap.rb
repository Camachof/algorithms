require 'byebug'
# naive MinHeap

class MinHeap
  def initializer
    @store = []
  end

  def root
    @store[0]
  end

  def add(var)
    @store.push(var)
    self.heapify_up(@store.length - 1)
  end

  def heapify_up

  end

  def min

  end
end
