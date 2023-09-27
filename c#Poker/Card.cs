using System;


namespace Game
{
    class Card
    {
        int Face;
        int Suit; // 1= Spades 2= Hearts 3= Clubs 4= Diamonds

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
                case 'A':
                    
                    break;
                case 'K':

                    break;
                case 'Q':

                    break;
                case 'J':

                    break;




        }


        public void printCard() // Convert to correct output format from integer interpretation
        {



        }


    }
}