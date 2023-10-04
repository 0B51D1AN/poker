using System;
using System.IO;
using System.Collections.Generic;

namespace Poker
{

    class playTable
    {

        public static void Main(string [] args)
        {
            //Card[] c= {new Card(1,1),new Card(1,1),new Card(1,1),new Card(1,1),new Card(1,1)};
            //Player p= new Player(c);
           // p.showHand();
            //Console.WriteLine(args.Length);
                
            if(args.Length==1)
            {

                
                
                try
                {
                    using (StreamReader s= new StreamReader(args[0]))
                    {
                        Console.WriteLine("Reading file: "+args[0]);
                        
                        List<Card> cardPool= new List<Card>();
                        List<Card> tempHand= new List<Card>();
                        List<Player> table= new List<Player>();
                        List<Card> duplicate= new List<Card>();
                        int newHand=0;
                        
                        Card t;
                        while(!s.EndOfStream)
                        {
                            try
                            {
                                string temp=null;
                                while((s.Peek()!=',') && (s.Peek()!=' ') && (s.Peek()!='\n'))
                                {
                                    temp+=(char)s.Read();
                                    //Console.WriteLine(temp);
                                }
                                s.Read();
                                t=new Card(temp);
                                //temp="";
                                //Console.Write(newHand);
                                
                                if(cardPool.Contains(t))
                                {
                                    duplicate.Add(t);
                                    tempHand.Add(t);
                                    newHand++;
                                }
                                else
                                {
                                    
                                    cardPool.Add(t);
                                    
                                    tempHand.Add(t);
                                    
                                    newHand++;
                                }
                                if(newHand==5)
                                {
                                    
                                    table.Add(new Player(tempHand.ToArray()));
                                    //table[0].showHand();
                                    tempHand.Clear();
                                    newHand=0;
                                }
                                
                            }
                            catch(Exception e){}

                            
                        }
                        Console.WriteLine("Here are the Hands: ");
                        foreach(Player p in table)
                        {
                            p.showHand();
                            p.findRank();
                        }

                        if(duplicate.Count>0)
                        {
                            Console.WriteLine("ERROR: Duplicate Card(s) detected");
                            foreach(Card c in duplicate)
                            {
                                c.printCard();
                                Console.Write(" ");
                            }

                        }
                        else
                        {
                            Console.WriteLine("\n **** WINNING HAND ORDER **** ");
                            printWinners(table.ToArray());
                        }

                    }
                }
                catch (IOException e)
                {
                    Console.WriteLine("The file could not be read:");
                    Console.WriteLine(e.Message);
                }
            }

        
            else
            {

                Deck d= new Deck();


                //d.printDeck();

                d.shuffle();

                d.printDeck();
                Player [] table={new Player(), new Player(), new Player(), new Player(), new Player(), new Player()};

                d.deal(table);

                
                Console.WriteLine("\nHere are the 6 hands... ");

                foreach(Player p in table)
                {
                    p.showHand();
                    p.findRank();
                }
                Console.WriteLine("\nHere is what remains in the deck:");
                d.printDeck();

                
                Console.WriteLine("\n *** WINNING HAND ORDER ***");

                // foreach(Player p in table)
                // {
                //     p.findRank();
                //     p.showHand();
                // }
                printWinners(table);
                //insert array of Players into Decider to order the hands.
                //First, use the Player class to decide the rank of the individual hands
                //Then, use the playTable functions to decide the winner and tiebreak



            }


        }




        //Divide cards into respective arrays depending on their ranking.
        //Insert each array(with 2 or more hands) into the tiebreaker for further sorting


        public static void printWinners(Player [] p)
        {
            List<Player> [] table= new List<Player>[10];
            for(int i=0; i<table.Length; i++)
            {
                table[i]=new List<Player>();
                //Console.WriteLine("yoi");
            }
            foreach(Player player in p)
            {
                try
                {
                    //Console.WriteLine("Bru");
                    //player.findRank();
                    //Console.WriteLine("Found Rank");
                    table[player.Rank-1].Add(player); 
                    //Console.WriteLine("Adding player");    
                }
                catch(Exception e)
                {
                    Console.WriteLine(e.Message);
                }        
            }

            for(int i=0; i<table.Length; i++)
            {
                //Console.WriteLine("Bru");
                if(table[i].Count>1)
                {
                    //Console.WriteLine(i);
                    tieBreak(table[i], i);
                }

            }


            
            //use tieBreak inside here to decide individually the winner of each tied set
            for(int i=0; i<table.Length; i++)
            {
                foreach(Player play in table[i])
                {
                    play.showHand();
                }
            }


        }

