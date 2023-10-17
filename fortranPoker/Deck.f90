module class_Deck
    use class_Card
    
    implicit none

    type :: Deck
        type(Card), dimension(:), allocatable :: cards
    contains
        procedure :: InitializeDeck
        procedure :: ShowDeck
        procedure :: ShuffleDeck
        procedure :: PopCard        
    end type Deck

contains 


    subroutine InitializeDeck(this)
        class(Deck) :: this
        integer :: i, j, n_cards
        if (allocated(this%cards)) deallocate(this%cards)
        allocate(this%cards(52))
        n_cards = 0
        do i = 1, 13
        do j = 1, 4
            n_cards = n_cards + 1
            this%cards(n_cards)%Face = i
            this%cards(n_cards)%Suit = j
        end do
        end do
    end subroutine InitializeDeck

    subroutine ShuffleDeck(this)
        Class(Deck) :: this
        integer :: i, j
        type(Card) :: temp

        do i = size(this%cards), 2, -1
        call Randomize(i, j)
        temp = this%cards(i)
        this%cards(i) = this%cards(j)
        this%cards(j) = temp
        end do

    end subroutine ShuffleDeck


    subroutine Randomize(upper_bound, result)
        integer, intent(in) :: upper_bound
        integer, intent(out) :: result
        real(8) :: random_value
        call RANDOM_NUMBER(random_value)
        result = 1 + floor(random_value * upper_bound)
      end subroutine Randomize


    subroutine PopCard(this, c)
    type(Card):: c
    class(Deck) :: this
    integer :: i
    
    if (size(this%cards) > 0) then
        c = this%cards(1)   ! Get the top card
        do i = 1, size(this%cards) - 1
            this%cards(i) = this%cards(i + 1)  ! Shift remaining cards
        end do
        if (size(this%cards) > 0) then
            this%cards = this%cards(1:size(this%cards)-1)  ! Deallocate the last card
        else
            deallocate(this%cards)
        end if
        else
        print *, "The deck is empty."
        end if
    end subroutine PopCard

    subroutine ShowDeck(this)
        class(Deck) :: this
        integer :: i
        
        !print *, "Remaining cards in the deck:"
        do i = 1, size(this%cards)            
            call this%cards(i)%PrintCard()
            write(*, "(' ')", advance="no")
            if (mod(i,13)==0) then
                write(*, *)
            end if
        end do
        
    end subroutine ShowDeck


    



end module class_Deck