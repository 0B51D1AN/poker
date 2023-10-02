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
                            Console.WriteLine(s.ReadToEnd());

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
            List<List<Player>> table= new List<List<Player>>();
            foreach(Player player in p)
            {
                try
                {
                    Console.WriteLine("Bru");
                    player.findRank();
                    Console.WriteLine("Found Rank");
                    table[player.Rank-1].Add(player); 
                    Console.WriteLine("Adding player");    
                }
                catch(Exception e)
                {
                    Console.WriteLine(e.Message);
                }        
            }

            for(int i=0; i<table.Count; i++)
            {
                Console.WriteLine("Bru");
                if(table[i].Count>1)
                    tieBreak(table[i], i);
            }


            
            //use tieBreak inside here to decide individually the winner of each tied set
            for(int i=0; i<table.Count; i++)
            {
                foreach(Player play in table[i])
                {
                    play.showHand();
                }
            }


        }

        public static void tieBreak(List<Player> p, int index)
        {
            Console.WriteLine("SWITCH");
            switch(index)
            {
                case 0: //RoyalStraightFlush
                        p.Sort((left,right)=> left.hand[4].Suit.CompareTo(right.hand[4].Suit));
                        break;
                case 1: //StraightFlush
                        flush(p);
                        break;
                case 2: //FourofaKind
                        fourofaKind(p);
                        break;
                case 3: //FullHouse
                        p.Sort((left,right)=> left.hRank[2].Face.CompareTo(right.hRank[2].Face));
                        break;
                case 4: //Flush
                        flush(p);
                        break;
                case 5: //Straight
                        straight(p);
                        break;
                case 6: //ThreeofaKind
                        p.Sort((left,right)=> left.hRank[0].Face.CompareTo(right.hRank[0].Face));
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
            
        }
        public static void fourofaKind(List<Player> p)
        {
            p.Sort((left,right)=> left.hRank[1].Face.CompareTo(right.hRank[1].Face));
            if(p[0].hand[0].Face==1)
                p.Reverse(1,4);//reversal should not need comparator since they are already sorted
            else
                p.Reverse();
        }
        public static void straight(List<Player> p)
        {
            p.Sort((left,right)=> left.hRank[1].Face.CompareTo(right.hRank[1].Face));
            if(p[0].hand[0].Face==1)
                p.Reverse(1,4);//reversal should not need comparator since they are already sorted
            else
                p.Reverse();
        }
        public static void twoPair(List<Player> p)
        {
            
        }
        public static void pair(List<Player> p)
        {
            p.Sort((left,right)=> left.hRank[1].Face.CompareTo(right.hRank[1].Face));
            int index=0;
            while(p[index].hand[0].Face==1)
                index++;
            p.Reverse();
        }
        public static void highCard(List<Player> p)
        {
            p.Sort((left,right)=> left.hRank[1].Face.CompareTo(right.hRank[1].Face));
            int index=0;
            while(p[index].hand[0].Face==1)
                index++;
            p.Reverse(index,4);

        }




    }



}
