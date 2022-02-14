require "byebug"

class Array
        
    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&prc)
        arr = []
        self.my_each do |ele|
            arr << ele if prc.call(ele)
        end
        arr
    end

    def my_reject(&prc)
        arr = []
        self.my_each do |ele|
            arr << ele if ! prc.call(ele)
        end
        arr
    end

    def my_any?(&prc)
        arr = []
        self.my_each do |ele|
            return true if prc.call(ele)
        end
        false
    end

    def my_all?(&prc)
        arr = []
        self.my_each do |ele|
            return false if ! prc.call(ele)
        end
        true
    end

    def my_flatten
        # debugger
        return [self] if ! self.is_a? Array
        flattened = []
        self.each do |el|
            flattened << el if el
            flattened += el.my_flatten
        end
        flattened
    end

    def my_zip(*args)
        arr = Array.new(self.length) { Array.new(args.length + 1, nil) }

        self.each.with_index do |ele, i|
            arr[i][0] = ele
        end

        # args = [ 4, 5, 6 ], [ 7, 8, 9 ]
        # arg = [ 7, 8, 9 ]
        # i = 2

        # [ [1, , ] [2, , ] [3, , ] ]

        i = 1

        args.each do |arg| 
            arg.each.with_index do |ele, el_i|
                arr[el_i][i] = ele if el_i < self.length
            end
            i += 1
        end
        arr
    end
    
end

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# return_value = [1, 2, 3].my_each do |num|
#     puts num
#    end.my_each do |num|
#     puts num
#    end
#    # => 1
#        2
#        3
#        1
#        2
#        3
   
#    p return_value  # => [1, 2, 3]

#    a = [1, 2, 3]
#    p a.my_select { |num| num > 1 } # => [2, 3]
#    p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]