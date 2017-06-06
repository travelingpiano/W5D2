def quicksort(arr)
  return [] if arr.length == 0
  return arr if arr.length == 1
  quicksort(arr.select{|ele| ele < arr[0]}) + [arr[0]] + quicksort(arr.select{|ele| ele > arr[0]})
end

p quicksort([4,2,5,1])
