program main
    use class_Card
    use class_Deck
    use class_Player
    use mainFunctions
    implicit none
    character(100) :: filename
    character(88) :: card_str
    character(80) :: txtline
    type(Deck) :: deck1
    type(Player), dimension(6) :: table
    character(:), allocatable :: line, outline, word, duplicates, usedCards, temporaryArray
    character(30) :: temp
    
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
        print*, "*** USING TEST DECK ***"

        print*

        print*,"*** File: ", filename
        print *
        print *,"*** Here are the six hands..."

        ! Loop through the lines in the CSV file
        do i = 1, 6
            ! Read a line containing the player's hand
            read(unit, '(A)', iostat=ios) txtline
            !print *, txtline
            if (ios /= 0) then
                print *, "Error reading line ", i
                exit
            end if
        
        ! Initialize outline to be same string as line, it will get overwritten in 
        ! the subroutine, but we need it for loop control
        outline = txtline
            index=1
            do while (len(outline) .ne. 0)
                call get_next_token( txtline, outline, word)
                !write(*,'(A)') trim(adjustl(word))
                temp=trim(word)
                temp=sweep_blanks(temp)
                !print*, temp
                txtline = outline
               

                call tempCard%makeCardfromString(trim(temp))
                table(i)%hand(index)=tempCard
                index=index+1
            end do
        end do
        do index=1, size(table)
            call table(index)%ShowHand()
            call table(index)%RankHand()
        end do

        print *, "---WINNING HAND ORDER---"
        call ShowWinners(table)

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

    contains
    character(30) function sweep_blanks(in_str)
        character(*), intent(in) :: in_str
        character(30) :: out_str
        character :: ch
        integer :: j

        out_str = " "
        do j=1, len_trim(in_str)
        ! get j-th char
        ch = in_str(j:j)
        if (ch .ne. " ") then
            out_str = trim(out_str) // ch
        endif
        sweep_blanks = out_str 
        end do
    end function sweep_blanks

end program main
