
package Player;

use strict;
use warnings;
use FindBin qw($RealBin);
use lib $RealBin;
use Card; # Assuming Card.pm is required

sub new {
    my $class = shift;
    my $self = {
        handRank => "",
        numRank => -1,
        hand => [],
        hRank => []
    };
    bless $self, $class;
    return $self;
}

sub with_cards {
    my ($class, @cards) = @_;
    my $self = {
        hand_rank => "",
        num_rank => -1,
        hand => \@cards,
        h_rank => []
    };
    bless $self, $class;
    return $self;
}

sub pushCard {
    my ($self, $c) = @_;
    push @{$self->{hand}}, $c;
}

sub showHand {
    my ($self) = @_;
    for my $c (@{$self->{hand}}) {
        $c->printCard();
        print " ";
    }
    if ($self->{handRank} eq "") {
        print "\n";
    } else {
        print " - $self->{handRank}\n";
    }
}

sub rank_hand {
    my ($self) = @_;

    my @sorted_hand = sort { $a->get_face() <=> $b->get_face() } @{$self->{hand}};

    if ($self->is_flush() && $self->is_straight()) {
        if ($sorted_hand[0]->get_face() == 1 && $sorted_hand[4]->get_face() == 13) {
            $self->{hand_rank} = "Royal Flush";
            $self->{num_rank} = 0;
            push @{$self->{h_rank}}, $sorted_hand[0]->clone();
            return;
        }
        $self->{hand_rank} = "Straight Flush";
        $self->{num_rank} = 1;
        push @{$self->{h_rank}}, $sorted_hand[0]->get_face() == 1 ? $sorted_hand[0]->clone() : $sorted_hand[4]->clone();
        return;
    }

    if ($self->is_four_of_kind()) {
        $self->{hand_rank} = "Four of a Kind";
        $self->{num_rank} = 2;
        push @{$self->{h_rank}}, $sorted_hand[1]->clone(); # Must be one of the four
        return;
    }

    if ($self->is_full_house()) {
        $self->{hand_rank} = "Full House";
        $self->{num_rank} = 3;
        push @{$self->{h_rank}}, $sorted_hand[2]->clone(); # Must be 3pair
        return;
    }

    if ($self->is_flush()) {
        $self->{hand_rank} = "Flush";
        $self->{num_rank} = 4;
        return;
    }

    if ($self->is_straight()) {
        $self->{hand_rank} = "Straight";
        $self->{num_rank} = 5;
        push @{$self->{h_rank}}, $sorted_hand[4]->clone();
        return;
    }

    if ($self->is_three_of_kind()) {
        $self->{hand_rank} = "Three of a Kind";
        $self->{num_rank} = 6;
        push @{$self->{h_rank}}, $sorted_hand[2]->clone();
        return;
    }

    if ($self->is_two_pair()) {
        $self->{hand_rank} = "Two Pair";
        $self->{num_rank} = 7;
        if ($self->{h_rank}[0]->get_face() == 1) {
            $self->{h_rank}[0]->set_face(14);
        }
        # No specific card to add to h_rank
        return;
    }

    if ($self->is_pair()) {
        $self->{hand_rank} = "Pair";
        $self->{num_rank} = 8;
        if ($self->{h_rank}[0]->get_face() == 1) {
            $self->{h_rank}[0]->set_face(14);
        }
        foreach my $card (@sorted_hand) {
            if ($card->get_face() != $self->{h_rank}[0]->get_face()) {
                push @{$self->{h_rank}}, $card->clone();
            }
        }
        return;
    }

    $self->{hand_rank} = "High Card";
    $self->{num_rank} = 9;
}


sub is_straight {
    my ($self) = @_;

    if ($self->{hand}[0]->get_face() == 1 && $self->{hand}[1]->get_face() == 10 &&
        $self->{hand}[2]->get_face() == 11 && $self->{hand}[3]->get_face() == 12 &&
        $self->{hand}[4]->get_face() == 13) {
        return 1;
    }

    for (my $i = 0; $i < 4; $i++) {
        if ($self->{hand}[$i + 1]->get_face() != $self->{hand}[$i]->get_face() + 1) {
            return 0;
        }
    }
    return 1;
}

sub is_flush {
    my ($self) = @_;

    my $first_suit = $self->{hand}[0]->get_suit();
    for my $card (@{$self->{hand}}) {
        if ($card->get_suit() != $first_suit) {
            return 0;
        }
    }
    return 1;
}

sub is_four_of_kind {
    my ($self) = @_;

    my @face_counts = (0) x 14; # Index 0 represents Face 1 (Ace), and index 13 represents Face 13 (King)
    for my $card (@{$self->{hand}}) {
        $face_counts[$card->get_face()]++;
    }

    for my $count (@face_counts) {
        if ($count == 4) {
            return 1;
        }
    }
    return 0;
}

sub is_full_house {
    my ($self) = @_;

    my @face_counts = (0) x 14;
    for my $card (@{$self->{hand}}) {
        $face_counts[$card->get_face()]++;
    }

    my $has_three = 0;
    my $has_two = 0;
    for my $count (@face_counts) {
        if ($count == 3) {
            $has_three = 1;
        } elsif ($count == 2) {
            $has_two = 1;
        }
    }
    return $has_three && $has_two;
}

sub is_three_of_kind {
    my ($self) = @_;

    my @face_counts = (0) x 14;
    for my $card (@{$self->{hand}}) {
        $face_counts[$card->get_face()]++;
    }

    for my $count (@face_counts) {
        if ($count == 3) {
            return 1;
        }
    }
    return 0;
}

sub is_two_pair {
    my ($self) = @_;

    my @face_counts = (0) x 14;
    for my $card (@{$self->{hand}}) {
        $face_counts[$card->get_face()]++;
    }

    my @pairs = grep { $face_counts[$_] == 2 } 0..$#face_counts;
    if (@pairs == 2) {
        for my $face (@pairs) {
            push @{$self->{h_rank}}, Card->new($face, 1); # Arbitrary suit value 1
        }
        return 1;
    } else {
        return 0;
    }
}

sub is_pair {
    my ($self) = @_;

    my @face_counts = (0) x 14;
    for my $card (@{$self->{hand}}) {
        $face_counts[$card->get_face()]++;
    }

    my @pairs = grep { $face_counts[$_] == 2 } 0..$#face_counts;
    if (@pairs == 1) {
        push @{$self->{h_rank}}, Card->new($pairs[0], 1); # Arbitrary suit value 1
        return 1;
    } else {
        return 0;
    }
}



1;