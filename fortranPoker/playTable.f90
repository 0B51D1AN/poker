program main
    use class_Card
    use class_Deck
    use class_Player
    use mainFunctions
    implicit none
    character(100) :: filename
    character(*) :: card_str
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
            print*, line
            if (ios /= 0) then
                print *, "Error reading line ", i
                exit
            end if

            ! Split the line into individual cards
            index=0
            do a = 1, len_trim(line)
                !read(line, '(A3)', iostat=ios) card_str
                if(line(a:a)/= ',' .or. line(a:a)/=' ' .or. line(a:a)/= NEW_LINE('A')) then
                    card_str=card_str//line(a:a)
                end if
                call tempCard%makeCardfromString(tempCard,card_str)
                table(i)%hand(index)=tempCard
                call table(i)%hand(index)%printCard()
                index=index+1
                
                
                
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