require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless @count == num_buckets
      idx = num.hash % num_buckets
      @store[idx] << num
    else
      resize!
      idx = num.hash % num_buckets
      @store[idx] << num
    end
    @count += 1
  end

  def remove(num)
    idx = num.hash % num_buckets
    if include?(num)
      @store[idx].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    idx = num.hash % num_buckets
    @store[idx].include?(num)
  end

  private


  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    double_bucket = num_buckets * 2

    temp = Array.new(double_bucket) { Array.new }
    @store.each do |array|
      until array.empty?
        num = array.pop
        temp[num % double_bucket] << num
      end
    end
    @store = temp
  end
end
