// Build
// kotlinc main.kt -include-runtime -d main.jar
// Run
// java -jar main.jar

val EMPTY_CHAR = '_'
val GAME_TIE = 0
val GAME_OVER = -1
val GAME_CONTINUE = -2
fun main()
{
    val myBoard = Board(EMPTY_CHAR)
    val playerOne = Player(1, 'X')
    val playerTwo = Player(2, 'O')
    
    var currentPlayer = playerOne
    while (true)
    {
        myBoard.print()
        val turnInt = currentPlayer.id
        println("Player $turnInt, enter a digits between 0 and 2")

        /* Currently - get two random numbers without override check */
        val (a, b) = getInts()
        myBoard.update(a, b, currentPlayer.symbol)
        val state = myBoard.gameState()

        if (state == GAME_CONTINUE) 
        {
            currentPlayer = if (currentPlayer == playerOne) playerTwo else playerOne
            continue
        }
        
        myBoard.print()
        if (state == GAME_TIE)
        {
            println("It's a tie!")
            break;
        }

        println("Player $turnInt won!")
        break;
    }
}

/* Reads two integers from input */
fun readInts() = readLine()!!.split(' ').map { it.toInt() }

/* Returns two random numbers */
fun getInts() = arrayOf((0..2).random(), (0..2).random())

class Player
{
    val id : Int
    val symbol : Char
    constructor(id_ : Int, symbol_ : Char)
    {
        id = id_
        symbol = symbol_
    }
}

class Board
{
    val b: Array< Array<Char> >
    constructor(emptyChar : Char)
    {
        b = Array(3) { Array(3) {emptyChar}}
    }

    fun print()
    {
        b.forEach{ println(it.contentToString()) }
    }

    fun update(i : Int, j : Int, sym : Char)
    {
        if (i < 0 || i > 2 || j < 0 || j > 2) return
        b[i][j] = sym
    }

    fun gameState() : Int
    {
        var emptyCharIn = false
        var over : Boolean
        
        // diagonals
        if (b[0][0] == b[1][1] && b[1][1] == b[2][2] && b[2][2] != EMPTY_CHAR) return GAME_OVER
        if (b[0][2] == b[1][1] && b[1][1] == b[2][0] && b[2][0] != EMPTY_CHAR) return GAME_OVER

        for (i in 0..2)
        {
            over = b[i][0] != EMPTY_CHAR
            over = over && b[i][0] == b[i][1] 
            over = over && b[i][1] == b[i][2]
            if  (over) return GAME_OVER

            over = b[0][i] != EMPTY_CHAR
            over = over && b[0][i] == b[1][i] 
            over = over && b[1][i] == b[2][i]
            if  (over) return GAME_OVER
        
            emptyCharIn = emptyCharIn || (EMPTY_CHAR in b[i])
        }
        
        if (!emptyCharIn) return GAME_TIE
        return GAME_CONTINUE
    }
}