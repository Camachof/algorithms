require 'byebug'
require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new
    self.each { |int| heap.push(int) }

    while heap.count >= 1
      self << heap.extract
      self.shift
    end

    self

  end
end
