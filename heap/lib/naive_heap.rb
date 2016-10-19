require 'byebug'
# naive MinHeap

class MinHeap
  attr_accessor :root

  def initialize(root)
    @store = [root]
    @root = @store.first
  end

  def parent(idx)
    return 0 if idx == 0
    (idx - 1) / 2
  end

  def children(idx)
    return nil if ((idx * 2) + 1) > @store.length - 1
    [(idx * 2) + 1, (idx * 2) + 2]
  end

  def add(var)
    @store.push(var)
    self.heapify_up(@store.length - 1)
  end

  def heapify_up(idx)
    return idx if @store[idx] >= @store[self.parent(idx)]

    parent = self.parent(idx)
    @store[idx], @store[parent] = @store[parent], @store[idx]
    heapify_up(parent)
  end

  def heapify_down(idx)
    byebug
    return idx if children(idx).nil? || @store[idx] <= @store[self.children(idx).min]

    children = self.children(idx)
    new_idx = nil
    children.each do |child|
      next if child.nil?
      if @store[child] < @store[idx]
        @store[child], @store[idx] = @store[idx], @store[child]
        new_idx = child
        break
      end
    end

    heapify_down(new_idx)
  end

  def get_min
    @store[@store.length - 1], @store[0] = @store[0], @store[@store.length - 1]

    min = @store.pop
    heapify_down(0)
    min
  end
end

heap = MinHeap.new(3)
heap.add(8)
heap.add(10)
heap.add(4)
heap.add(15)
heap.add(1)
heap.get_min
byebug
heap
