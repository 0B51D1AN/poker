#ifndef CARD_H
#define CARD_H
#include <string>

using namespace std;
class Card
{
    public:
        int Face;
        int Suit;

        Card(int f, int s);

        Card(const string& card);

        void printCard();
        bool operator<(const Card& other) const;
};

#endif // CARD_H