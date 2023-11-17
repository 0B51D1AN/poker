package main

import (
	"fmt"
	"math/rand"
	"time"
)


type Deck struct {
	Cards []Card
}

func NewDeck() Deck {
	deck := Deck{}
	// Initialize the deck with cards
	for suit := 1; suit <= 4; suit++ {
		for face := 1; face <= 13; face++ {
			card := Card{Face: face, Suit: suit}
			deck.Cards = append(deck.Cards, card)
		}
	}
	return deck
}

func (d *Deck) Shuffle() {
	rand.Seed(time.Now().UnixNano())
	rand.Shuffle(len(d.Cards), func(i, j int) {
		d.Cards[i], d.Cards[j] = d.Cards[j], d.Cards[i]
	})
}

func (d *Deck) PopCard() Card {
	if len(d.Cards) > 0 {
		topCard := d.Cards[0]
		d.Cards = d.Cards[1:]
		return topCard
	} else {
		// Handle the case where the deck is empty
		// For simplicity, returning an empty card here.
		fmt.Println("Deck is empty")
		return Card{}
	}
}

func (d Deck) ShowDeck() {
	for i, c := range d.Cards {
		c.printCard()
		fmt.Print(" ")
		if (i+1)%13 == 0 {
			fmt.Println()
		}
	}
	fmt.Println()
}