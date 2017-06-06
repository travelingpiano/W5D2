#all types of sorting functions
require 'byebug'
class Array
  def merge_sort(&prc)
    prc ||= Proc.new{|num1,num2| num1 < num2}
    return self if length == 1
    middle_num = length/2
    subarray1 = self[0...middle_num].merge_sort(&prc)
    subarray2 = self[middle_num..-1].merge_sort(&prc)
    return merge(subarray1,subarray2,&prc)
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
        when -1,0, true
          ans << left.shift
        else
          ans << right.shift
        end
      end
    end
    ans
  end

  def bubble_sort(&prc)
    prc ||= Proc.new{|num1,num2| num1<num2}
    ans = self.dup
    ans[0...-1].each_index do |idx1|
      (idx1+1...ans.length).each do |idx2|
        case prc.call(ans[idx1],ans[idx2])
        when 1, false
          ans[idx1],ans[idx2]=ans[idx2],ans[idx1]
        end
      end
    end
    ans
  end

  def bubble_sort!(&prc)
    prc ||= Proc.new{|num1,num2| num1<num2}
    ans = self
    ans[0...-1].each_index do |idx1|
      (idx1+1...ans.length).each do |idx2|
        case prc.call(ans[idx1],ans[idx2])
        when 1, false
          ans[idx1],ans[idx2]=ans[idx2],ans[idx1]
        end
      end
    end
    ans
  end

  def quick_sort(&prc)
    prc ||= Proc.new{|num1,num2| num1<num2}
    return self if length <= 1
    subarray1 = self.select{|num| num < self.first}
    subarray2 = self.select{|num| num > self.first}
    subarray1.quick_sort(&prc) + [self.first] + subarray2.quick_sort(&prc)
  end

  def bin_search(val)
    return nil if self[0] != val && self.length == 1 || self.length == 0
    middle_num = length/2
    return middle_num if self[middle_num] == val
    if val > self[middle_num] && middle_num < length-1
      ans = self[middle_num+1..-1].bin_search(val)
      return ans ? ans + middle_num  : nil
    else
      return self[0...middle_num].bin_search(val)
    end
    nil
  end
end




arr1 = (1..8).to_a.shuffle
p arr1
p arr1.merge_sort

arr = [5,6,7,1,4,8]
p arr.bubble_sort
p arr
p arr.bubble_sort!{|num1,num2| num1 < num2}
p arr
#
arr2 = (1..5).to_a.shuffle
p arr2.quick_sort
p arr2
# p arr2.quick_sort!
# p arr2
p arr
puts "hiii"
p arr.bin_search(2)
