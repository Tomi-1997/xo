#/C:/Perl/bin/perl
use strict;
use warnings;
use constant false => 0;
use constant true  => 1;

# Players info
my $turnIndex = 0;
my @playerId = (1, 2); 
my %playerSymbol = (
    1 => 'X',
    2 => 'O',);

# Board info
my $EC = '_';
my @board = ([$EC, $EC, $EC],
             [$EC, $EC, $EC],
             [$EC, $EC, $EC]);

# Start game
my $finished = false;
my $currPlayer = $playerId[$turnIndex];
print "Player $currPlayer, it is your turn!\n";

while ( not $finished )
{
    my $a = randInt(0, 2); ## Can \ should be swapped with two ints from input
    my $b = randInt(0, 2);

    # Input is already taken
    if ($board[$a][$b] ne $EC)
    {
        next;
    }
    
    updateBoard(\@board, $a, $b, $playerSymbol{$currPlayer});
    printBoard(@board);
    if (hasWinner(\@board, $EC))
    {
        print "~~~~~~ Player $currPlayer won! ~~~~~~ ";
        exit(0);
    }

    if (isTie(\@board, $EC))
    {
        print "~~~~~~ It's a tie! ~~~~~~ ";
        exit(0);    
    }

    $turnIndex = ($turnIndex + 1) % 2;
    $currPlayer = $playerId[$turnIndex];
    print "Player $currPlayer, it is your turn!\n";
}

sub hasWinner
{
    my @board = @{$_[0]}; # Expecting an array for the first arguments, rest are scalars
    shift;
    my ($EC) = @_;

    my $winner = false;
    
    # Two diagonal lines
    $winner = $winner || (($board[0][0] eq $board[1][1]) 
                      && (($board[1][1] eq $board[2][2])) 
                      && (($board[2][2] ne $EC)));

    $winner = $winner || (($board[0][2] eq $board[1][1]) 
                      && (($board[1][1] eq $board[2][0])) 
                      && (($board[0][2] ne $EC)));

    if ($winner)
    {
        return $winner;
    }
    # Check straight lines
    for (my $i = 0; $i < 3; $i++)
    {
        $winner = $winner || (($board[$i][0] eq $board[$i][1]) 
                          && (($board[$i][2] eq $board[$i][1])) 
                          && (($board[$i][2] eq $board[$i][0])
                          && ($board[$i][0] ne $EC)));


        $winner = $winner || (($board[0][$i] eq $board[1][$i]) 
                          && (($board[2][$i] eq $board[1][$i])) 
                          && (($board[0][$i] eq $board[2][$i])
                          && ($board[0][$i] ne $EC)));
    }
    return $winner;
}

sub isTie
{
    my @board = @{$_[0]}; # Expecting an array for the first arguments, rest are scalars
    shift;
    my ($char) = @_;

    for (my $i = 0; $i < 3; $i++)
    {
        for (my $j = 0; $j < 3; $j++)
        {
            if ($board[$i][$j] eq $char)
            {
                return false;
            }
        }
    }
    return true;
}

sub randInt
{
    my ($a, $b) = @_;
    return (int(rand($b + 1 - $a) + $a));
}

sub updateBoard
{
    my @board = @{$_[0]}; # Expecting an array for the first arguments, rest are scalars
    shift;
    my ($i, $j, $symbol) = @_;
    if ($i > 2 || $j > 2 || $i < 0 || $j < 0)
    {
        return();
    }
    $board[$i][$j] = $symbol;
}

sub printBoard
{
    my @board = @_;
    for (my $i = 0; $i < 3; $i++)
    {
        for (my $j = 0; $j < 3; $j++)
        {
            print "$board[$i][$j] ";
        }
        print "\n";
    }
}