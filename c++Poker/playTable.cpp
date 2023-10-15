#include <iostream>
#include <list>
//#include "Card.cpp"
#include "Player.h"
using namespace std;
#include "Deck.cpp"
#include <fstream>
#include <sstream>

static void ShowWinners(Player players[]);
static void tieBreak(vector<Player> &v);

int main(int argc, char* argv[])
{

    
    if(argv[1]!=NULL)
    {
        //cout<<argv[1];
        ifstream file(argv[1]);
        Player players[6];

        if (file) 
        {
            string line;
            int a=0;
            while (getline(file, line)) {
                
                stringstream ss(line);
                Card cards[5];
                string card;
                int i=0;
                while (getline(ss, card, ',' )) {
                    
                    card.erase(remove_if(card.begin(), card.end(), ::isspace), card.end());
                    cards[i]=card;
                    i++;
                }

                Player player(cards);
                //player.setHand(cards);
                players[a]=player;
                a++;
            }

        }
        cout<<"*** Using Test Deck ***\n\n";
        cout<<"*** File:  "<<argv[1]<<endl;
        for(Player &p : players)
        {
            p.showHand();
            p.rankHand();
        }
        cout<<"\n---Winning Hand Order---\n";
        ShowWinners(players);


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

    for(vector<Player> &v : rankTiers)
    {
        if(v.size()>1)
        {
            tieBreak(v);
        }
    }
    for(vector<Player> v : rankTiers)
    {
        if(!v.empty())
        {
            for(Player p : v)
            {
                p.showHand();
            }
        }
    }



}


static void tieBreak(vector<Player> &v) //assuming there are at least 2 items in the vector we are changing the array so pass by reference
{
    switch(v[0].numRank)
    {
        case 0:
            sort(v.begin(), v.end(), Player::compareBySuit);
            reverse(v.begin(), v.end());
            break;
        case 1:
            sort(v.begin(), v.end(), Player::compareByHighCard);//
            reverse(v.begin(), v.end());
            break;
        case 2:
            sort(v.begin(), v.end(), Player::compareByCard);//
            reverse(v.begin(), v.end());
            break;
        case 3:
            sort(v.begin(), v.end(), Player::compareByCard);//
            reverse(v.begin(), v.end());
            break;
        case 4:
            sort(v.begin(), v.end(), Player::compareBySuit);//
            reverse(v.begin(), v.end());
            break;
        case 5:
            sort(v.begin(), v.end(), Player::compareByHighCard);//
            reverse(v.begin(), v.end());
            break;
        case 6:
            sort(v.begin(), v.end(), Player::compareByCard);//
            reverse(v.begin(), v.end());
            break;
        case 7:
            sort(v.begin(), v.end(), Player::compareByCard);//Still need to sort out specific ties
            reverse(v.begin(), v.end());    
            break;
        case 8:
            for(Player &p : v)
            {   
                if(p.hRank[0].Face==1)
                {
                    p.hRank[0].Face=14;
                    //sort(p.hand.begin(), p.hand.end());
                }
            }
            sort(v.begin(), v.end(), Player::compareByCard);//
            reverse(v.begin(), v.end());
            break;
        case 9:
            for(Player &p : v)
            {   
                if(p.hand[0].Face==1)
                {
                    p.hand[0].Face=14;
                    //p.rankHand();
                    sort(p.hand.begin(), p.hand.end());
                }
            }
            sort(v.begin(), v.end(), Player::compareByHighCard);
            reverse(v.begin(), v.end());
            break;
    }

}