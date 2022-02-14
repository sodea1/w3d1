class Board

    attr_reader :size
    # This Board#print method is given for free and does not need to be modified
    # It is used to make your game playable.
    def print
        @grid.each { |row| p row }
    end

    def initialize(size)
        @size = size
        @grid = Array.new(size) { Array.new(size) }
    end

    def [](pos) # [4, 4]
        row = pos[0]
        col = pos[1]
        @grid[row][col]
    end

    def []=(pos, val)
        row = pos[0]
        col = pos[1]
        @grid[row][col] = val
    end

    def complete_row?(mark)
        @grid.each do |row|
            return true if row.uniq == [mark]
        end

        false
    end

    def complete_col?(mark)
        columns = @grid.transpose
        columns.each do |col|
            return true if col.uniq == [mark]
        end

        false
    end

    def complete_diag?(mark)
        l = @grid.length
        forwards = []
        backwards = []
        
        (0...l).each do |i|
            forwards << @grid[i][i]
            backwards << @grid[i][-i - 1]
            # @grid.each.with_index do |row, i|
        end

        return true if forwards.uniq == [mark] || backwards.uniq == [mark]

        false
    end

    def winner?(mark)
        complete_col?(mark) || complete_row?(mark) || complete_diag?(mark)
    end
end


