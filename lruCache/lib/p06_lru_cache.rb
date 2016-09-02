require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      update_link!(@map[key])
      return @map[key].val
    else
      val = calc!(key)

      new_link = @store.insert(key, val)
      @map.set(key, new_link)

      eject! if count > @max
      val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.remove(link.key)
    @map.delete(link.key)

    @store.insert(link.key, link.val)
    @map.set(link.key, link)
  end

  def eject!
    link = @store.first
    byebug
    @store.remove(link.key)
    @map.delete(link.key)
    @store.last
  end
end
