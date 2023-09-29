using System;
using System.Collections.Generic;
namespace Poker
{

    class Deck
    {

        private List<Card> deck;


        public Deck()
        {
            deck= new List<Card>();

            for(int s=1; s<5; s++)
            {
                for(int f= 1; f<14; f++)	
                {
                
                    switch (s){
                        case 1:	deck.Add(new Card(f,s));
                                break;
                        case 2: deck.Add(new Card(f,s));
                                break;
                        case 3: deck.Add(new Card(f,s));
                                break;
                        case 4: deck.Add(new Card(f,s));
                                break;
                        
                        //default: break;
                    }

                }

            }		

            //Console.WriteLine("Deck has been initialized and sorted");
        }


        public void printDeck()
        {
            int format=0;
            foreach(Card c in deck)
            {
                format++;
                c.printCard();
                Console.Write(" ");
                if(format==13)
                {
                    Console.WriteLine();
                    format=0;
                }
                
            }
            Console.WriteLine();
        }

        public Card popCard()
        {
            Card temp= deck[0];
            deck.RemoveAt(0);
            return temp;
        }


       public void shuffle()
       {
            var rand= new Random();
            List<Card> temp= new List<Card>();

            for(int i=52; i>=1; i--)
            {
                int r= rand.Next(i);

                temp.Add(deck[r]);
                deck.RemoveAt(r);
            }

            Console.WriteLine("\nShuffled Deck:");

            while(temp.Count!=0)
            {
                //temp[0].printCard();
                //Console.Write(" ");
                deck.Add(temp[0]);
                temp.RemoveAt(0);
            }
            //Console.WriteLine();


       } 

       public void deal(params Player [] players)
       {
            while(players[players.Length-1].hand.Count<5)
            {
                foreach(Player p in players)
                {
                    p.addCard(popCard());
                }
            }
       }

        


    }

}