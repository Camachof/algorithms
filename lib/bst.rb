require 'byebug'

class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if @root.nil?
      @root = BinarySearchTree.insert!(@root, value)
    else
      BinarySearchTree.insert!(@root, value)
    end
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    return BSTNode.new(value) if node.nil?
    if value <= node.value
      if node.left.nil?
        node.left = BSTNode.new(value)
        return node
      end
      insert!(node.left, value)
    else
      if node.right.nil?
        node.right = BSTNode.new(value)
        return node
      end
      insert!(node.right, value)
    end
  end

  def self.find!(node, value)
    return nil if node.nil?
    return node if node.value == value
    if node.value > value
      find!(node.left, value)
    elsif node.value < value
      find!(node.right, value)
    end
  end

  def self.preorder!(node)
    return [] unless node
    left = []
    right = []

    left = inorder!(node.left) if node.left
    right = inorder!(node.right) if node.right

    [node.value] + left + right
  end

  def self.inorder!(node)
    return [] unless node
    left = []
    right = []

    left = inorder!(node.left) if node.left
    right = inorder!(node.right) if node.right

    left + [node.value] + right
  end

  def self.postorder!(node)
    return [] unless node
    left = []
    right = []

    left = inorder!(node.left) if node.left
    right = inorder!(node.right) if node.right

    left.reverse + right.reverse + [node.value]
  end

  def self.height!(node)
    return -1 unless node

    1 + [height!(node.left), height!(node.right)].max
  end

  def self.max(node)
    return nil unless node
    return node if node.right.nil?
    max(node.right)
  end

  def self.min(node)
    return nil unless node
    return node if node.left.nil?
    min(node.left)
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right unless node.left

    node.left = BinarySearchTree.delete_min!(node.left)
  end

  def self.delete!(node, value)
    return nil unless node

    if value < node.value
      node.left = BinarySearchTree.delete!(node.left, value)
    elsif value > node.value
      node.right = BinarySearchTree.delete!(node.right, value)
    else
      return node.left unless node.right
      return node.right unless node.left
      t = node
      node = t.right.min
      node.right = BinarySearchTree.delete_min!(t.right)
      node.left = t.left
    end

    node
  end

end
