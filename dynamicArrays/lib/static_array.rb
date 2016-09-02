# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length)
  end

  # O(1)
  def [](index)
    return nil if index > @store.length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    # raise "passed allocated memory" if index > @store.length
    @store[index] = value
  end

  protected
  attr_accessor :store
end
