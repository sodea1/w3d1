class Array
        
    def my_each(&prc)
        self.length - 1.times { |el| prc.call(el) }  
        self  
    end

end

return_value = [1, 2, 3].my_each do |num|
    puts num
   end.my_each do |num|
    puts num
   end
   # => 1
       2
       3
       1
       2
       3
   
   p return_value  # => [1, 2, 3]