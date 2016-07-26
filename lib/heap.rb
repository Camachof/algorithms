require "byebug"

class BinaryMinHeap
  def initialize(&prc)
    @store = Array.new
  end

  def count
  end

  def extract
  end

  def peek
  end

  def push(val)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    children_idx = []
    i = 1
    while i <= 2
      child_idx = 2 * parent_index + i
      children_idx << child_idx if child_idx < len
      i += 1
    end

    children_idx
  end

  def self.parent_index(child_index)
    parent_idx = (child_index - 1) / 2
    raise "root has no parent" if parent_idx < 0
    parent_idx
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    children = BinaryMinHeap.child_indices(len, parent_idx)
    prc ||= Proc.new { |parent, child| parent <=> child }
    return array if children.length == 0

    # if children.length == 1
    #   min_child = array[children[0]]
    # elsif children.length == 2
    #   min_child = prc.call(array[children[0]], array[children[1]]) == 1 ? array[children[1]] : array[children[0]]
    # end

    children.each do |child_idx|
      if prc.call(array[parent_idx], array[child_idx]) == 1
        array[parent_idx], array[min_child] = array[min_child], array[parent_idx]

        new_parent_idx = min_child
        BinaryMinHeap.heapify_down(array, new_parent_idx, &prc)
      end
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    comparison = prc || Proc.new { |parent, child| parent <=> child }

    if comparison.call(array[parent_idx], array[child_idx]) == 1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]

      new_child_idx = parent_idx
      BinaryMinHeap.heapify_up(array, new_child_idx)
    end

    array
  end
end
