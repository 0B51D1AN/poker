using System;
using System.Collections.Generic;


namespace Poker
{

    class Player
    {

        public List<Card> hand; // ArrayList of up to 5 cards that make a poker hand
        public List<Card> hRank; //Arraylist that will contain important card information when attemtping to sort through ranking system
        public string handRank; //String that will contain the correct ranking of the hand once filed
        public int Rank;
        
        public Player()
        {
            hand= new List<Card>();
            hRank= new List<Card>();
            handRank="";
            int Rank=0;
        }

        public Player(params Card [] h)
        {   
            hand=new List<Card>(h);
            

            hRank= new List<Card>();
            handRank="";
            int Rank=0;
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
            if(handRank.Equals(""))
                Console.WriteLine();
            else
                Console.WriteLine(" - "+handRank);
        }


        public void findRank()
        {
            sortHand();

            checkStraight();
            if(handRank.Equals(""))
                checkSet();
            

        }

        public void sortHand()
        {
            hand.Sort((left,right)=> left.Face.CompareTo(right.Face));
        }
        

        public void checkStraight()
        {
            
        }

        public void checkSet()
        {


        }


    }




}