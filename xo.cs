const char space = '\t';
const char EC = '-'; // empty char
char[, ] board = {
                {EC, EC, EC},
                {EC, EC, EC},
                {EC, EC, EC}
                };
const int gameCONTINUE = -1;
const int gameTIE = 0;
const int gameP1 = 1;
const int gameP2 = 2;

bool notOver = true;
int turn = gameP1;
while (notOver)
{
    Console.Clear();
    printMatrix(board);
    Console.WriteLine("Player {0}, enter two digits from 0 to 2", turn);
    bool valid = updatePosition(board, turn); // Get (i, j) from user input and update
    

    if (!valid) continue;
    int winner = getWinner(board, turn);
    if (winner == gameCONTINUE)
    {
        if (turn == gameP1) turn = gameP2; else turn = gameP1;
        continue; // No winner, continue
    }
    
    printMatrix(board);
    if (winner != gameTIE)
        Console.WriteLine("Player {0} wins!", winner);
    else
        Console.WriteLine("It's a tie!");
    notOver = false;

    break;
}


static int getWinner(char[, ] b, int t)
{
    // Diagonal
    bool same = b[0, 0] == b[1, 1];
    same = same && b[1, 1] == b[2, 2]; 
    same = same && b[0, 0] != EC;
    if (same) return t;

    for (int i = 0; i < 3; i ++)
    {
        // Vertical
        same = b[i, 0] == b[i, 1];
        same = same && b[i, 1] == b[i, 2]; 
        same = same && b[i, 0] != EC;

        if (same) return t;

        // Horizontal
        same = b[0, i] == b[1, i];
        same = same && b[1, i] == b[2, i]; 
        same = same && b[0, i] != EC;

        if (same) return t;
    }
    if (contains(b, EC)) return gameCONTINUE;
    return gameTIE;
}


static bool contains(char[, ] b, char ec)
{
    for (int i = 0; i < b.GetLength(0); i++)
    {
        for (int j = 0; j < b.GetLength(1); j++)
        {
            if (b[i, j] == ec) return true;
        }
    }
    return false;
}


static bool updatePosition(char[, ] b, int t)
{
    int i, j;
    try
    {
        String? input = Console.ReadLine();
        if (input == null) return false;
        String[] splitLine = input.Split();
        if (splitLine == null || splitLine.Length != 2) return false;
        i = int.Parse(splitLine[0]);
        j = int.Parse(splitLine[1]);

        if (b[i, j] != EC) return false;

        b[i, j] = turnToChar(t);
    }
    catch (Exception)
    {
        return false;
    }
    return true;
}


static char turnToChar(int t)
{
    if (t == 1) return 'X';
    return 'O';
}


static void printMatrix(char[, ] b)
{
    for (int i = 0; i < b.GetLength(0); i++)
    {
        for (int j = 0; j < b.GetLength(1); j++)
        {
            Console.Write("{0}{1}", b[i, j], space);
        }
        Console.WriteLine();
    }
}