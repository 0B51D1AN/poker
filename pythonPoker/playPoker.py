from array import *
from operator import itemgetter, attrgetter
import sys
import random

class Card:
    def __init__(self, face, suit):
        self.face=face
        self.suit=suit

    def __repr__(self):
        f=self.face
        s=self.suit
        if self.face== 1:
            f="A"
        elif self.face== 11:
            f="J"
        elif self.face== 12:
            f="Q"
        elif self.face==13:
            f="K"
           
        if self.suit==1:
            s="S"
        elif self.suit==2:
            s="H"
        elif self.suit==3:
            s="C"
        elif self.suit==4:
            s="D"
    
        return f"{f}{s}"

class Player:
    def __init__(self):
        #self.name = name
        self.hand = []

    def draw(self, deck):
        card = deck.draw()
        if card:
            self.hand.append(card)
        else:
            print("The deck is empty.")

   # def rankHand(self):
    #    self.hand.sort(key=lambda card: card.face)
        #temp.showHand()
      
class Deck:
    def __init__(self):
        self.suits = ['S', 'H', 'C', 'D']
        self.values = [1,2,3,4,5,6,7,8,9,10,11,12,13]
        self.cards = [{'value': value, 'suit': suit} for suit in self.suits for value in self.values]

    def shuffle(self):
        random.shuffle(self.cards)

    def draw(self):
        if not self.is_empty():
            return self.cards.pop()
        else:
            return None

    def is_empty(self):
        return len(self.cards) == 0

    def printDeck(self):
        for c in self.cards:
            print(c.values+""+c.suits)



##################################################################################################







#p.rankHand()






arguments= sys.argv



if len(arguments)==2:
    print(arguments[1])



else:

    d=Deck()
    d.shuffle()
    d.printDeck()

    #Table=[Player(), Player(), Player(), Player(), Player(), Player()]
    
