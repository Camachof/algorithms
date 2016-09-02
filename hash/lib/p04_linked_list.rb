class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    new_link = @head
    until new_link == @tail
      return new_link.val if new_link.key == key
      new_link = new_link.next
    end
  end

  def include?(key)
  end

  def insert(key, val)
    new_link = Link.new(key, val)
    @tail.prev.next = new_link
    new_link.prev = @tail.prev
    @tail.prev = new_link
    new_link.next = @tail
  end

  def remove(key)
    new_link = @head
    until new_link == @tail
      if new_link.key == key
        previous = new_link.prev
        new_link.prev.next = new_link.next
        new_link.next.prev = previous
        new_link.val = nil
        break
      end
      new_link = new_link.next
    end

  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
