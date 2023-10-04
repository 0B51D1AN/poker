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
            //int Rank=0;
        }

        public Player(params Card [] h)
        {   
            hand=new List<Card>(h);
            

            hRank= new List<Card>();
            handRank="";
           // int Rank=0;
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
        
		bool flush=true;
		int index= hand[0].Suit;
            foreach(Card c in hand)
            {
                if(c.Suit!=index)
                {
                    flush=false;
                }
                
            }		
                

            if(flush)
            {
                if((hand[0].Face==1) & (hand[1].Face==10) & (hand[2].Face==11) & (hand[3].Face==12) & (hand[4].Face==13))
                {
                    handRank="ROYAL FLUSH";
                    hRank.Add(new Card(1, hand[0].Suit));
                    Rank=1;
                    return;
                }

                bool straight=true;

                int run=hand[0].Face;
        
                foreach(Card c in hand)
                {

                    if(c.Face==run)
                    {

                        run++;

                    }
                    else    
                        straight=false;
                }

                if(straight)
                {
                    handRank="STRAIGHT FLUSH";
                    hRank.Add(new Card(2, hand[0].Suit));
                    if(hand[0].Face==1)
                        hRank.Add(hand[0]);
                    else
                        hRank.Add(hand[4]);
                    Rank=2;
                    return;
                }
                else
                {
                    handRank="Flush";
                    hRank.Add(new Card(5, hand[0].Suit));
                    if(hand[0].Face==1)
                        hRank.Add(hand[0]);
                    else
                        hRank.Add(hand[4]);
                    Rank=5;
                    return;
                }
            }
            if((hand[0].Face==1) && (hand[1].Face==10) && (hand[2].Face==11) && (hand[3].Face==12) && (hand[4].Face==13))
            {
                handRank="Straight";
                hRank.Add(new Card(6, -1)); //Ace High
                hRank.Add(hand[0]);
                Rank=6;
                return;
            }

            bool Straight=true;

            int Run=hand[0].Face;

            foreach(Card c in hand)
            {
                if(c.Face==Run)
                {
                    Run++;
                }
                else
                    Straight=false;
            }

            if(Straight)
            {
                handRank="Straight";
                hRank.Add(new Card(6, -1));
                hRank.Add(hand[4]);
                Rank=6;
                return;
            }


        }

        public void checkSet()
        {
            int [] faces = new int[14];

            foreach(Card c in hand)
            {

                faces[c.Face]++;

            }

            int set1=0;
            int set2=0;

            for(int i=0; i<faces.Length; i++)
            {
                if((faces[i]>=2) && (set1==0))
                {
                    set1=i; //index of possible pair                    
                }
                if((faces[i]>=2) && (set1>0) && (set1!= i))
                {
                    set2=i;                    
                }
            
            }

            if(faces[set1]==4)
            {
                handRank= "Four of a Kind";
                hRank.Add(new Card(3, -1));
                hRank.Add(new Card(set1, -1));
                Rank=3;
                return;
            }
            if((faces[set1]==3 && faces[set2]==2)||(faces[set2]==3 && faces[set1]==2))
            {
                handRank="Full House";
                hRank.Add(new Card(4, -1));
                hRank.Add(new Card(set1, -1));
                hRank.Add(new Card(set2, -1));
                Rank=4;
                return;
            }
            if(faces[set1]==2)
            {

                if(set2>0)
                {
                    handRank="2 Pair";
                    hRank.Add(new Card(8,-1));
                    hRank.Add(new Card(set1, -1));
                    hRank.Add(new Card(set2, -1));
                    Rank=8;
                    foreach(Card c in hand)
                    {
                        if(c.Face!=set1 && c.Face!=set2)
                            hRank.Add(c);
                    }
                    return;
                }
                else
                {
                    handRank="Pair";
                    hRank.Add(new Card(9, -1));
                    hRank.Add(new Card(set1, -1));
                    Rank=9;
                    if(set1==hand[4].Face)
                    {
                        if(hand[0].Face!=1)
                            hRank.Add(hand[2]);
                        else
                            hRank.Add(hand[0]);
                    }
                    else
                        hRank.Add(hand[4]);
                    return;

                }
                
            }
            if(faces[set1]==3)
            {
                handRank="3 of a Kind";
                hRank.Add(new Card(7,-1));
                hRank.Add(new Card(set1,-1));
                Rank=7;
                return;
            }
            if(faces[set1]==2)
            {
                handRank="Pair";
                hRank.Add(new Card(9,-1));
                hRank.Add(new Card(set1,-1));
                if(set1==hand[4].Face)
                {
                    if(hand[0].Face!=1)
                        hRank.Add(hand[2]);
                    else
                        hRank.Add(hand[0]);
                }
                else
                    hRank.Add(hand[4]);
                    

                Rank=9;
                return;
            }


            handRank="High Card";
            hRank.Add(new Card(10, -1));
            Rank=10;
            if(hand[0].Face!=1)
                hRank.Add(hand[4]);
            else 
                hRank.Add(hand[0]);
            return;



        }


    }




}
