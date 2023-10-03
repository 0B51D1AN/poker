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
        
            switch(c[0])
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
                case '1':
                    Face=10;
                    break;
                default:
                    Face= (int) c[0]-48;
                    break;
            }

            switch(c[c.Length-1])
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


        // public override bool Equals(object other)
        // {
        //     if(other==null)
        //         return false;
        //     Card otherAsCard= other as Card;
        //     if (otherAsCard == null)
        //         return false;
        //     else
        //         return Equals(otherAsCard);
        // }

        public bool Equals(Card other)
        {
            if(other==null)
                return false;
            else
                return ((other.Face==this.Face) && (other.Suit==this.Suit));
        }
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