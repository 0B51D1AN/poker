import random
import csv
import sys


class Deck:
    def __init__(self):
        # Create a deck of 52 cards
        self.cards = [(suit, face) for suit in range(1, 5) for face in range(1, 14)]

    def shuffle(self):
        # Shuffle the deck
        random.shuffle(self.cards)

    def deal(self):
        # Deal one card from the top of the deck
        if len(self.cards) > 0:
            return self.cards.pop()
        else:
            return None  # Return None if the deck is empty

    def showDeck(self):
        
        
        for card in self.cards:
            suits = ["S", "H", "C", "D"]
            faces = [str(i) for i in range(2, 11)] + ["J", "Q", "K", "A"]
            suit_str = suits[card[0] - 1]
            face_str = faces[card[1] - 1]
            print(face_str + suit_str, end= " ")

    def card_to_string(self, card):
        # Convert a card tuple (suit, face) to a string representation
        suits = ["S", "H", "C", "D"]
        faces = [str(i) for i in range(2, 11)] + ["J", "Q", "K", "A"]
        suit_str = suits[card[0] - 1]
        face_str = faces[card[1] - 1]
        return f"{face_str}{suit_str}"

    

class Player:
    def __init__(self):
        self.hand = []
        self.handRank=""
    def collect_cards(self, cards):
        # Collect a list of cards into the player's hand
        self.hand.extend(cards)

    def show_hand(self):
        # Show the cards in the player's hand
        for card in self.hand:
            print(self.card_to_string(card), end=" ")
        if(self.handRank is not ""):
            print(" - "+self.handRank)
        else:
            print()

    def card_to_string(self, card):
        # Convert a card tuple (suit, face) to a string representation
        suits = ["S", "H", "C", "D"]
        faces = [str(i) for i in range(2, 11)] + ["J", "Q", "K", "A"]
        suit_str = suits[card[0] - 1]
        face_str = faces[card[1] - 1]
        return f"{face_str}{suit_str}"
    
            
    def organize_hand_by_face(self):
        # Organize the player's hand by the face value of the cards
        self.hand.sort(key=lambda card: card[1])

    #def is_straight(self):
        # Check for a Straight
     #   sorted_faces = sorted(set(card[1] for card in self.hand))
      #  return len(sorted_faces) == 5 and sorted_faces[-1] - sorted_faces[0] == 4


    

    def determine_hand_rank(self):
        # Sort the hand by face value
        self.organize_hand_by_face()

        # Check for different hand rankings in decreasing order of importance
        if self.is_straight_flush() and self.hand[0][1] == 10:
            self.handRank= "Royal Flush"
        elif self.is_straight_flush():
            self.handRank = "Straight Flush"
        elif self.is_four_of_a_kind():
            self.handRank = "Four of a Kind"
        elif self.is_full_house():
            self.handRank = "Full House"
        elif self.is_flush():
            self.handRank = "Flush"
        elif self.is_straight():
            self.handRank = "Straight"
        elif self.is_three_of_a_kind():
            self.handRank = "Three of a Kind"
        elif self.is_two_pair():
            self.handRank = "Two Pair"
        elif self.is_one_pair():
            self.handRank = "Pair"
        else:
            self.handRank = "High Card"
    
    def is_straight_flush(self):
        # Check for a straight flush (consecutive cards of the same suit)
        for i in range(1, len(self.hand)):
            if self.hand[i][0] != self.hand[i - 1][0] or self.hand[i][1] != self.hand[i - 1][1] + 1:
                return False
        return True

    def is_four_of_a_kind(self):
        # Check for four cards with the same face value
        for i in range(2, len(self.hand)):
            if self.hand[i][1] == self.hand[i - 1][1] == self.hand[i - 2][1] == self.hand[i - 3][1]:
                return True
        return False

    def is_full_house(self):
        # Check for a full house (three cards of one face value and two cards of another)
        if (self.hand[0][1] == self.hand[1][1] == self.hand[2][1] and
            self.hand[3][1] == self.hand[4][1]) or \
           (self.hand[0][1] == self.hand[1][1] and
            self.hand[2][1] == self.hand[3][1] == self.hand[4][1]):
            return True
        return False

    def is_flush(self):
        # Check for a flush (cards of the same suit)
        for i in range(1, len(self.hand)):
            if self.hand[i][0] != self.hand[i - 1][0]:
                return False
        return True

    def is_straight(self):
        # Check for a straight (consecutive cards)
        for i in range(1, len(self.hand)):
            if self.hand[i][1] != self.hand[i - 1][1] + 1:
                return False
        return True

    def is_three_of_a_kind(self):
        # Check for three cards with the same face value
        for i in range(2, len(self.hand)):
            if self.hand[i][1] == self.hand[i - 1][1] == self.hand[i - 2][1]:
                return True
        return False

    def is_two_pair(self):
        # Check for two pairs of cards with the same face value
        pairs = 0
        for i in range(1, len(self.hand)):
            if self.hand[i][1] == self.hand[i - 1][1]:
                pairs += 1
                if pairs == 2:
                    return True
        return False

    def is_one_pair(self):
        # Check for one pair of cards with the same face value
        for i in range(1, len(self.hand)):
            if self.hand[i][1] == self.hand[i - 1][1]:
                return True
        return False






