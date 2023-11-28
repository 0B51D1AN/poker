
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
        h_rank => []
    };
    bless $self, $class;
    return $self;
}

sub with_cards {
    my ($class, @cards) = @_;
    my $self = {
        handRank => "",
        numRank => -1,
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

sub clone {
    my ($self) = @_;
    
    my $class = ref($self) || $self;
    my $cloned_player = $class->new();
    
    # Copying attributes from the original player to the cloned player
    $cloned_player->{handRank} = $self->{handRank};
    $cloned_player->{numRank} = $self->{numRank};
    $cloned_player->{hand} = [ @{$self->{hand}} ];  # Creating a shallow copy of the array
    $cloned_player->{h_rank} = [ @{$self->{h_rank}} ];  # Creating a shallow copy of the array
    
    return $cloned_player;
}

sub rank_hand {
    my ($self) = @_;

    @{$self->{hand}} = sort { $a->{face} <=> $b->{face} } @{$self->{hand}};
    #print @self->{hand};

    if ($self->is_flush() && $self->is_straight()) {
        if ($self->{hand}[0]->{face} == 1 && $self->{hand}[4]->{face} == 13) {
            $self->{handRank} = "Royal Flush";
            $self->{numRank} = 0;
            push @{$self->{h_rank}}, $self->{hand}[0]->clone();
            return;
        }
        $self->{handRank} = "Straight Flush";
        $self->{numRank} = 1;
        push @{$self->{h_rank}}, $self->{hand}[0]->{face} == 1 ? $self->{hand}[0]->clone() : $self->{hand}[4]->clone();
        return;
    }

    if ($self->is_four_of_kind()) {
        $self->{handRank} = "Four of a Kind";
        $self->{numRank} = 2;
        push @{$self->{h_rank}}, $self->{hand}[1]->clone(); # Must be one of the four
        return;
    }

    if ($self->is_full_house()) {
        $self->{handRank} = "Full House";
        $self->{numRank} = 3;
        push @{$self->{h_rank}}, $self->{hand}[2]->clone(); # Must be 3pair
        return;
    }

    if ($self->is_flush()) {
        $self->{handRank} = "Flush";
        $self->{numRank} = 4;
        return;
    }

    if ($self->is_straight()) {
        $self->{handRank} = "Straight";
        $self->{numRank} = 5;
        push @{$self->{h_rank}}, $self->{hand}[4]->clone();
        return;
    }

    if ($self->is_three_of_kind()) {
        $self->{handRank} = "Three of a Kind";
        $self->{numRank} = 6;
        push @{$self->{h_rank}}, $self->{hand}[2]->clone();
        return;
    }

    if ($self->is_two_pair()) {
        $self->{handRank} = "Two Pair";
        $self->{numRank} = 7;
        if ($self->{h_rank}[0]->{face} == 1) {
            $self->{h_rank}[0]->set_face(14);
        }
        # No specific card to add to h_rank
        return;
    }

    if ($self->is_pair()) {
        $self->{handRank} = "Pair";
        $self->{numRank} = 8;
        if ($self->{h_rank}[0]->{face} == 1) {
            $self->{h_rank}[0]->{face}=14;
        }
       foreach my $card (@{ $self->{hand} }) {
            if ($card->{face} != $self->{h_rank}[0]->{face}) {
                push @{$self->{h_rank}}, $card->clone();
            }
        }
        return;
    }

    $self->{handRank} = "High Card";
    $self->{numRank} = 9;
}


sub is_straight {
    my ($self) = @_;

   # return 0 unless @{$self->{hand}} >= 5; 
    if ($self->{hand}[0]->{face} == 1 && $self->{hand}[1]->{face} == 10 &&
        $self->{hand}[2]->{face} == 11 && $self->{hand}[3]->{face} == 12 &&
        $self->{hand}[4]->{face} == 13) {
        return 1;
    }

    for (my $i = 0; $i < 4; $i++) {
        if ($self->{hand}[$i + 1]->{face} != $self->{hand}[$i]->{face} + 1) {
            return 0;
        }
    }
    return 1;
}

sub is_flush {
    my ($self) = @_;
    #return 0 unless @{$self->{hand}} >= 5; 
      
    my $first_card= $self->{hand}[0];
    #print $first_card->{suit};
   # print ref($first_card);
    my $first_suit= $first_card->{suit};
    #print ref($first_suit);
    for my $card (@{$self->{hand}}) {
        if ($card->{suit} != $first_suit) {
            return 0;
        }
    }
    return 1;
}

sub is_four_of_kind {
    my ($self) = @_;

    my @face_counts = (0) x 14; # Index 0 represents Face 1 (Ace), and index 13 represents Face 13 (King)
    for my $card (@{$self->{hand}}) {
        $face_counts[$card->{face}]++;
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
        $face_counts[$card->{face}]++;
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
        $face_counts[$card->{face}]++;
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
        $face_counts[$card->{face}]++;
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
        $face_counts[$card->{face}]++;
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