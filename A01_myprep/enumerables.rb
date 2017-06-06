class Array

  def my_each(&prc)
    self.each do |el|
      prc.call(el)
    end
    #self
  end

  def my_select(&prc)
    ans = []
    self.each do |el|
      ans << el if prc.call(el)
    end
    ans
  end

  def my_reject(&prc)
    ans = []
    self.each do |el|
      ans << el unless prc.call(el)
    end
    ans
  end

  def my_any?(&prc)
    self.each do |el|
      return true if prc.call(el)
    end
    false
  end

  def my_all?(&prc)
    self.each do |el|
      return false unless prc.call(el)
    end
    true
  end

  def my_flatten
    ans = []
    self.each do |el|
      if el.is_a?(Array)
        ans += el.my_flatten
      else
        ans << el
      end
    end
    ans
  end

  def my_zip(*arg)
    ans = []
    self.each_index do |indx|
      new_el = [self[indx]]
      arg.each do |el|
        new_el << el[indx]
      end
      ans << new_el
    end
    ans
  end

  def my_rotate(num=1)
    ans = []
    self.each_index do |indx|
      ans[(indx-num)%self.length] = self[indx]
    end
    ans
  end

  def my_join(conn='')
    ans = ""
    self[0...-1].each do |el|
      ans += el + conn
    end
    ans + self[-1]
  end

  def my_reverse
    ans = self.dup
    self[0...length/2].each_index do |indx|
      ans[indx],ans[-1-indx] = ans[-1-indx],ans[indx]
    end
    ans
  end

end

return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end

a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []

a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true

p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
