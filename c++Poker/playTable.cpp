#include <iostream>
#include <list>
//#include "Card.cpp"
#include "Player.cpp"
using namespace std;
#include "Deck.cpp"


int main()
{

    Card h[]={Card(1,1), Card(1,2), Card(1,3), Card(1,4), Card(2,1)};
    Player p(h);

    p.showHand();

    p.rankHand();
    p.showHand();


    Deck d;

    d.shuffle();
    d.showDeck();
}