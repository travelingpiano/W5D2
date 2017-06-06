def sum_to(num)
  sum = num
  if num > 1
    num = num-1
    sum += sum_to(num)
  end
  sum
end

# def add_numbers(arr)
#   if arr.length > 1
#     arr[-1] + add_numbers(arr[0...-1])
#   elsif arr.length == 1
#     return arr[0]
#   else
#     return nil
#   end
# end

def add_numbers(arr)
  return nil if arr == []
  return arr[0] if arr.length == 1
  arr[-1] + add_numbers(arr[0...-1])
end

# def gamma_fnc(num)
#   sum = 1
#   if num > 1
#     sum  = num*gamma_fnc(num-1)
#   elsif num == 1
#     return num
#   else
#     return nil
#   end
#   return sum
# end

def gamma_fnc(num)
  return nil if num < 1
  return 1 if num == 1

  (num - 1) * gamma_fnc(num - 1)
end

def ice_cream_shop(arr,str_in)
  if arr.length > 1
    return arr[-1]==str_in || ice_cream_shop(arr[0...-1],str_in)
  else
    return arr[0]==str_in
  end
end

def reverse(str_in)
  ans = ""
  if str_in.length > 1
    ans += str_in[-1] + reverse(str_in[0...-1])
  else
    return str_in
  end
end

puts sum_to(5)
#puts add_numbers([1,2])
puts add_numbers([1,2,3,4]) # => returns 10
puts add_numbers([3]) # => returns 3
puts add_numbers([-80,34,7]) # => returns -39
puts add_numbers([]) # => returns nil

puts gamma_fnc(0)  # => returns nil
puts  gamma_fnc(1)  # => returns 1
puts  gamma_fnc(4)  # => returns 6
puts  gamma_fnc(8)  # => returns 5040

puts ice_cream_shop(['vanilla', 'strawberry'], 'blue moon')  # => returns false
puts  ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea')  # => returns true
puts  ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio')  # => returns false
puts  ice_cream_shop(['moose tracks'], 'moose tracks')  # => returns true
puts  ice_cream_shop([], 'honey lavender')  # => returns false

puts reverse("house") # => "esuoh"
puts  reverse("dog") # => "god"
puts  reverse("atom") # => "mota"
puts  reverse("q") # => "q"
puts  reverse("id") # => "di"
puts   reverse("") # => ""
