require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= num_buckets
    @count += 1
    self[key] << key
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    @count -= 1
    self[key].delete(key)
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store.flatten
    @store = Array.new(num_buckets * 2) { Array.new }
    old_store.each do |element|
      self[element] << element
    end
  end
end
