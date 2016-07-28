require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    pivot = array.first
    left_s = array.select { |el| el < pivot }
    left_r = array.select { |el| el > pivot }

    left_s_r = QuickSort.sort1(left_s)
    right_s_r = QuickSort.sort1(right_s)

    left_s_r.concat([pivot]).concat(right_s_r)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    prc ||= Proc.new { |pivot, other| pivot <=> other }

    pivot_idx = QuickSort.partition(array, start, length, &prc)

    left_length = pivot_idx - start
    right_length = length - (left_length + 1)
    
    sort2!(array, start, left_length, &prc)
    sort2!(array, pivot_idx, right_length, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    i = start + 1
    pivot = start
    prc ||= Proc.new { |pivot, other| pivot <=> other }

    while i < (start + length)
      if prc.call(array[pivot], array[i]) == 1
        array[pivot + 1], array[i] = array[i], array[pivot + 1]
        array[pivot], array[pivot + 1] = array[pivot + 1], array[pivot]
        pivot += 1
      end
      i += 1
    end
    pivot
  end
end
