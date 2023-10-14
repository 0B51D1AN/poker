#include <iostream>
#include "Card.h"
#include <list>
#include <algorithm>
#include <random>
#include <ctime>
using namespace std;

class Deck
{
    private:
        list <Card> deck;
    public:
        
        Deck()
        {  
        
            // Initialize the deck with cards
            for (int suit = 1; suit <= 4; suit++)
            {
                for (int face = 1; face <= 13; face++)
                {
                    Card card(face, suit);
                    deck.push_back(card);
                }
            }
        }

        void shuffle()
        {
            srand(static_cast<unsigned>(time(nullptr)));
            vector<Card> cardVector(deck.begin(), deck.end());

            for (int i = cardVector.size() - 1; i > 0; i--)
            {
                int j = rand() % (i + 1);
                swap(cardVector[i], cardVector[j]);
            }

            deck.assign(cardVector.begin(), cardVector.end());
        }

        Card popCard()
        {
            if (!deck.empty())
            {
                Card topCard = deck.front();
                deck.pop_front();
                return topCard;
            }
            else
            {
                // Handle the case where the deck is empty
                // You can throw an exception or return a special "no card" indicator.
                // For simplicity, we'll just return an empty card here.
                cout<<"Deck is empty";
                return Card(0, 0);
            }
        }

        void showDeck()
        {
            int i=0;
            for(Card c: deck)
            {
                c.printCard();
                cout<<" ";
                i++;
                if(i==13)
                {
                    cout<<endl;
                    i=0;
                }
            }
            cout<<endl;
        }

};