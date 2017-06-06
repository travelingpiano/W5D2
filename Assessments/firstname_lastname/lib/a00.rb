# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  str = str.split(' ')
  str.map! do |word|
    cs_word(word,shift)
  end
  str.join(' ')
end

def cs_word(word,shift)
  alpha_arr = ("a".."z").to_a
  word = word.chars
  word.map! do |let|
    cur_loc = alpha_arr.find_index(let)
    if cur_loc < 26-shift
      alpha_arr[cur_loc+shift]
    else
      alpha_arr[cur_loc+shift-26]
    end
  end
  word.join('')
end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

def digital_root(num)
  flag = 1
  #break number into array
  num_arr = []
  num.to_s.split('').each do |numz|
    num_arr << numz.to_i
  end
  
  while flag == 1
    sum = num_arr.reduce(:+)
    if sum < 10
      flag = 0
    else
      num_arr = []
      sum.to_s.split('').each do |numz|
        num_arr << numz.to_i
      end
    end
  end
  sum
end

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)

end

class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum
    ans = []
    self.each_index do |ind1|
      self.each_index do |ind2|

        if ind1 < ind2
          ans << [ind1,ind2] if self[ind1] + self[ind2] == 0
        end
      end
    end
    ans
  end
end

class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)
    string_arr = self.chars
    ans = []
    string_arr.each_index do |index1|
      string_arr[index1..-1].each_index do |index2|
        wordz = string_arr[index1..index2].join('')

        ans << wordz if dictionary.include?(wordz)
      end
    end
    ans
  end
end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  ans = []
  (1..num).each do |numz|
    ans << numz if num%numz == 0
  end
  ans
end
