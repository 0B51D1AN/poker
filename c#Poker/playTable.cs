using System;
using System.IO;

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


                d.printDeck();

                d.shuffle();


                Player [] table={new Player(), new Player(), new Player(), new Player(), new Player(), new Player()};

                d.deal(table);

                d.printDeck();
                Console.WriteLine("\nHere are the 6 hands... ");

                foreach(Player p in table)
                {
                    p.showHand();
                }

            }


        }


    }



}