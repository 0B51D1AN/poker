#!/usr/bin/perl
use strict;
use warnings;
use FindBin qw($RealBin);
use lib $RealBin;
use Card;  # Include the Card module
use Deck;
use Player;
use Text::CSV;
use feature 'switch';

my @players;



# Check if a filename argument is provided
if (scalar @ARGV == 1) {
   my $file = $ARGV[0];

    my $csv = Text::CSV->new({ binary => 1, eol => $/ }) or die "Cannot use CSV: " . Text::CSV->error_diag();

    open my $fh, '<', $file or die "Unable to open file: $!";

    my @rows;
    while (my $row = $csv->getline($fh)) {
        push @rows, $row;
    }


    

    foreach my $row (@rows) {
        my @hand;
       foreach my $card (@$row) 
       {

            $card =~ s/\s+//g;  
            my $tempCard= Card->from_string($card); 
            push @hand, $tempCard;

       }
        my $player = Player->with_cards(@hand);
        push @players, $player;
    }
    for my $player (@players) {
        $player->rank_hand(); 
        #$player->showHand();  # Assuming you have a showHand method in the Player class
        
    }
    close $fh;

    show_winners(@players);
}
else
{

    my $deck=Deck->new();

    

    # Create 6 Player objects and store them in the array
    for (my $i = 0; $i < 6; $i++) {
        my $player = Player->new();
        push @players, $player;
    }

    print "*** USING RANDOMIZED DECK OF CARDS ***\n\n";

    print "*** Shuffled 52 card deck:\n";
    $deck->shuffle_deck();

    $deck->show_deck();

    for my $a (0..4) {
        
        for my $i (0..5) {
            my $card = $deck->pop_card();
            $players[$i]->pushCard($card);
        }
        
        
    }

    print "*** Here are the six hands...\n\n";

    for my $player (@players) {
        
        $player->showHand();   
        $player->rank_hand();
    }

    print "\n*** Here is what remains in the deck...\n\n";

    $deck->show_deck();


    print "\n---WINNING HAND ORDER---\n\n";

    show_winners(@players);

}




##########################################################################
#FUNCTIONS

sub show_winners {
    my ($players) = @_;

    my @rank_tiers = map { [] } (0..9);  # Initializing 10 empty arrays

    foreach my $player (@players) {
        push @{$rank_tiers[$player->{numRank}]}, $player->clone();
    }

    foreach my $v (@rank_tiers) {
        if (@$v > 1) {
            tie_break($v);
        }
    }

    foreach my $v (@rank_tiers) {
        if (@$v) {
            foreach my $player (@$v) {
                #print ref($player);
                $player->showHand();
            }
        }
    }
}

sub tie_break {
    my ($players) = @_;

    my $num_rank = $players->[0]{numRank};
    
    if ($num_rank == 0 || $num_rank == 1 || $num_rank == 4) {
        @$players = sort { $b->{hand}[4]{suit} <=> $a->{hand}[4]{suit} } @$players;
    }
    elsif ($num_rank == 2 || $num_rank == 3 || $num_rank == 6) {
       foreach my $player (@$players) {
            foreach my $card (@{$player->{hand}}) {
                $card->{face} = 14 if $card->{face} == 1;
            }
            @{$player->{hand}} = sort { $a->{face} <=> $b->{face} } @{$player->{hand}};
        }

        @$players = sort { $b->{hand}[2]{face} <=> $a->{hand}[2]{face} } @$players;
    }
    elsif ($num_rank == 5) {
        @$players = sort {compare_by_suit($a,$b)} @$players;
    }
    elsif ($num_rank == 7) {
         foreach my $player (@$players) {
            foreach my $card (@{$player->{hand}}) {
                $card->{face} = 14 if $card->{face} == 1;
            }
            @{$player->{hand}} = sort { $a->{face} <=> $b->{face} } @{$player->{hand}};
        }
        @$players = sort {compare_two_pair($a,$b)} @$players;
    }
    elsif ($num_rank == 8) {
         foreach my $player (@$players) {
            foreach my $card (@{$player->{hand}}) {
                $card->{face} = 14 if $card->{face} == 1;
            }
            @{$player->{hand}} = sort { $a->{face} <=> $b->{face} } @{$player->{hand}};
        }
        @$players = sort {compare_pair($a,$b)} @$players;
    }
    elsif ($num_rank == 9) {
        foreach my $player (@$players) {
            foreach my $card (@{$player->{hand}}) {
                $card->{face} = 14 if $card->{face} == 1;
            }
            @{$player->{hand}} = sort { $a->{face} <=> $b->{face} } @{$player->{hand}};
        }
        @$players = sort { compare_by_high_card($a, $b) } @$players;

    }
}

sub compare_by_suit {
     my ($a, $b) = @_;
 # print ref($a), "\n";  
    if ($a->{hand}[4]->{suit} == $b->{hand}[4]->{suit}) {
        return $b->{hand}[4]{face} <=> $a->{hand}[4]{face};
    }
    return $a->{hand}[4]{suit} <=> $b->{hand}[4]{suit};
}

sub compare_by_high_card {
    my ($a, $b) = @_;
    #print ref($a);
    #print "yo";
    if ($a->{hand}[4]{face} == $b->{hand}[4]{face}) {
         if ($a->{hand}[4]{suit} == $b->{hand}[4]{suit}) {
            return $b->{hand}[4]{face} <=> $a->{hand}[4]{face};
        }
       return $a->{hand}[4]{suit} <=> $b->{hand}[4]{suit};
    }
    return $b->{hand}[4]{face} <=> $a->{hand}[4]{face};
}

sub compare_two_pair {
    my ($a, $b) = @_;

    if ($a->{h_rank}[1]{face} == $b->{h_rank}[1]{face}) {
        if ($a->{h_rank}[0]{face} == $b->{h_rank}[0]{face}) 
        {
            if ($a->{hand}[4]->{suit} == $b->{hand}[4]->{suit})
            {
                return $b->{hand}[4]{face} <=> $a->{hand}[4]{face};
            }
            return $a->{hand}[4]{suit} <=> $b->{hand}[4]{suit};
        }
        return $b->{h_rank}[0]{face} <=> $a->{h_rank}[0]{face};
    }
    return $b->{h_rank}[1]{face} <=> $a->{h_rank}[1]{face};
}


sub compare_pair {
    my ($a, $b) = @_;

    if ($a->{h_rank}[0]{face} == $b->{h_rank}[0]{face}) {
        
        return $b->{h_rank}[1]{suit} <=> $a->{h_rank}[1]{suit};
    }
    return $b->{h_rank}[0]{face} <=> $a->{h_rank}[0]{face};

}

1;