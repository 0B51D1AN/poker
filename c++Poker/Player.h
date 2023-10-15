// Player.h
#ifndef PLAYER_H
#define PLAYER_H
#include "Card.h"
#include <vector>
#include <algorithm>
#include <iostream>

using namespace std;

class Player
{
    public:
        //vector<int> hRank;
        vector<string> h;
        string handRank;
        vector <Card> hRank;
        int numRank; //0-9 strongest to lowest. Use for sorting later.
        vector <Card> hand;
        // Your other Player class members and methods
        Player();

        Player(Card h[5]);

        void pushCard(Card c);
        void showHand();
        void rankHand();
        static bool compareByHighCard(const Player & a, const Player & b);
        static bool compareBySuit(const Player & a, const Player & b);
        static bool compareByCard(const Player & a, const Player & b);
        static bool compareTwoPair(const Player & a, const Player & b);
        static bool comparePair(const Player & a, const Player & b);
        // void setHand(const vector<string>& cards) {
        //     h = cards;
        // }
    private:
        
        bool isStraight()
        {
            int a=0;
            //cout<<hand[0].Face;
            //this->showHand();
            
            if((hand[0].Face==1) && (hand[1].Face==10) && (hand[2].Face==11) && (hand[3].Face==12) && (hand[4].Face==13))
                return true;
            else
            {
                
                for(int i=1; i<5; i++)
                {
                    if(this->hand[i].Face!=this->hand[i-1].Face+1)
                        return false;
                }
                return true;
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
            int temp=0;
            int pairCount = 0;
            for (int i=0; i<faceCounts.size(); i++)
            {
                if (faceCounts[i] == 2)
                {
                    this->hRank.push_back(Card(i+1, 1));
                    pairCount++;
                }          
            }
            int a=0;
            
            if (pairCount==2)
                return true;
            else   
            {
                hRank.clear();
                return false;
            }
            
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

            for (int i=0; i<faceCounts.size(); i++)
            {
                if (faceCounts[i] == 2)
                {
                    this->hRank.push_back(Card(i, 1));
                    return true;
                }
            }

            return false;
        }
    

    // Declare the comparison function
    
};

#endif