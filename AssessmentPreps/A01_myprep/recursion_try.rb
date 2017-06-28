#Homework stuff
def sum_to(num)
  return num if num == 1
  return nil if num < 1
  num+sum_to(num-1)
end

def add_numbers(arr)
  return arr[0] if arr.length <= 1
  arr[-1] + add_numbers(arr[0...-1])
end

def gamma_fnc(num)
  return nil if num == 0
  return 1 if num <= 2
  (num-1)*gamma_fnc(num-1)
end

def ice_cream_shop(flavors,favorite)
  return flavors[0] == favorite if flavors.length <= 1
  return true if flavors.shift == favorite
  ice_cream_shop(flavors,favorite)
end

def reverse(str_in)
  return str_in if str_in.length <= 1
  str_in[-1] + reverse(str_in[0...-1])
end

#exponentiation
def exp(num,power)
  return num if power == 1
  return 1 if power == 0
  num*exp(num,power-1)
end

class Array
  def deep_dup
    ans = []
    self.each do |el|
      if el.is_a?(Array)
        ans << el.deep_dup
      else
        ans << el
      end
    end
    ans
  end
end

def fibonacci(num)
  return 1 if num == 1
  return [1,1] if num == 2
  prev_ans = fibonacci(num-1)
  ans = prev_ans
  ans << prev_ans[-2]+prev_ans[-1]
  ans
end

puts "sum to"
p sum_to(5)  # => returns 15
p sum_to(1)  # => returns 1
p sum_to(9)  # => returns 45
p sum_to(-8)  # => returns nil
puts "add numbers"
p add_numbers([1,2,3,4]) # => returns 10
p add_numbers([3]) # => returns 3
p add_numbers([-80,34,7]) # => returns -39
p add_numbers([]) # => returns nil
puts "gamma_fnc"
p gamma_fnc(0)  # => returns nil
p gamma_fnc(1)  # => returns 1
p gamma_fnc(4)  # => returns 6
p gamma_fnc(8)  # => returns 5040
puts "gamma_fnc"
p ice_cream_shop(['vanilla', 'strawberry'], 'blue moon')  # => returns false
p ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea')  # => returns true
p ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio')  # => returns false
p ice_cream_shop(['moose tracks'], 'moose tracks')  # => returns true
p ice_cream_shop([], 'honey lavender')  # => returns false
puts "reverse"
p reverse("house") # => "esuoh"
p reverse("dog") # => "god"
p reverse("atom") # => "mota"
p reverse("q") # => "q"
p reverse("id") # => "di"
p reverse("") # => ""
puts "exp"
p exp(2,3) # => 8
p exp(2,0) # => 1
puts "deep dup"
robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]
new_arr = robot_parts.deep_dup
new_arr[1] << "LEDS"
p new_arr
p robot_parts
puts "fibonacci"
p fibonacci(5)
p fibonacci(2)
