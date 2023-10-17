module mainFunctions

    use class_Card
    use class_Player
    use class_Deck
    implicit none
contains

subroutine ShowWinners(players)
    !use class_Player
    type(Player), dimension(6) :: players
    type(Player), allocatable :: rankTiers(:,:)
    type(Player), dimension(:), allocatable :: rankRow
    type(Player), allocatable ::tempRow(:)
    integer, dimension(10) :: numPlayers
    integer :: tier, nPlayers, i

    allocate(rankTiers(10, size(players)))

    ! Initialize numPlayers to zero
    numPlayers = 0

    ! Initialize rankTiers
    do i = 1, 10
        nPlayers = 0  ! Initialize the number of players in players(i) tier
        do tier = 1, size(players)
            if (players(tier)%numRank == i) then
                nPlayers = nPlayers + 1
                rankTiers(i, nPlayers) = players(tier)
            end if
        end do
        numPlayers(i) = nPlayers
    end do   

    do i=1, size(rankTiers)
        if(numPlayers(i)>1) then
            call TieBreak(rankTiers(i,:))
        end if
    end do

    ! Display the winners
    do i = 1, size(rankTiers, 1)
        do tier = 1, numPlayers(i)
            call rankTiers(i, tier)%ShowHand()
        end do
    end do
    
   
end subroutine ShowWinners



subroutine TieBreak(players)
    use class_Player
    type(Player), dimension(:), intent(inout) :: players
    integer :: i

    ! Perform tie-breaking based on numRank
    select case (players(1)%numRank)
    case (1) ! Royal Flush
        call SortBySuit(players)
    case (2) ! Straight Flush
        call SortByHighCard(players)
    case (3, 4) ! Four of a Kind or Full House
        !call ConvertAceToHighCard(players)
        call SortByCard(players)
    case (5) ! Flush
        call SortBySuit(players)
    case (6) ! Straight
        call SortByHighCard(players)
    case (7) ! Three of a Kind
        !call ConvertAceToHighCard(players)
        call SortByCard(players)
    case (8) ! Two Pair
        call SortByTwoPair(players)
    case (9) ! Pair
        !SortByPair converts aces to high
        call SortByPair(players)
    case (10) ! High Card
        call ConvertAceToHighCard(players)
        call SortByHighCard(players)
    end select
end subroutine TieBreak


subroutine ConvertAceToHighCard(players)
    type(Player), dimension(:), intent(inout) :: players
    type(Card) :: temp
    integer :: i,j
    
    
    do i=1, size(players)
        if(players(i)%hand(1)%Face==1) then
            players(i)%hand(1)%Face=14
            call players(i)%RankHand()
        end if


    end do

end subroutine ConvertAceToHighCard

subroutine SortByHighCard(players)
    type(Player), dimension(:), intent(inout):: players
    integer :: i, j
    type(Player) :: temp

    do i = 1, size(players) - 1
        do j = i + 1, size(players)
            if (players(i)%hand(5)%Face < players(j)%hand(5)%Face) then
                temp = players(i)
                players(i) = players(j)
                players(j) = temp
            end if
            if (players(i)%hand(5)%Face == players(j)%hand(5)%Face) then
                if(players(i)%hand(5)%Suit > players(j)%hand(5)%Suit) then
                    temp = players(i)
                    players(i) = players(j)
                    players(j) = temp
                end if
            end if
        end do
    end do

end subroutine SortByHighCard

subroutine SortByCard(players)
    type(Player), dimension(:), intent(inout):: players
    integer :: i, j
    type(Player) :: temp

    do i = 1, size(players) - 1
        do j = i + 1, size(players)
            if (players(i)%hRank(1)%Face < players(j)%hRank(1)%Face) then
                temp = players(i)
                players(i) = players(j)
                players(j) = temp
            end if
        end do
    end do    

end subroutine SortByCard

subroutine SortBySuit(players)
    type(Player), dimension(:), intent(inout):: players
    integer :: i, j
    type(Player) :: temp

    do i = 1, size(players) - 1
        do j = i + 1, size(players)
            if (players(i)%hand(1)%Suit > players(j)%hand(1)%Suit) then
                temp = players(i)
                players(i) = players(j)
                players(j) = temp
            end if
        end do
    end do        

end subroutine SortBySuit
    

subroutine SortByPair(players)

    type(Player), dimension(:), intent(inout):: players
    integer :: i, j
    type(Player) :: temp

    do i = 1, size(players) - 1
        do j = i + 1, size(players)
            if (players(i)%hRank(1)%Face < players(j)%hRank(1)%Face) then
                temp = players(i)
                players(i) = players(j)
                players(j) = temp
            else if (players(i)%hRank(1)%Face == players(j)%hRank(1)%Face) then
                if(players(i)%hRank(2)%Suit > players(j)%hRank(2)%Suit) then
                    temp = players(i)
                    players(i) = players(j)
                    players(j) = temp  
                end if
            end if
        end do
    end do        

end subroutine SortByPair



subroutine SortByTwoPair(players)
    type(Player), dimension(:), intent(inout):: players
    integer :: i, j
    type(Player) :: temp

    do i = 1, size(players) - 1
        do j = i + 1, size(players)
            if (players(i)%hRank(2)%Face < players(j)%hRank(2)%Face) then
                temp = players(i)
                players(i) = players(j)
                players(j) = temp
            end if
            if (players(i)%hRank(2)%Face == players(j)%hRank(2)%Face) then
                if(players(i)%hRank(1)%Face < players(j)%hRank(1)%Face) then
                    temp = players(i)
                    players(i) = players(j)
                    players(j) = temp  
                end if
                if (players(i)%hRank(1)%Face == players(j)%hRank(1)%Face) then
                    if(players(i)%hRank(3)%Suit > players(j)%hRank(3)%Suit) then
                        temp = players(i)
                        players(i) = players(j)
                        players(j) = temp 
                    end if
                end if
            end if
        end do
    end do        

end subroutine SortByTwoPair


end module mainFunctions