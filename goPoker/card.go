package main



import
(
	"fmt"
	"strconv"
)

 type Card struct 
 {

	Face int
	Suit int

 }

 func newCard(f, s int) Card {
	return Card{Face: f, Suit: s}
}
 
func NewCardFromString(card string) Card {
	face := 0
	switch card[0] {
	case 'A':
		face = 1
	case 'K':
		face = 13
	case 'Q':
		face = 12
	case 'J':
		face = 11
	case '1':
		face = 10
	default:
		face, _ = strconv.Atoi(string(card[0]))
	}

	suit := 0
	switch card[len(card)-1] {
	case 'S':
		suit = 1
	case 'H':
		suit = 2
	case 'C':
		suit = 3
	case 'D':
		suit = 4
	}

	return Card{Face: face, Suit: suit}
}

func (c Card) printCard() {
	switch c.Face {
	case 1:
		fmt.Print("A")
	case 13:
		fmt.Print("K")
	case 12:
		fmt.Print("Q")
	case 11:
		fmt.Print("J")
	case 14:
		fmt.Print("A")
	default:
		fmt.Print(c.Face)
	}

	switch c.Suit {
	case 1:
		fmt.Print("S")
	case 2:
		fmt.Print("H")
	case 3:
		fmt.Print("C")
	case 4:
		fmt.Print("D")
	}
}