def read_hands_from_csv(file_path):
    hands = []
    with open(file_path, 'r') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            hand = [card.strip() for card in row]
            if len(hand) != 5:
                print("Each hand must have exactly 5 cards.")
                sys.exit(1)
            if len(set(hand)) != 5:
                print("Duplicate cards detected in a hand. Each card must be unique.")
                sys.exit(1)
            hands.append(hand)
    return hands



if __name__ == "__main__":
    # Create a deck, shuffle it, and deal some cards
    if len(sys.argv) == 2:
        input_file = sys.argv[1]

        print("File read: "+input_file)


        players = [Player() for _ in range(6)]

        hands = read_hands_from_csv(input_file)


        for i, hand in enumerate(hands):
            for card_str in hand:
                suit, face = card_str[-1], card_str[:-1]
                suit_num = {'S': 1, 'H': 2, 'C': 3, 'D': 4}[suit]
                face_num = {'A': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9, '10': 10, 'J': 11, 'Q': 12, 'K': 13}[face]
                card = (suit_num, face_num)
                players[i].collect_cards([card])

        print("\nHere are the hands: ")

        for i in players:
            i.show_hand()
            i.determine_hand_rank()

        print("\nHands in Winning order: ")

        hand_rank_values = {
        "Royal Flush": 10,
        "Straight Flush": 9,
        "Four of a Kind": 8,
        "Full House": 7,
        "Flush": 6,
        "Straight": 5,
        "Three of a Kind": 4,
        "Two Pair": 3,
        "Pair": 2,
        "High Card": 1,
    }

        players.sort(key=lambda player: hand_rank_values.get(player.handRank, 0), reverse=True)

        
            
        
        

        
    else:


        deck = Deck()
        deck.shuffle()
        print("Shuffled Deck: ")
        deck.showDeck()

        
        table= [Player(), Player(), Player(), Player(), Player(), Player()]
        

        for i in table:
        # Collect 5 cards from the deck for the player
            for _ in range(5):
                card = deck.deal()
                if card is not None:
                    i.collect_cards([card])

        #player1.determine_hand_rank()
        print("\n\nHere are the hands: ")
        for player in table:
            player.show_hand()
            player.determine_hand_rank()
            print(f"Hand Rank: {player.handRank}")

        print("\n\nRemaining Cards in the deck: ")
        deck.showDeck()


        print("\n\nHands in winning order: \n")
        #table[0].determine_hand_rank()
        #table[0].show_hand()

        hand_rank_values = {
        "Royal Flush": 10,
        "Straight Flush": 9,
        "Four of a Kind": 8,
        "Full House": 7,
        "Flush": 6,
        "Straight": 5,
        "Three of a Kind": 4,
        "Two Pair": 3,
        "Pair": 2,
        "High Card": 1,
    }


        royalFlush=[]
        straightFlush=[]
        fourofaKind=[]
        fullHouse=[]
        flush=[]
        straight=[]
        threeofaKind=[]
        twoPair=[]
        pair=[]
        highCard=[]
    

    


                
        