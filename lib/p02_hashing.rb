class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    self.each_with_index do |el, i|
      sum += (el.hash ^ i.hash)
    end
    sum
  end
end

class String
  CONSTANT = "s".ord
  def hash
    arr = self.split("").map {|el| el.ord }
    sum = 0
    arr.each_with_index do |el, i|
      sum += (el.hash ^ i.hash) ^ CONSTANT
    end
    sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0
    self.each do |k,v|
      sum += (k.hash ^ v.hash)
    end
    sum
  end
end
