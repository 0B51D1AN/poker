using System;


namespace Poker
{

    class playTable
    {

        public static void Main(String [] args)
        {
            //Card[] c= {new Card(1,1),new Card(1,1),new Card(1,1),new Card(1,1),new Card(1,1)};
            //Player p= new Player(c);
           // p.showHand();

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