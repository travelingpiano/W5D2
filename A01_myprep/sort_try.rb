#all types of sorting functions
require 'byebug'
class Array
  def merge_sort(&prc)
    prc ||= Proc.new{|num1,num2| num1<num2}
    return self if length == 1
    middle_num = length/2
    subarray1 = self[0...middle_num].merge_sort(&prc)
    subarray2 = self[middle_num..-1].merge_sort(&prc)
    merge(subarray1,subarray2,&prc)
  end

  def merge(left,right,&prc)
    left = left.dup
    right = right.dup
    ans = []
    until left.empty? && right.empty?
      if left.empty?
        ans += right
        right = []
      elsif right.empty?
        ans += left
        left = []
      else
        case prc.call(left.first,right.first)
        when -1,0,true
          ans << left.shift
        else
          ans << right.shift
        end
      end
    end
    ans
  end

  def bubble_sort(&prc)
    ans = self.dup
    prc ||= Proc.new{|num1,num2| num1<num2}
    ans.bubble_sort!(&prc)
  end

  def bubble_sort!(&prc)
    prc ||= Proc.new{|num1,num2| num1<num2}
    self[0...-1].each_index do |indx1|
      (indx1+1...length).each do |indx2|
        self[indx1],self[indx2] = self[indx2],self[indx1] unless prc.call(self[indx1],self[indx2])
      end
    end
    self
  end

  def quick_sort(&prc)
    prc ||= Proc.new{|num1,num2| num1<num2}
    return self if length <= 1
    subarray1 = self.select{|num| num < self[0]}
    subarray2 = self.select{|num| num > self[0]}
    subarray1.quick_sort(&prc) + [self[0]] + subarray2.quick_sort(&prc)
  end

  def bin_search(val)
    return nil if empty?
    middle_num = length/2
    case val <=> self[middle_num]
    when -1
      self[0...middle_num].bin_search(val)
    when 0
      middle_num
    when 1
      result = self.drop(middle_num+1).bin_search(val)
      result ? result+middle_num+1 : result
    end
  end
end



puts "merge sort"
arr1 = (1..8).to_a.shuffle
p arr1
p arr1.merge_sort

puts "bubble sort"
arr = [5,6,7,1,4,8]
p arr.bubble_sort
p arr
p arr.bubble_sort!{|num1,num2| num1 < num2}
p arr

puts "quick sort"
arr2 = (1..5).to_a.shuffle
p arr2.quick_sort
p arr2
# p arr2.quick_sort!
# p arr2
puts "binary search"
p arr
p arr.bin_search(5)
