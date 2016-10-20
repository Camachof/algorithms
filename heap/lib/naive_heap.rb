class Heap
  attr_reader :store

  def initialize()
    @store = []
  end

  def root
    @store.first
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
end

class MinHeap < Heap
  def heapify_up(idx)
    return idx if @store[idx] >= @store[self.parent(idx)]

    parent = self.parent(idx)
    @store[idx], @store[parent] = @store[parent], @store[idx]
    heapify_up(parent)
  end

  def heapify_down(idx)
    return idx if children(idx).nil? || @store[idx] <= @store[self.children(idx).min]

    children = self.children(idx)
    if children.all? { |int| !int.nil? } && @store[children.first] > @store[children.last]
      @store[children[0]], @store[children[1]] = @store[children[1]], @store[children[0]]
    end

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
    # byebug if @store == [4, 7, 5, 12, 8]
    return @store.first if @store.length == 1

    @store[@store.length - 1], @store[0] = @store[0], @store[@store.length - 1]

    min = @store.pop
    heapify_down(0)
    min
  end
end

class MaxHeap < Heap
  def heapify_up(idx)
    return idx if @store[idx] <= @store[self.parent(idx)]

    parent = self.parent(idx)
    @store[idx], @store[parent] = @store[parent], @store[idx]
    heapify_up(parent)
  end

  def heapify_down(idx)
    return idx if children(idx).nil? || @store[idx] >= @store[self.children(idx).min]

    children = self.children(idx)
    new_idx = nil
    children.each do |child|
      next if child.nil?
      if @store[child] > @store[idx]
        @store[child], @store[idx] = @store[idx], @store[child]
        new_idx = child
        break
      end
    end

    heapify_down(new_idx)
  end

  def get_max
    @store[@store.length - 1], @store[0] = @store[0], @store[@store.length - 1]

    max = @store.pop
    heapify_down(0)
    max
  end
end

def running_median(numbers)
  return numbers.first if numbers.length == 1

  min_heap = MinHeap.new

  numbers.each_with_index do |int, idx|
    min_heap.add(int)
    dupped_heap = Marshal.load(Marshal.dump(min_heap))
    length = idx + 1

    if length % 2 == 0
      medians = []

      remove_number = (length / 2) - 1
      remove_number.times { dupped_heap.get_min }

      2.times { medians << dupped_heap.get_min }
      mean(medians)
    else
      remove_number = (length / 2)
      if remove_number == 0
        puts int
        next
      end

      remove_number.times { dupped_heap.get_min }
      puts dupped_heap.get_min
    end
  end
end

def mean(numbers)
  puts (numbers.first + numbers.last) / 2.0
end
