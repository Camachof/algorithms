require_relative "static_array"
require "byebug"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @start = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= length
    @store[check_index(index)]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" if index >= length
    @store[check_index(index)] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    poped = @store[(@start + @length - 1) % 8]
    @length -= 1
    poped
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    buff_length = check_index(@length)
    @store[buff_length] = val
    @length += 1
    @store
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    shifted = @store[@start]
    @start = (@start + 1 ) % @capacity
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start = check_index(-1)
    @store[@start] = val
    @length += 1
    @store
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    (@start + index) % @capacity
  end

  def resize!
    @capacity *= 2
    temp_store = StaticArray.new(@capacity)
    0.upto(@length - 1) do |index|
      temp_store[index] = @store[index]
    end
    @store = temp_store
  end
end
