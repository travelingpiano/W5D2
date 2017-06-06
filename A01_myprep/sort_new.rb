#all types of sorting functions

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
        ans.concat(right)
        right = []
      elsif right.empty?
        ans.concat(left)
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
    ans.bubble_sort!(&prc)
  end

  def bubble_sort!(&prc)
    prc ||= Proc.new{|num1,num2| num1<num2}
    self[0...-1].each_index do |indx1|
      (indx1+1...length).each do |indx2|
        self[indx1],self[indx2] = self[indx2],self[indx1] if self[indx1] > self[indx2]
      end
    end
    self
  end

  def quick_sort!(&prc)
  end

  def quick_sort(&prc)
    return self if length <= 1
    prc ||= Proc.new{|num1,num2| num1<num2}
    subarray1 = self.select{|numz| numz < self[0]}
    subarray2 = self.select{|numz| numz > self[0]}
    subarray1.quick_sort + [self[0]] + subarray2.quick_sort
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

arr = [5,6,7,1,4,8]
p arr.bubble_sort
p arr
p arr.bubble_sort!{|num1,num2| num1 > num2}
p arr

arr1 = (1..8).to_a.shuffle
p arr.merge_sort

arr2 = (1..5).to_a.shuffle
puts "quick sort ans"
p arr2.quick_sort
p arr2
p arr2.quick_sort!
p arr2
arr2 = (1..8).to_a
p arr2
p arr2.bin_search(4)
