require "byebug";
include Enumerable

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
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    !get(key).nil?
  end

  def insert(key, val)
    last_link = @tail.prev
    new_link = Link.new(key, val)

    last_link.next = new_link
    new_link.prev = last_link
    new_link.next = @tail
    @tail.prev = new_link
    new_link
  end

  def remove(key)
    current = @head
    to_remove = nil
    until current.next.nil?
      current = current.next
      to_remove = current if current.key == key
    end

    prev_link = to_remove.prev
    next_link = to_remove.next

    prev_link.next = next_link
    next_link.prev = prev_link

    to_remove.prev = nil
    to_remove.next = nil
  end

  def each
    current = @head.next
    until current == @tail
      yield(current)
      current = current.next
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
