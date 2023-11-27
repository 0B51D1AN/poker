package Card;

sub new {
    my ($class, $face, $suit) = @_;
    my $self = {
        face => $face,
        suit => $suit
    };
    bless $self, $class;
    return $self;
}

sub get_face {
    my ($self) = @_;
    bless $self, $class;
    return $self->{face};
}

sub get_suit {
    my ($self) = @_;
    bless $self, $class;
    return $self->{suit};
}

sub set_face{
    my ($class, $f) = @_;
    $self->{face}=$f;

}

sub printCard {
    my ($self) = @_;
    my $face = $self->{face};
    my $suit = $self->{suit};

    # Mapping face values to corresponding cards
    my %face_map = ( 1=>'A', 11 => 'J', 12 => 'Q', 13 => 'K', 14 => 'A');
    $face = $face_map{$face} if exists $face_map{$face};

    # Mapping suit numbers to suit names
    my %suit_map = (1 => 'S', 2 => 'H', 3 => 'C', 4 => 'D');
    my $suit_name = $suit_map{$suit};

    print "$face$suit_name";
}

sub clone {
    my ($self) = @_;
    return bless { %$self }, ref($self);
}

sub from_string {
    my ($class, $card_string) = @_;

    my %face_map = ('J' => 11, 'Q' => 12, 'K' => 13, 'A'=>1);
    my %suit_map = ('S' => 1, 'H' => 2, 'C' => 3, 'D' => 4);

    my ($face_str, $suit_str);
    
    if ($card_string =~ /^(10)(\w)$/) {
        $face_str = $1;
        $suit_str = $2;
    } elsif ($card_string =~ /^(\w)(\w)$/) {
        $face_str = $1;
        $suit_str = $2;
    } else {
        die "Invalid card format: $card_string";
    }

    my $face = $face_map{$face_str} // int($face_str);
    my $suit = $suit_map{$suit_str};

    return bless { face => $face, suit => $suit }, $class;
}

1;  # To indicate successful package loading
