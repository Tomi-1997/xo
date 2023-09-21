require "matrix"

def play(b, p1, p2)

    curr_p = p1
    while (true)

        # Get input
        b.print_board
        puts "It is the turn of player #{curr_p.id}!"
        update_ans = false
        while (update_ans == false)
            a1 = rand(0..2)
            a2 = rand(0..2)
            update_ans = b.update(a1, a2, curr_p)
        end
        
        # Update and get current state
        current_state = b.state
        if (current_state == CONTINUE)
            curr_p = curr_p == p1 ? p2 : p1
            next
        end

        if (current_state == TIE)
            puts "It's a tie!"
            break
        end

        puts "Player #{curr_p.id} won!"
        break
    end
    # Print board before exiting
    b.print_board
end

class Board
    def initialize(empty_char)
        @my_board = Matrix.build(3, 3) { empty_char }
        @ec = empty_char
    end

    def print_board()
        puts
        @my_board.to_a.each {|r| puts "[ #{r.join('   ')} ]"} ## r.join to print without quotes
    end

    def update(i, j, player)
        # Check out of bounds
        if (i > @my_board.row_size || i < 0 || j > @my_board.column_size || j < 0)
            return false
        end
        # Check if this position is already updated
        if (@my_board[i, j] != @ec)
            return false
        end
        # Update
        @my_board[i, j] = player.symbol
        return true
    end

    def state()
        ans = CONTINUE

        ## Diagonal checks
        diagonal_win = @my_board[1, 1] != @ec
        same_diags = @my_board[0, 0] == @my_board[1, 1] && @my_board[1, 1] == @my_board[2, 2]
        same_diags = same_diags || @my_board[2, 0] == @my_board[1, 1] && @my_board[1, 1] == @my_board[0, 2]
        diagonal_win = diagonal_win && (same_diags)

        if (diagonal_win)
            return WIN
        end

        ## Sideway checks
        for i in 0..2
            
            if (@my_board.row(i).all? {|x| x == @my_board[i, 0] && x != @ec})
                return WIN
            end

            if (@my_board.column(i).all? {|x| x == @my_board[0, i] && x != @ec})
                return WIN
            end

        end

        ## Tie check
        if (@my_board.none? {|x| x == @ec} )
            ans = TIE
        end

        return ans
    end

end

class Player
    # Getters
    attr_reader :id
    attr_reader :symbol
    def initialize(id, symbol)
        @id = id
        @symbol = symbol
    end
end

WIN = 0
CONTINUE = -1
TIE = -2
empty_char = '_'
b = Board.new(empty_char)
p1 = Player.new(1, 'X')
p2 = Player.new(2, 'O')
play(b, p1, p2)