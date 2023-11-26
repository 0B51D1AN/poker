package Deck;

use strict;
use warnings;
use FindBin qw($RealBin);
use lib $RealBin;
use Card;
use List::Util qw(shuffle);

sub new {
    my $class = shift;
    my @deck;
    for my $suit (1..4) {
        for my $face (1..13) {
            my $card = Card->new($face, $suit);
            push @deck, $card;
        }
    }
    my $self = {
        deck => \@deck
    };
    bless $self, $class;
    return $self;
}

sub shuffle_deck {
    my ($self) = @_;
    @{$self->{deck}} = List::Util::shuffle @{$self->{deck}};
}

sub pop_card {
    my ($self) = @_;
    return pop @{$self->{deck}};
}

sub show_deck {
    my ($self) = @_;
    foreach my $index (0..$#{$self->{deck}}) {
        $self->{deck}[$index]->printCard();
        print " ";
        if (($index + 1) % 13 == 0) {
            print "\n";
        }
    }
    print "\n";
}

1; # To indicate successful package loading
