program main
    use class_Card
    use class_Deck
    use class_Player
    use mainFunctions
    implicit none
    character(100) :: filename
    character(3) :: card_str
    character(80) :: line
    type(Deck) :: deck1
    type(Player), dimension(6) :: table

    
    integer :: index
    integer :: i, a, ios, unit
    type(Card) :: tempCard


    do index=1, size(table)
        call table(index)%CreatePlayer()
    end do

     ! Check for the command line argument
    if (command_argument_count() == 1) then
        call get_command_argument(1, filename)
        unit =1
        open(unit, file=filename, status="old")

        ! Loop through the lines in the CSV file
        do i = 1, 6
            ! Read a line containing the player's hand
            read(unit, '(A)', iostat=ios) line
           ! print*, line
            if (ios /= 0) then
                print *, "Error reading line ", i
                exit
            end if

            ! Split the line into individual cards
            do a = 1, 5
                read(line, '(A2)', iostat=ios) card_str
                if (ios /= 0) then
                    print *, "Error reading card ", a, " in line ", i
                    exit
                else 
                    call tempCard%makeCardfromString(card_str)
                    table(i)%hand(a)=tempCard
                end if
                
                
            end do
        end do

        do index=1, size(table)
            call table(index)%ShowHand()
        end do

    ! Close the CSV file
    close(unit)
    else

        print *, "*** USING RANDOMIZED DECK OF CARDS ***"
        print *
        print *, "Shuffled 52 card deck:"
        call deck1%InitializeDeck()
        call deck1%ShuffleDeck()
        call deck1%ShowDeck()

       
        print *, "*** Here are the six hands..."

        do index=1,5
            do a=1,size(table)
                call deck1%PopCard(tempCard)
                table(a)%hand(index)=tempCard   
            end do
        end do

        do index=1, size(table)
            call table(index)%ShowHand()
            call table(index)%RankHand()
        end do

        print*
        print *, "*** Here is what remains in the deck..."

        call deck1%ShowDeck()

        print*
        print*
        print*, "--- WINNING HAND ORDER ---"
        
        call ShowWinners(table)


    end if

    

end program main

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
        nPlayers = 0  ! Initialize the number of players in this tier
        do tier = 1, size(players)
            if (players(tier)%numRank == i) then
                nPlayers = nPlayers + 1
                rankTiers(i, nPlayers) = players(tier)
            end if
        end do
        numPlayers(i) = nPlayers
    end do

    ! Display the winners
    do i = 1, size(rankTiers, 1)
        do tier = 1, numPlayers(i)
            call rankTiers(i, tier)%ShowHand()
        end do
    end do

   

    do i=1, size(rankTiers)
        if(numPlayers(i)>1) then
            call TieBreak(rankTiers(i,:))
        end if
    end do

    
   
end subroutine ShowWinners



subroutine TieBreak(players)
    use class_Player
    type(Player), dimension(:), intent(inout) :: players
    integer :: i

    ! Perform tie-breaking based on numRank
    select case (players(1)%numRank)
    case (1) ! Royal Flush
        !call SortBySuit(players)
    case (2) ! Straight Flush
        !call SortByHighCard(players)
    case (3, 4) ! Four of a Kind or Full House
        !call ConvertAceToHighCard(players)
        !call SortByCard(players)
    case (5) ! Flush
        !call SortBySuit(players)
    case (6) ! Straight
        !call SortByHighCard(players)
    case (7) ! Three of a Kind
        !call ConvertAceToHighCard(players)
        !call SortByCard(players)
    case (8) ! Two Pair
        !call SortByTwoPair(players)
    case (9) ! Pair
        !call ConvertAceToHighCard(players)
        !call SortByPair(players)
    case (10) ! High Card
        !call ConvertAceToHighCard(players)
        !call SortByHighCard(players)
    end select
end subroutine TieBreak


end module mainFunctions