        public static void tieBreak(List<Player> p, int index)
        {
            //Console.WriteLine("SWITCH");

            switch(index)
            {
                case 0: //RoyalStraightFlush
                        p.Sort((left,right)=> left.hand[4].Suit.CompareTo(right.hand[4].Suit));
                        break; //sorts least to greatest, no need to reverse
                case 1: //StraightFlush
                        flush(p);
                        break;
                case 2: //FourofaKind
                        foreach(Player play in p)
                        {
                             if(play.hRank[1].Face==1)
                                play.hRank[1].Face=14; //make aces high then sort array for accurate organization
                        }
                        p.Sort((left,right)=> left.hRank[1].Face.CompareTo(right.hRank[1].Face));
                        p.Reverse();
                        break;
                case 3: //FullHouse
                        p.Sort((left,right)=> left.hRank[2].Face.CompareTo(right.hRank[2].Face));
                        p.Reverse();
                        break;
                case 4: //Flush
                        flush(p);
                        break;
                case 5: //Straight
                        straight(p);
                        break;
                case 6: //ThreeofaKind
                        foreach(Player play in p)
                        {
                             if(play.hRank[1].Face==1)
                                play.hRank[1].Face=14;
                        }
                        p.Sort((left,right)=> left.hRank[1].Face.CompareTo(right.hRank[1].Face));
                        p.Reverse();
                        break;
                case 7: //TwoPair
                        twoPair(p);
                        break;
                case 8: //Pair
                        pair(p);
                        break;
                case 9: //HighCard
                        highCard(p);
                        break;

            }

        }


        public static void flush(List<Player> p)
        {
            foreach(Player play in p)
            {
                    if(play.hRank[1].Face==1)
                    play.hRank[1].Face=14;
            }
            p.Sort((left,right)=> left.hRank[1].Face.CompareTo(right.hRank[1].Face));
            p.Reverse();
        }
        
        public static void straight(List<Player> p)
        {
            //must be straight, can move aces aroundin the array
            foreach(Player play in p)
            {
                    if(play.hRank[1].Face==1)
                    play.hRank[1].Face=14;
            }
            p.Sort((left,right)=> left.hRank[1].Face.CompareTo(right.hRank[1].Face));
            p.Reverse();
            
        }
        public static void twoPair(List<Player> p)
        {
            p.Sort((left,right)=> left.hRank[2].Face.CompareTo(right.hRank[2].Face));
            int index=0;
            while(p[index].hRank[2].Face==1)
                index++;
            if(index>p.Count-1)
                p.Reverse(index, p.Count-1);
            else
                p.Reverse();

            int n = p.Count;
            bool swapped;

            for (int i = 0; i < n - 1; i++)
            {
                swapped = false;

                for (int j = 0; j < n - 1 - i; j++)
                {
                    if ((p[j].hRank[2].Face==p[j+1].hRank[2].Face)&&(p[j].hRank[1].Face==p[j+1].hRank[1].Face))
                    {
                        if(p[j].hRank[3].Face>p[j+1].hRank[3].Face)
                        {
                            Player temp=p[j];
                            p[j]=p[j+1];
                            p[j+1]=temp;
                        }
                        
                        swapped = true;
                    }
                }

                // If no two elements were swapped in inner loop, the list is already sorted.
                if (!swapped)
                {
                    break;
                }
            }
        }
        public static void pair(List<Player> p)
        {
            foreach(Player play in p)
            {
                if(play.hRank[1].Face==1)
                    play.hRank[1].Face=14;
            }
           
           p.Sort((left,right)=> left.hRank[1].Face.CompareTo(right.hRank[1].Face));
           
           p.Reverse();

            
    
            int n = p.Count;
            bool swapped;

            for (int i = 0; i < n - 1; i++)
            {
                swapped = false;

                for (int j = 0; j < n - 1 - i; j++)
                {
                    if (p[j].hRank[1].Face==p[j+1].hRank[1].Face)
                    {
                        if(p[j].hRank[2].Face<p[j+1].hRank[2].Face)
                        {
                            Player temp=p[j];
                            p[j]=p[j+1];
                            p[j+1]=temp;
                        }
                        
                        swapped = true;
                    }
                }

                // If no two elements were swapped in inner loop, the list is already sorted.
                if (!swapped)
                {
                    break;
                }
            }
        


            
            //p.Reverse();
        }
        public static void highCard(List<Player> p)
        {        
           foreach(Player play in p)
           {
                if(play.hRank[1].Face==1)
                    play.hRank[1].Face=14;
           }
           
           p.Sort((left,right)=> left.hRank[1].Face.CompareTo(right.hRank[1].Face));
           
           p.Reverse();



           int n = p.Count;
            bool swapped;

            for (int i = 0; i < n - 1; i++)
            {
                swapped = false;

                for (int j = 0; j < n - 1 - i; j++)
                {
                    if (p[j].hRank[1].Face==p[j+1].hRank[1].Face)
                    {
                        if(p[j].hRank[1].Suit>p[j+1].hRank[1].Suit)
                        {
                            Player temp=p[j];
                            p[j]=p[j+1];
                            p[j+1]=temp;
                        }
                        
                        swapped = true;
                    }
                }

                // If no two elements were swapped in inner loop, the list is already sorted.
                if (!swapped)
                {
                    break;
                }
            }
            
            //p.Reverse();
                          
            
            //p.Reverse(index,p.Count-1);

        }

        


    }



}
