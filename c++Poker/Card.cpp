#include <iostream>
#include <bits/stdc++.h>
#include "Card.h"
#include <string>
using namespace std;


 
        Card::Card()
        {
                Face=0;
                Suit=0;
        }
        Card::Card(int f, int s) //no pass by reference since we are not trying to change the value passed
        {
            Face=f;
            Suit=s;
        }

        Card::Card(const string& card)
        {
            switch(card[0])
            {
                case 'A':
                        Face=1;
                        break;
                case 'K':
                        Face=13;
                        break;
                case 'Q':
                        Face=12;
                        break;
                case 'J':
                        Face=11;
                        break;
                case '1':
                        Face=10;
                        break;

                default:
                    Face=(int)card[0]-'0';
                        break;
            }
            switch(card[card.length()-1])
            {
                case 'S':
                        Suit=1;
                        break;
                case 'H':
                        Suit=2;
                        break;
                case 'C':
                        Suit=3;
                        break;
                case 'D':
                        Suit=4;
                        break;
            }
        }

        void Card:: printCard()
        {
            switch(Face)
            {
                case 1:
                        cout<<"A";
                        break;
                case 13:
                        cout<<"K";
                        break;
                case 12:
                        cout<<"Q";
                        break;
                case 11:
                        cout<<"J";
                        break;
                case 14:
                        cout<<"A";
                        break;
                default:
                        cout<<Face;
                        break;
            }
            switch(Suit)
            {
                case 1:
                        cout<<"S";
                        break;
                case 2:
                        cout<<"H";
                        break;
                case 3:
                        cout<<"C";
                        break;
                case 4:
                        cout<<"D";
                        break;
            }

        }


        bool Card:: operator<(const Card& other) const
        {
                if(Face <other.Face)
                        return true;
                else if(Face==other.Face)
                        return other.Suit<Suit;
                return false;      
        }
        //  bool Card:: operator=(const Card& other) const
        //  {
        //         other.Face=Face;
        //         other.Suit=Suit;
        //  }





