#include <iostream>
//#include "Card.h"
#include <vector>
#include <algorithm>
#include "Player.h"
#include "Card.h"
using namespace std;




    

         
        
        Player:: Player()
        {
            this->handRank="";
            this->numRank=-1;
            
        }
        
        Player:: Player(Card h[5])
        {
            for (int i=0; i<5; i++)
            {
               this->hand.push_back(h[i]);
            }
            this->handRank="";
        }


        void Player:: pushCard(Card c)
        {
            this->hand.push_back(c);
        }

        void Player:: showHand()
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

       

        void Player:: rankHand() 
        {
            sort(this->hand.begin(), this->hand.end());

            if(isFlush()&& ((hand[0].Face==1) && (hand[1].Face==10) && (hand[2].Face==11) && (hand[3].Face==12) && (hand[4].Face==13)))//Royal Flush
            {
                this->handRank="Royal Flush";
                this->numRank=0;
                return;
            }
            //Straight Flush
            if(this->isStraight() && this->isFlush())
            {
                this->handRank="Straight Flush";
                this->numRank=1;
                if(hand[0].Face==1)
                    this->hRank.push_back(hand[0]);
                else
                    this->hRank.push_back(hand[4]);
                return;
            }
            //Four of a Kind
            if(this->isFourOfKind())
            {
                this->handRank="Four of a Kind";
                this->numRank=2;
                this->hRank.push_back(hand[1]);//must be one of the four
                return;
            }
            //Full House
            if(this->isFullHouse())
            {
                this->handRank="Full House";
                this->numRank=3;
                this->hRank.push_back(hand[2]);//must be 3pair
                return;
            }
            //Flush
            if(this->isFlush())
            {
                this->handRank="Flush";
                this->numRank=4;
                return;
            }
            //Straight
            if(this->isStraight())
            {
                this->handRank="Straight";
                this->numRank=5;
                this->hRank.push_back(hand[4]);
                return;
            }
            //Three of a Kind
            if(this->isThreeOfKind())
            {
                this->handRank="Three of a Kind";
                this->numRank=6;
                this->hRank.push_back(hand[2]);
                return;
            }
            //Two Pair
            if(this->isTwoPair())
            {
                this->handRank="Two Pair";
                this->numRank=7;

                return;
            }
            //Pair
            if(this->isPair())
            {
                this->handRank="Pair";
                this->numRank=8;
                return;
            }
            //High Card
            else
            {
                this->handRank="High Card";
                this->numRank=9;
                return;
            }

        }

        bool Player:: compareByHighCard(const Player & a, const Player & b)
        {
            return a.hand[4]<b.hand[4];
        }

        bool Player:: compareBySuit(const Player & a, const Player & b)
        {
            return a.hand[4].Suit<b.hand[4].Suit;
        }
        bool Player:: compareByCard(const Player & a, const Player & b)
        {
            if(a.hRank[0].Face==b.hRank[0].Face)
                return compareBySuit(a,b);
            else
                return a.hRank[0]< b.hRank[0];
        }

       







