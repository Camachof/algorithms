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
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
