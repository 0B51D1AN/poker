package main

import
(
	"fmt"
	"sort"
)

type Player struct {
	Hand      []Card
	HandRank  string
	NumRank   int
	HRank  []Card
}

func NewPlayer() Player {
	return Player{
		Hand:      []Card{},
		HandRank:  "",
		NumRank:   -1,
		HRank:  []Card{},
	}
}

func (p *Player) PushCard(c Card) {
	p.Hand = append(p.Hand, c)
}

func (p Player) ShowHand() {
	for _, c := range p.Hand {
		c.printCard()
		fmt.Print(" ")
	}
	if p.HandRank == "" {
		fmt.Println()
	} else {
		fmt.Println(" - " + p.HandRank)
	}
}

func (p *Player) RankHand() {
	sort.Slice(p.Hand, func(i, j int) bool {
		return p.Hand[i].Face < p.Hand[j].Face
	})
		if p.isFlush() && p.isRoyalStraight() {
			p.HandRank = "Royal Flush"
			p.NumRank = 0
			return
		}
	
		if p.isStraightFlush() {
			p.HandRank = "Straight Flush"
			p.NumRank = 1
			if p.Hand[0].Face == 1 {
				p.HRank = append(p.HRank, p.Hand[0])
			} else {
				p.HRank = append(p.HRank, p.Hand[4])
			}
			return
		}
	
		if p.isFourOfKind() {
			p.HandRank = "Four of a Kind"
			p.NumRank = 2
			p.HRank = append(p.HRank, p.Hand[1])
			return
		}
	
		if p.isFullHouse() {
			p.HandRank = "Full House"
			p.NumRank = 3
			p.HRank = append(p.HRank, p.Hand[2])
			return
		}
	
		if p.isFlush() {
			p.HandRank = "Flush"
			p.NumRank = 4
			return
		}
	
		if p.isStraight() {
			p.HandRank = "Straight"
			p.NumRank = 5
			p.HRank = append(p.HRank, p.Hand[4])
			return
		}
	
		if p.isThreeOfKind() {
			p.HandRank = "Three of a Kind"
			p.NumRank = 6
			p.HRank = append(p.HRank, p.Hand[2])
			return
		}
	
		if p.isTwoPair() {
			p.HandRank = "Two Pair"
			p.NumRank = 7
			return
		}
	
		if p.isPair() {
			p.HandRank = "Pair"
			p.NumRank = 8
			return
		}
	
		p.HandRank = "High Card"
		p.NumRank = 9
		return
}
	
func (p Player) isFlush() bool {
	// Implementation for checking flush
	firstSuit := p.Hand[0].Suit
	for _, card := range p.Hand {
		if card.Suit != firstSuit {
			return false
		}
	}
	return true
}

func (p Player) isRoyalStraight() bool {
	// Implementation for checking royal flush
	if p.Hand[0].Face == 1 && p.Hand[1].Face == 10 && p.Hand[2].Face == 11 &&
		p.Hand[3].Face == 12 && p.Hand[4].Face == 13 {
		return true
	}
	return false
}

func (p Player) isStraightFlush() bool {
	if !p.isFlush() || !p.isStraight() {
		return false
	}

	return true
}

func (p Player) isFourOfKind() bool {
	countMap := make(map[int]int)

	for _, card := range p.Hand {
		countMap[card.Face]++
	}

	for _, count := range countMap {
		if count == 4 {
			return true
		}
	}

	return false
}

func (p Player) isFullHouse() bool {
	countMap := make(map[int]int)

	for _, card := range p.Hand {
		countMap[card.Face]++
	}

	hasThree := false
	hasTwo := false

	for _, count := range countMap {
		if count == 3 {
			hasThree = true
		} else if count == 2 {
			hasTwo = true
		}
	}

	return hasThree && hasTwo
}

func (p Player) isStraight() bool {
	uniqueFaces := make(map[int]bool)
	maxFace := 0
	minFace := 14 // Setting it to a value higher than the maximum possible face value

	for _, card := range p.Hand {
		if card.Face == 1 {
			uniqueFaces[14] = true // Ace can be treated as high or low, 14 or 1
		}
		uniqueFaces[card.Face] = true
		if card.Face > maxFace {
			maxFace = card.Face
		}
		if card.Face < minFace {
			minFace = card.Face
		}
	}

	// Check for sequential uniqueness of faces
	for i := minFace; i <= maxFace; i++ {
		if !uniqueFaces[i] {
			return false
		}
	}

	return true
}

func (p Player) isThreeOfKind() bool {
	countMap := make(map[int]int)

	for _, card := range p.Hand {
		countMap[card.Face]++
	}

	for _, count := range countMap {
		if count == 3 {
			return true
		}
	}

	return false
}

func (p Player) isTwoPair() bool {
	countMap := make(map[int]int)
	pairCount := 0

	for _, card := range p.Hand {
		countMap[card.Face]++
	}

	for _, count := range countMap {
		if count == 2 {
			pairCount++
		}
	}

	return pairCount == 2
}

func (p Player) isPair() bool {
	countMap := make(map[int]int)

	for _, card := range p.Hand {
		countMap[card.Face]++
	}

	for _, count := range countMap {
		if count == 2 {
			return true
		}
	}

	return false
}



