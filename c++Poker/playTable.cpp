#include <iostream>
#include <list>
//#include "Card.cpp"
#include "Player.cpp"
using namespace std;
#include "Deck.cpp"
#include <fstream>

static void ShowWinners(Player players[]);
static void tieBreak(vector<Player> &v);

int main(int argc, char* argv[])
{

    
    if(argv[1]!=NULL)
    {
        cout<<argv[1];



    }
    else
    {
        
        
        Deck d;
        d.shuffle();
        cout<<"*** USING RANDOMIZED DECK OF CARDS ***\n\n";
        cout<<"*** Shuffled 52 Card Deck: \n";
        d.showDeck();

        Player table[6];
        for (int i=0; i<6; i++)
        {
            Card temp[5];
            for(int a=0; a<5; a++)
            {
                temp[a]=d.popCard();
            }
            table[i]= Player(temp);
        }

        

        cout<<"*** Here are the six hands ... \n";

        for (Player &p : table)
        {
            p.showHand();
            p.rankHand();
        }
      

        cout<<"\n*** Here is what remains in the deck: \n";
        d.showDeck();

        cout<<'\n'<<endl;

        cout<<"---WINNING HAND ORDER---\n";
        ShowWinners(table);

        
    }


}


static void ShowWinners(Player players[6])
{
    vector <vector<Player>> rankTiers;
    
    for(int i=0; i<10; i++)
    {
        rankTiers.push_back(vector<Player>());
    }

    for(int i=0; i<6; i++)
    {
        rankTiers[players[i].numRank].push_back(players[i]);
    }

    for(vector<Player> v : rankTiers)
    {
        if(v.size()>1)
        {
            tieBreak(v);
        }
    }



}


static void tieBreak(vector<Player> &v) //assuming there are at least 2 items in the vector we are changing the array so pass by reference
{
    switch(v[0].numRank)
    {
        case 0:
            
            break;

        case 1:

            break;
        case 2:

            break;
        case 3:

            break;
        case 4:

            break;
        case 5:

            break;
        case 6:

            break;
        case 7:

            break;
        case 8:

            break;
        case 9:

            break;
    }

}