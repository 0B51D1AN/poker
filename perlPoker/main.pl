#!/usr/bin/perl
use strict;
use warnings;
use FindBin qw($RealBin);
use lib $RealBin;
use Card;  # Include the Card module
use Deck;
use Player
# Create a Card object
my $card = Card->new(13, 2);  # King of Hearts
my $card_from_string = Card->from_string('AS');
#$card_from_string->printCard();


my $deck=Deck->new();

$deck->show_deck();

my @hand = (
    Card->new(1, 1),  # Ace of Spades
    Card->new(2, 1),  # Two of Spades
    Card->new(3, 1),  # Three of Spades
    Card->new(4, 1),  # Four of Spades
    Card->new(5, 1),  # Five of Spades
);

# Create a Player object with the test hand
my $test_player = Player->new(\@hand);

# Rank the test player's hand
$test_player->rank_hand();

# Display the hand and its rank
$test_player->showHand();
print "Hand Rank: " . $test_player->get_hand_rank() . "\n";

# Print the card information using the printCard() function
#$card->printCard();
