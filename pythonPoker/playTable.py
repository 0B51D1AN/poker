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
            print(self.card_to_string(card), end= " ")

    def card_to_string(self, card):
        # Convert a card tuple (suit, face) to a string representation
        suits = ["S", "H", "C", "D"]
        faces = [str(i) for i in range(2, 11)] + ["J", "Q", "K", "A","A"]
        suit_str = suits[card[0] - 1]
        face_str = faces[card[1] -2]
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
        faces = [str(i) for i in range(2, 11)] + ["J", "Q", "K", "A","A"]
        suit_str = suits[card[0] - 1]
        face_str = faces[card[1] -2]
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
       # print(self.show_hand())
        # Check for different hand rankings in decreasing order of importance
        if self.is_straight() and self.is_flush() and self.hand[0][1] == 1:
            self.handRank= "Royal Flush"
        elif self.is_flush() and self.is_straight():
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
        if self.hand[0][1]==1 and self.hand[1][1]== 10 and self.hand[2][1]== 11 and self.hand[3][1] == 12 and self.hand[4][1] == 13:
                return True
        for i in range(1, len(self.hand)):
            if self.hand[i][1] != self.hand[i - 1][1] + 1:
                return False
            
        return True

    def is_three_of_a_kind(self):
        # Check for three cards with the same face value
        for i in range(2, len(self.hand)):
            if self.hand[i][1] == self.hand[i - 1][1] == self.hand[i - 2][1]:
                if self.hand[i][1]==1:
                    self.set=14
                else:
                    self.set=self.hand[i][1]
                return True
        return False

    def is_two_pair(self):
        # Check for two pairs of cards with the same face value
        pairs = 0
        for i in range(1, len(self.hand)):
            if self.hand[i][1] == self.hand[i - 1][1]:
                if self.hand[i][1]==1:
                    self.pair1=14
                else:
                    self.pair1=self.hand[i][1]
                pairs += 1
                if pairs == 2:
                    self.pair2=self.hand[i][1]
                    if self.pair1==14:
                        temp=self.pair2
                        self.pair2= self.pair1
                        self.pair1=temp
                    for card in self.hand:
                        if card[1]!=self.pair1 and card[1] != self.pair2:
                            kicker= card[0]
                    return True
        return False

    def is_one_pair(self):
        # Check for one pair of cards with the same face value
        for i in range(1, len(self.hand)):
            if self.hand[i][1] == self.hand[i - 1][1]:
                if self.hand[i][1]==1:
                    self.pair=14
                    self.kicker=self.hand[4][0] #only need suit of card if card is ace, high card cannot be ace
                else:
                    self.pair=self.hand[i][1]
                    if i==4:
                        self.kicker= self.hand[2][0]
                    else:
                        self.kicker= self.hand[4][0]                        
                return True
        return False





readCards=[]
duplicateCards=[]
def read_hands_from_csv(file_path):
    hands = []
    with open(file_path, 'r') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            hand = [card.strip() for card in row]
            
            if len(hand) != 5:
                print("Each hand must have exactly 5 cards.")
                sys.exit(1)
            for card in hand:
                if card in readCards:
                    duplicateCards.append(card)
                readCards.append(card)
            hands.append(hand)
    if len(duplicateCards)>0:
        print("Duplicate Cards detected:")
        for card in duplicateCards:
            print(card)
        sys.exit(1)
    return hands

def tie_break(players, index):
    if index == 0:  # RoyalStraightFlush
        players.sort(key=lambda player: player.hand[4][0])  # Sort by suit
    elif index == 1:  # StraightFlush
        flush(players)
    elif index == 2:  # FourofaKind
        for player in players:
            if player.hand[0][1]==1:
                temp=player.hand[0][0]
                player.hand.pop(0)
                player.hand.append((temp, 14))
        players.sort(key=lambda player: player.hand[1][1], reverse=True)
    elif index == 3:  # FullHouse
        players.sort(key=lambda player: player.hand[2][1], reverse=True)
    elif index == 4:  # Flush
        flush(players)
    elif index == 5:  # Straight
        straight(players)
    elif index == 6:  # ThreeofaKind
        players.sort(key=lambda player: player.set, reverse=True)
    elif index == 7:  # TwoPair
        two_pair(players)
    elif index == 8:  # Pair
        pair(players)
    elif index == 9:  # HighCard
        high_card(players)


def flush(players):
    for player in players:
        if player.hand[0][1]==1:
            temp=player.hand[0][0]
            player.hand.pop(0)
            player.hand.append((temp, 14))
    players.sort(key=lambda player: player.hand[4][0], reverse=True)

    #Sorted in suit order, now check if there are flush of the same suit and break by highest card

    n = len(players)
    swapped = False

    for i in range(n - 1):
        swapped = False

        for j in range(n - 1 - i):
            if players[j].hand[4][0] == players[j + 1].hand[4][0]:
                if players[j].hand[4][1] < players[j + 1].hand[4][1]:
                    players[j], players[j + 1] = players[j + 1], players[j]
                swapped = True

        if not swapped:
            break

