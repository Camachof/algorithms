class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    if num > @max || num < 0
      return false
    else
      return true
    end
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    idx = num % num_buckets
    @store[idx] << num
  end

  def remove(num)
    idx = num % num_buckets
    if include?(num)
      @store[idx].delete(num)
    end
  end

  def include?(num)
    idx = num % num_buckets
    @store[idx].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless @count == num_buckets
      idx = num % num_buckets
      @store[idx] << num
    else
      resize!
      idx = num % num_buckets
      @store[idx] << num
    end
    @count += 1
  end

  def remove(num)
    idx = num % num_buckets
    if include?(num)
      @store[idx].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    idx = num % num_buckets
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
