using System;


namespace Poker
{
    class Card
    {
        public int Face;
        public int Suit; // 1= Spades 2= Hearts 3= Clubs 4= Diamonds

        public Card() // Default
        {
            Face=0;
            Suit=0;
        }

        public Card(int f, int s) // Numerical
        {
            Face=f;
            Suit=s;
        }

        public Card(String c) // String Parse | String input should be in 2 character format -> FaceSuit
        {
            char F=c[0];
            char S=c[1];

            switch(F)
            {
                case 'A':
                    Face=1;
                    break;
                case 'K':
                    Face=13;
                    break;
                case 'Q':
                    Face=12;
                    break;
                case 'J':
                    Face=11;
                    break;
            }

            switch(S)
            {
                case 'S':
                    Suit=1;
                    break;
                case 'H':   
                    Suit=2;
                    break;
                case 'C':
                    Suit=3;
                    break;
                case 'D':
                    Suit=4;
                    break;
            }

        }


        // public bool Equals(Card other)
        // {
        //     return (other.Face==this.Face && other.Suit==this.Suit);

        // }
        public void printCard() // Convert to correct output format from integer interpretation
        {
            
            switch(Face)
            {
                case 1:
                    Console.Write("A");
                    break;
                case 13:
                    Console.Write("K");
                    break;
                case 12:
                    Console.Write("Q");
                    break;
                case 11:
                    Console.Write("J");
                    break;
                default:
                    Console.Write(Face);
                    break;
            }

            switch(Suit)
            {
                case 1:
                    Console.Write("S");
                    break;
                case 2:   
                    Console.Write("H");
                    break;
                case 3:
                    Console.Write("C");
                    break;
                case 4:
                    Console.Write("D");
                    break;
                
            }


        }


    }
}