def straight(players):
    for player in players:
        if player.hand[0][1]==1 and player.hand[1][1]==10:
            temp=player.hand[0][0]
            player.hand.pop(0)
            player.hand.append((temp, 14))
    players.sort(key=lambda player: player.hand[4][1], reverse=True)


def two_pair(players):
    
    players.sort(key=lambda player: player.pair2, reverse= True)
    
    n = len(players)
    swapped = False

    for i in range(n - 1):
        swapped = False

        for j in range(n - 1 - i):
            if players[j].pair1 == players[j + 1].pair1 and players[j].pair2 == players[j+1].pair2:
                if players[j].kicker > players[j + 1].kicker:
                    players[j], players[j + 1] = players[j + 1], players[j]
                swapped = True

        if not swapped:
            break



def pair(players):
    
    
    players.sort(key=lambda player: player.pair, reverse= True)
    
    n = len(players)
    swapped = False

    for i in range(n - 1):
        swapped = False

        for j in range(n - 1 - i):
            if players[j].pair == players[j + 1].pair:
                if players[j].kicker > players[j + 1].kicker:
                    players[j], players[j + 1] = players[j + 1], players[j]
                swapped = True

        if not swapped:
            break


def high_card(players):
    
    for player in players:
        if player.hand[0][1]==1:
            temp=player.hand[0][0]
            player.hand.pop(0)
            player.hand.append((temp, 14))
            
    players.sort(key= lambda player: player.hand[4][1], reverse=True)
    
    n = len(players)
    swapped = False

    for i in range(n - 1):
        swapped = False

        for j in range(n - 1 - i):
            if players[j].hand[4][1] == players[j + 1].hand[4][1]:
                if players[j].hand[4][0] > players[j + 1].hand[4][0]:
                    players[j], players[j + 1] = players[j + 1], players[j]
                swapped = True

        if not swapped:
            break
    
    #players.sort(key=lambda player: player.hand[1][1])
    #players.reverse()

    
    


def rank_index(rank_name):
    for rank_tuple in hand_rank_values:
        if rank_tuple[0] == rank_name:
            return rank_tuple[1]
    return -1  # Default to 0 if the rank name is not found in the list

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

       #players.sort(key=lambda player: hand_rank_values.get(player.handRank, 0), reverse=True)

        hand_rank_values=[
        ("Royal Flush",0,[]),
        ("Straight Flush", 1, []),
        ("Four of a Kind", 2, []),
        ("Full House", 3, []),
        ("Flush", 4, []),
        ("Straight", 5, []),
        ("Three of a Kind", 6, []),
        ("Two Pair", 7, []),
        ("Pair", 8, []),
        ("High Card", 9, [])]

        # Create a dictionary to hold players grouped by hand rank
        players_by_rank = {rank[0]: rank[2] for rank in hand_rank_values}

        # Add each player to the corresponding list based on their hand rank
        for player in players:
            players_by_rank[player.handRank].append(player)


        for rank, player_list in players_by_rank.items():
            if rank in ["Royal Flush","Straight Flush", "Four of a Kind", "Full House", "Flush", "Straight", "Three of a Kind","Two Pair", "Pair", "High Card"]:
                tie_break(player_list, rank_index(rank))  # Run tie-breaker for all ranks


        for rank, player_list in players_by_rank.items():
           # print(f"Players with {rank}:")
            for player in player_list:
                player.show_hand()

            
        
        

        
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
            #print(f"Hand Rank: {player.handRank}")

        print("\n\nRemaining Cards in the deck: ")
        deck.showDeck()


        print("\n\nHands in winning order: \n")
        #table[0].determine_hand_rank()
        #table[0].show_hand()

        hand_rank_values=[
        ("Royal Flush",0,[]),
        ("Straight Flush", 1, []),
        ("Four of a Kind", 2, []),
        ("Full House", 3, []),
        ("Flush", 4, []),
        ("Straight", 5, []),
        ("Three of a Kind", 6, []),
        ("Two Pair", 7, []),
        ("Pair", 8, []),
        ("High Card", 9, [])]

        # Create a dictionary to hold players grouped by hand rank
        players_by_rank = {rank[0]: rank[2] for rank in hand_rank_values}

        # Add each player to the corresponding list based on their hand rank
        for player in table:
            players_by_rank[player.handRank].append(player)


        for rank, player_list in players_by_rank.items():
            if rank in ["Royal Flush","Straight Flush", "Four of a Kind", "Full House", "Flush", "Straight", "Three of a Kind","Two Pair", "Pair", "High Card"]:
                tie_break(player_list,rank_index(rank))  # Run tie-breaker for all ranks


        for rank, player_list in players_by_rank.items():
           # print(f"Players with {rank}:")
            for player in player_list:
                player.show_hand()

        
        
        
        
        
        
    


                
        