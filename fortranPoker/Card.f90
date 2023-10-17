module class_Card
    implicit none
    private
    
    public :: Card

    type Card
        integer :: Face
        integer :: Suit

    contains 
        procedure :: printCard
        procedure :: makeCard    
        procedure :: makeCardfromString
    end type Card

contains

    subroutine printCard(this)
        Class(Card) :: this
        select case (this%Face)
        case (1)
            write(*, '(A)', advance="no") 'A'
        case (13)
            write(*, '(A)', advance="no") 'K'
        case (12)
            write(*, '(A)', advance="no") 'Q'
        case (11)
            write(*, '(A)', advance="no") 'J'
        case (14)
            write(*, '(A)', advance="no") 'A'
        case default
            if (this%Face == 10) then
                write(*, '(I2)', advance="no") this%Face
            else
                write(*, '(I1)', advance="no") this%Face
            end if
        end select

        select case (this%Suit)
        case (1)
            write(*, '(A)', advance="no") 'S'
        case (2)
            write(*, '(A)', advance="no") 'H'
        case (3)
            write(*, '(A)', advance="no") 'C'
        case (4)
            write(*, '(A)', advance="no") 'D'
        end select


    end subroutine printCard


    subroutine makeCard(this, f, s)
        
        class(Card) :: this
        integer , intent(in) :: f
        integer , intent(in) :: S
        this%Face = f
        this%Suit = s

    end subroutine makeCard

    subroutine makeCardfromString(outCard, card_str)
        
        class(Card), intent(out) :: outCard
        character(*), intent(in) :: card_str
        integer :: face_int, suit_int

        ! Map card face characters to integers
        select case (card_str(1:1))
        case ('2':'9')
            face_int = ichar(card_str(1:1)) - ichar('0')
        case ('1')
            face_int = 10
        case ('J')
            face_int = 11
        case ('Q')
            face_int = 12
        case ('K')
            face_int = 13
        case ('A')
            face_int = 1
        case default
            error stop "Invalid card face character: " // card_str(1:1)
        end select

                ! Map card suit characters to integers
        select case (card_str(2:2))
        case ('S')
            suit_int = 1
        case ('H')
            suit_int = 2
        case ('C')
            suit_int = 3
        case ('D')
            suit_int = 4
        case default
            print*, card_str
            error stop "Invalid card suit character: " // card_str(2:2)
        end select

        outCard%Face = face_int
        outCard%Suit = suit_int

        
    end subroutine makeCardfromString


end module class_Card
