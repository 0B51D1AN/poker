package main

import
(
	"fmt"
	"sort"
	
)

func main(){

	fmt.Println("Hello World!")

	//c:=newCard(1,1)

	//c.printCard()

	players := make([]Player, 6)
		
	

	deck := NewDeck()
	deck.Shuffle()
	deck.ShowDeck()

for i:=0; i<5; i++{
	for a:=0; a<6; a++{
		//deck.Cards[0].printCard()	
		players[a].PushCard(deck.PopCard())
			
	}
}

	deck.ShowDeck()

	for  i:= range players {
		
		players[i].RankHand()
		
	}
	for _, player := range players {
		
		player.ShowHand()
		
	}

	showWinners(players)
	
}

func showWinners(players []Player) {
	rankTiers := make([][]Player, 10)

	for i := range rankTiers {
		rankTiers[i] = make([]Player, 0)
	}

	for i := range players {
		rankTiers[players[i].NumRank] = append(rankTiers[players[i].NumRank], players[i])
	}

	for _, v := range rankTiers {
		if len(v) > 1 {
			tieBreak(&v)
		}
	}

	for _, v := range rankTiers {
		if len(v) > 0 {
			for _, p := range v {
				p.ShowHand()
			}
		}
	}
}

func tieBreak(v *[]Player) {
	switch (*v)[0].NumRank {
	case 0, 4:
		sort.Slice(*v, func(i, j int) bool {
			return (*v)[i].HRank[0].Suit < (*v)[j].HRank[0].Suit
		})
		reverse(v)
	case 1, 5, 9:
		sort.Slice(*v, func(i, j int) bool {
			return (*v)[i].HRank[4].Face < (*v)[j].HRank[4].Face
		})
		reverse(v)
	case 2, 3, 6:
		for i := range *v {
			if (*v)[i].HRank[0].Face == 1 {
				(*v)[i].HRank[0].Face = 14
			}
		}
		sort.Slice(*v, func(i, j int) bool {
			return (*v)[i].HRank[0].Face < (*v)[j].HRank[0].Face
		})
		reverse(v)
	case 7:
		twoPair(v)
	case 8:
		for i := range *v {
			if(len((*v)[i].HRank)!=0){
				if (*v)[i].HRank[0].Face == 1 {
					(*v)[i].HRank[0].Face = 14
				}
			}
		}
		sort.Slice(*v, func(i, j int) bool {
			return (*v)[i].HRank[2].Face < (*v)[j].HRank[2].Face
		})
		reverse(v)
	}
}

func reverse(v *[]Player) {
	for i, j := 0, len(*v)-1; i < j; i, j = i+1, j-1 {
		(*v)[i], (*v)[j] = (*v)[j], (*v)[i]
	}
}

func twoPair(v *[]Player) {
	for i := range *v {
		if (*v)[i].HRank[0].Face == 1 {
			(*v)[i].HRank[0].Face = 14
		}
	}
	sort.Slice(*v, func(i, j int) bool {
		return (*v)[i].HRank[1].Face < (*v)[j].HRank[1].Face
	})
	reverse(v)
}

func (p *Player) compareBySuit(i, j int) bool {
	return p.Hand[i].Suit < p.Hand[j].Suit
}

func (p *Player) compareByHighCard(i, j int) bool {
	return p.Hand[i].Face < p.Hand[j].Face
}

func (p *Player) compareByCard(i, j int) bool {
	return p.HRank[i].Face < p.HRank[j].Face
}

func (p *Player) compareTwoPair(i, j int) bool {
	return p.HRank[i+1].Face < p.HRank[j+1].Face
}

func (p *Player) comparePair(i, j int) bool {
	return p.HRank[i+2].Face < p.HRank[j+2].Face
}

