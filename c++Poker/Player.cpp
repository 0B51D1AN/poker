#include <iostream>
#include "Card.h"
#include <list>
using namespace std;

class Player{

    public:
        list <Card> hand;
        string handRank;
        int numRank; //0-9 strongest to lowest. Use for sorting later.
        Player()
        {
            handRank="";
            numRank=-1;
        }
        
        Player(Card h[5])
        {
            for (int i=0; i<5; i++)
            {
               hand.push_front(h[i]);
            }
            handRank="";
        }


        void pushCard(Card c)
        {
            hand.push_front(c);
        }

        void showHand()
        {

            for(Card c : hand)
            {
                c.printCard();
                cout<<" ";
            }
            if(handRank=="")
            {
                cout<<endl;
            }
            else
            {
                cout<<" - "+ handRank<<endl;
            }

        }

        

        void rankHand()
        {
            hand.sort();




        }

    


};