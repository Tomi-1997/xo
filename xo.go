package main

import (
	"fmt"
	"math/rand"
)

func main() {

	empty_char := "_"
	myBoard := getBoard(empty_char)
	playersSymbol := [2]string{"♥", "♣"}
	playersId := [2]int{1, 2}
	index := 0

	for {

		// Print prompt, get two ints
		printBoard(myBoard)
		fmt.Printf("It is the turn of player %d\n", playersId[index])
		rnd_pair := rndPairBetween(0, 2, myBoard, empty_char)
		a, b := rnd_pair[0], rnd_pair[1]

		// Update board, check for win \ tie
		updateBoard(a, b, playersSymbol[index], myBoard, empty_char)
		if checkWin(myBoard, empty_char) {
			fmt.Printf("Player %d won!\n", playersId[index])
			break
		}

		if checkTie(myBoard, empty_char) {
			fmt.Println("It's a tie!")
			break
		}

		//  No win or tie yet, switch turn and keep playing
		index = (index + 1) % 2
	}
	printBoard(myBoard)
}

func checkWin(myBoard [][]string, empty_char string) bool {
	diagonals := false

	if myBoard[0][0] == myBoard[1][1] && myBoard[1][1] == myBoard[2][2] {
		diagonals = true
	}

	if myBoard[2][0] == myBoard[1][1] && myBoard[1][1] == myBoard[0][2] {
		diagonals = true
	}

	if myBoard[1][1] != empty_char && diagonals {
		return true
	}

	for i := 0; i < 3; i++ {
		if myBoard[i][0] != empty_char &&
			myBoard[i][0] == myBoard[i][1] &&
			myBoard[i][1] == myBoard[i][2] {
			return true
		}

		if myBoard[0][i] != empty_char &&
			myBoard[0][i] == myBoard[1][i] &&
			myBoard[1][i] == myBoard[2][i] {
			return true
		}
	}

	return false
}

func checkTie(myBoard [][]string, empty_char string) bool {
	for _, elem := range myBoard {
		if contains(elem, empty_char) {
			return false
		}
	}
	return true
}

func contains(array []string, value string) bool {
	for _, elem := range array {
		if elem == value {
			return true
		}
	}
	return false
}

func randomBetween(min int, max int) int {
	return rand.Intn(max-min+1) + min
}

func rndPairBetween(min int, max int, board [][]string, ec string) [2]int {
	for {
		ans := [2]int{randomBetween(0, 2), randomBetween(0, 2)}
		if board[ans[0]][ans[1]] == ec {
			return ans
		}
	}
}

func getBoard(ec string) [][]string {
	ans := make([][]string, 3)
	for i := 0; i < 3; i++ {
		for j := 0; j < 3; j++ {
			ans[i] = append(ans[i], string(ec))
		}
	}
	return ans
}

func printBoard(board [][]string) {
	for _, elem := range board {
		fmt.Println(elem)
	}
}

func updateBoard(i int, j int, value string, board [][]string, ec string) {
	if board[i][j] != ec {
		return
	}
	board[i][j] = value
}
