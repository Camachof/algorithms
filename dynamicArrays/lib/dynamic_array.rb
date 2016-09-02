require_relative "static_array"
require "byebug"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    poped = @store[length - 1]
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
    @store
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    1.upto(@length - 1) do |index|
      @store[index - 1] = @store[index]
    end
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    (@length - 1).downto(0) do |index|
      @store[index + 1] = @store[index]
    end
    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    temp_store = StaticArray.new(@capacity)
    0.upto(@length - 1) do |index|
      temp_store[index] = @store[index]
    end
    @store = temp_store
  end
end
