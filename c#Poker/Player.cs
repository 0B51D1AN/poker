using System;
using System.Collections.Generic;


namespace Poker
{

    class Player
    {

        public List<Card> hand; // ArrayList of up to 5 cards that make a poker hand
        List<Card> hRank; //Arraylist that will contain important card information when attemtping to sort through ranking system
        String handRank=""; //String that will contain the correct ranking of the hand once filed
        
        
        public Player()
        {
            hand= new List<Card>();
            hRank= new List<Card>();
        }

        public Player(params Card [] h)
        {   
            hand=new List<Card>();
            foreach(Card c in h)
            {
                hand.Add(c);
            }

            hRank= new List<Card>();
        }


        public void addCard(Card c)
        {
            hand.Add(c);
        }

        public void showHand()
        {
            foreach(Card i in hand)
            {
                i.printCard();
                if(i!=hand[hand.Count-1])
                    Console.Write(", ");
            }
            Console.WriteLine();
        }


    }




}