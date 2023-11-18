package main

import
(
	"fmt"
	"sort"
	//"bufio"
	"os"
	"log"
	"os/exec"
	"encoding/csv"
	"strings"
	
)

func main(){


	//c:=newCard(1,1)

	//c.printCard()
	args := os.Args

	if len(args)==2{

		fmt.Println("***USING TEST DECK***")

		file, err := os.Open(os.Args[1])
		if err != nil {
			log.Fatal(err)
		}
		defer file.Close()
		
		fmt.Println("\n*** File: "+args[1])

		reader := csv.NewReader(file)
		players := []Player{}
		var inputCards []string
		var duplicate []string
		cmd := exec.Command("cat", args[1])
		output, err := cmd.Output()
		if err != nil {
			fmt.Println("Error executing command:", err)
			return
		}

		// Display the output
		fmt.Println(string(output))

		for {
			record, err := reader.Read()
			if err != nil {
				break
			}

			var cards []Card
			for _, value := range record {
				cardStr := strings.TrimSpace(value)
				//fmt.Print(cardStr)
				for _, s := range inputCards {
					if cardStr == s {
						duplicate = append(duplicate, cardStr)
					}
				}
				inputCards = append(inputCards, cardStr)
				cards = append(cards, NewCardFromString(cardStr))
			}
			if len(duplicate)>0{
				fmt.Println("*** ERROR - DUPLICATE CARD FOUND IN DECK ***")
				
				for  i:= range duplicate{
					fmt.Println(duplicate[i])
					
				}
				
				os.Exit(1)
			}

			player := Player{Hand: cards}
			players = append(players, player)
		}

		fmt.Println("\n*** Here are the six Hands...")

		for  i:= range players {
			
			players[i].ShowHand()
			players[i].RankHand()
		}
		fmt.Println("\n---WINNING Hand ORDER---")
		showWinners(players)


	}else{

	////////////////////////////////
	
	//RANDOMIZED DECK
	
	
		players := make([]Player, 6)
			
		fmt.Println("*** USING RANDOMIZED DECK OF CARDS ***")

		deck := NewDeck()
		deck.Shuffle()

		fmt.Println("*** Shuffled Deck of Cards ***")
		deck.ShowDeck()
		fmt.Println()

		for i:=0; i<5; i++{
			for a:=0; a<6; a++{
				//deck.Cards[0].printCard()	
				players[a].PushCard(deck.PopCard())
					
			}
		}

		fmt.Println("*** Here are the six Hands...")
		for _, player := range players {
			
			player.ShowHand()
			
		}

		for  i:= range players {
			
			players[i].RankHand()
			
		}
		fmt.Println("\n***Here is what remains in the deck...")

		deck.ShowDeck()
		

		fmt.Println()
		fmt.Println("---WINNING HAND ORDER---")

		showWinners(players)
		
	}
}

func showWinners(players []Player) {
	rankTiers := make([][]Player, 10)

	for i := range rankTiers {
		rankTiers[i] =  []Player{}
	}

	for i := range players {
		rankTiers[players[i].NumRank] = append(rankTiers[players[i].NumRank], players[i])
	}

	for _, v := range rankTiers {
		if len(v) > 1 {
			tieBreak(v)
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

func tieBreak(v []Player){
	switch v[0].NumRank{
	//Assuming each array has at least 2 elements inside
		case 0:
			sort.Slice(v, func(i, j int) bool {
				return v[i].Hand[0].Suit < v[j].Hand[0].Suit
			})

		case 1:
			sort.Slice(v, func(i, j int) bool {
				return v[i].Hand[4].Face< v[j].Hand[4].Face
			})
			reverse(v)
		case 2:
			sort.Slice(v, func(i, j int) bool {
				return v[i].Hand[2].Face< v[j].Hand[2].Face
			})
			reverse(v)
		case 3:
			sort.Slice(v, func(i, j int) bool {
				return v[i].Hand[2].Face< v[j].Hand[2].Face
			})
			reverse(v)
		case 4:
			
		case 5:
			sort.Slice(v, func(i, j int) bool {
				return v[i].Hand[4].Face< v[j].Hand[4].Face
			})
			reverse(v)
		case 6:
			sort.Slice(v, func(i, j int) bool {
				return v[i].Hand[2].Face< v[j].Hand[2].Face
			})
			reverse(v)
		case 7:
			sort.Slice(v, func(i, j int) bool {
				return compareTwoPair(v[i], v[j])
			})
			reverse(v)
		case 8:
			sort.Slice(v, func(i, j int) bool {
				return comparePair(v[i], v[j])
			})
			reverse(v)
		case 9:
			sort.Slice(v, func(i, j int) bool {
				return compareByHighCard(v[i], v[j])
			})
			reverse(v)
	}

}

func reverse(s []Player) {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		s[i], s[j] = s[j], s[i]
	}
}

func compareByHighCard(a, b Player) bool {
	if(a.Hand[4].Face== b.Hand[4].Face){
		return a.Hand[4].Suit> b.Hand[4].Suit
	}
	return a.Hand[4].Face < b.Hand[4].Face
}

func comparePair(a, b Player) bool {
	if(a.HRank[0].Face== b.HRank[0].Face){
		if(a.HRank[0].Face!=a.Hand[4].Face){	
			return a.Hand[4].Suit> b.Hand[4].Suit
		}
		return a.Hand[2].Suit> b.Hand[2].Suit
	}
	return a.HRank[0].Face < b.HRank[0].Face
		
}

func compareTwoPair(a, b Player) bool {
	//3 items in HRank [Smallest Pair, Larger Pair, Kicker]
	if(a.HRank[1].Face== b.HRank[1].Face){
		if(a.HRank[0].Face==b.HRank[0].Face){	
			return a.HRank[2].Suit> b.HRank[2].Suit
		}
		return a.HRank[0].Face< b.Hand[0].Face
	}
	return a.HRank[1].Face < b.HRank[1].Face
		
}
