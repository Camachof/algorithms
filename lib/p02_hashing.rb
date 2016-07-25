CONST = "this is just for xoring".to_s.unpack('b*')[0]

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    binary_self = self.to_s.unpack('b*')[0]
    hashed = CONST.to_i ^ binary_self.to_i
  end
end

class String
  def hash
    self.split("").hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    array = []
    self.each do |key, value|
      array << [key, value]
    end

    array.sort.hash
  end
end
