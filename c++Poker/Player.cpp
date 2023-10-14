#include <iostream>
#include "Card.h"
#include <vector>
#include <algorithm>
using namespace std;

class Player{

    public:
        vector <Card> hand;
        string handRank;
        int numRank; //0-9 strongest to lowest. Use for sorting later.
        vector <Card> hRank;
        Player()
        {
            this->handRank="";
            this->numRank=-1;
        }
        
        Player(Card h[5])
        {
            for (int i=0; i<5; i++)
            {
               this->hand.push_back(h[i]);
            }
            this->handRank="";
        }


        void pushCard(Card c)
        {
            this->hand.push_back(c);
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
                return;
            }
            //Four of a Kind
            if(this->isFourOfKind())
            {
                this->handRank="Four of a Kind";
                this->numRank=2;
                return;
            }
            //Full House
            if(this->isFullHouse())
            {
                this->handRank="Full House";
                this->numRank=3;
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
                return;
            }
            //Three of a Kind
            if(this->isThreeOfKind())
            {
                this->handRank="Three of a Kind";
                this->numRank=6;
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

    private:

        bool isStraight()
        {
            int a=0;
            hand[0].Face;

            if((hand[0].Face==1) && (hand[1].Face==10) && (hand[2].Face==11) && (hand[3].Face==12) && (hand[4].Face==13))
                return true;
            else
            {
                for(int i=1; i<5; i++)
                {
                    if(hand[i].Face!=hand[i-1].Face+1)
                        return false;
                }
            }
            return false;
        }


        bool isFlush()
        {
            int f=hand[0].Suit;
            for(const Card& c: hand)
            {
                if(c.Suit!=f)
                    return false;
            }
            
            return true;
        }

        bool isFourOfKind()
        {
            // Check for Four of a Kind
            // Four cards of the same Face value

            if (hand.size() != 5)
                return false;

            vector<int> faceCounts(14, 0); // 14 to account for A (1) to K (13)
            for (const Card& card : this->hand)
            {
                faceCounts[card.Face]++;
            }

            for (int count : faceCounts)
            {
                if (count == 4)
                    return true;
            }

            return false;
           
        }


        bool isFullHouse()
        {
            // Check for a Full House
            // Three cards of one Face value and two cards of another Face value

            if (hand.size() != 5)
                return false;

            vector<int> faceCounts(14, 0);
            for (const Card& card : hand)
            {
                faceCounts[card.Face]++;
            }

            bool hasThree = false;
            bool hasTwo = false;
            for (int count : faceCounts)
            {
                if (count == 3)
                    hasThree = true;
                else if (count == 2)
                    hasTwo = true;
            }

            return hasThree && hasTwo;
        }

        bool isThreeOfKind()
        {
            // Check for Three of a Kind
            // Three cards of the same Face value

            if (hand.size() != 5)
                return false;

            vector<int> faceCounts(14, 0);
            for (const Card& card : hand)
            {
                faceCounts[card.Face]++;
            }

            for (int count : faceCounts)
            {
                if (count == 3)
                    return true;
            }

            return false;
        }

        bool isTwoPair()
        {
            // Check for Two Pair
            // Two sets of two cards with the same Face value

            if (hand.size() != 5)
                return false;

            vector<int> faceCounts(14, 0);
            for (const Card& card : hand)
            {
                faceCounts[card.Face]++;
            }

            int pairCount = 0;
            for (int count : faceCounts)
            {
                if (count == 2)
                    pairCount++;
            }

            return pairCount == 2;
        }



        bool isPair()
        {
            // Check for a Pair
            // Two cards with the same Face value

            if (hand.size() != 5)
                return false;

            vector<int> faceCounts(14, 0);
            for (const Card& card : hand)
            {
                faceCounts[card.Face]++;
            }

            for (int count : faceCounts)
            {
                if (count == 2)
                    return true;
            }

            return false;
        }






};