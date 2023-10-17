module class_Player
  use class_Card
  
  implicit none

  type :: Player

    character(20) :: handRank
    integer :: numRank
    type(Card), dimension(5) :: hand
    type(Card), dimension(3) :: hRank
  contains
    procedure :: CreatePlayer
    procedure :: ShowHand
    procedure :: RankHand
    procedure :: isStraight
    procedure :: isFlush
    procedure :: isFourOfKind
    procedure :: isFullHouse
    procedure :: isPair
    procedure :: isThreeOfKind
    procedure :: isTwoPair
    

  end type Player

contains

  subroutine CreatePlayer(this)
    class(Player) :: this

    this%handRank=""
    this%numRank=-1
  end subroutine CreatePlayer

  subroutine ShowHand(this)
    class(Player) :: this
    integer :: i

    do i=1, size(this%hand)
      call this%hand(i)%printCard()
      if (i /= size(this%hand)) write(*, "(' ')", advance="no")
    end do
    if (this%handRank /= "") then
      write(*, "(' - ', A)") this%handRank
    else
      write(*, "('')")
    end if
  end subroutine ShowHand

  subroutine RankHand(this)
    class(Player) :: this
    integer :: i, j
    type(Card) :: temp

    ! Bubble sort algorithm to sort the hand based on rank values
    do i = 1, size(this%hand) - 1
      do j = 1, size(this%hand) - i
        if (this%hand(j)%Face > this%hand(j + 1)%Face) then
          ! Swap the cards
          temp = this%hand(j)
          this%hand(j) = this%hand(j + 1)
          this%hand(j + 1) = temp
        end if
      end do
    end do


    ! Check for Royal Flush
    if (this%isFlush() .and. &
        (this%hand(1)%Face == 1) .and. &
        (this%hand(2)%Face == 10) .and. &
        (this%hand(3)%Face == 11) .and. &
        (this%hand(4)%Face == 12) .and. &
        (this%hand(5)%Face == 13)) then
        this%handRank = "Royal Flush"
        this%numRank = 1
        return
    end if

    ! Check for Straight Flush
    if (this%isStraight() .and. this%isFlush()) then
        this%handRank = "Straight Flush"
        this%numRank = 2
        !if (this%hand(1)%Face == 1) then
        !   this%hRank(1) = this%hand(1)
        !else
        !    this%hRank(1) = this%hand(5)
        !end if
        return
    end if

    ! Check for Four of a Kind
    if (this%isFourOfKind()) then
        this%handRank = "Four of a Kind"
        this%numRank = 3
        !this%hRank(1) = this%hand(2) ! Must be one of the four
        return
    end if

    ! Check for Full House
    if (this%isFullHouse()) then
        this%handRank = "Full House"
        this%numRank = 4
        !this%hRank(1) = this%hand(3) ! Must be the 3-pair
        return
    end if

    ! Check for Flush
    if (this%isFlush()) then
        this%handRank = "Flush"
        this%numRank = 5
        return
    end if

    ! Check for Straight
    if (this%isStraight()) then
        this%handRank = "Straight"
        this%numRank = 6
        !this%hRank(1) = this%hand(5)
        return
    end if

    ! Check for Three of a Kind
    if (this%isThreeOfKind()) then
        this%handRank = "Three of a Kind"
        this%numRank = 7
        !this%hRank(1) = this%hand(3)
        return
    end if

    ! Check for Two Pair
    if (this%isTwoPair()) then
        this%handRank = "Two Pair"
        this%numRank = 8
        return
    end if

    ! Check for Pair
    if (this%isPair()) then
        this%handRank = "Pair"
        this%numRank = 9
        return
    end if

    ! High Card
    this%handRank = "High Card"
    this%numRank = 10
end subroutine RankHand
    

function isStraight(this) result(result)
  class(Player) :: this
  logical :: result
  integer :: i
  
  result = .false.

  ! Check for Royal Flush
  if (this%hand(1)%Face == 1 .and. this%hand(2)%Face == 10 .and. &
      this%hand(3)%Face == 11 .and. this%hand(4)%Face == 12 .and. &
      this%hand(5)%Face == 13) then
      this%hand(1)%Face=14
      result = .true.
      call this%RankHand()
      return
  end if

  ! Check for regular Straight
  do i = 2, 5
      if (this%hand(i)%Face /= this%hand(i-1)%Face + 1) then
          result = .false.
          return
      end if
  end do
  result = .true.
end function isStraight

function isFlush(this) result(result)
  class(Player) :: this
  logical :: result
  integer :: i
  
  result = .true.

  ! Check if all cards have the same suit
  do i = 2, 5
      if (this%hand(i)%Suit /= this%hand(1)%Suit) then
          result = .false.
          return
      end if
  end do
end function isFlush

function isFourOfKind(this) result(result)
  class(Player) :: this
  logical :: result
  integer :: i
  integer, dimension(14) :: faceCounts
  
  result = .false.

  ! Initialize faceCounts
  faceCounts = 0
  
  ! Count the number of cards with each face value
  do i = 1, 5
      faceCounts(this%hand(i)%Face) = faceCounts(this%hand(i)%Face) + 1
  end do

  ! Check for four cards of the same face value
  do i = 1, 13
      if (faceCounts(i) == 4) then
        if(i==1) then
          this%hRank(1)=Card(14,1)
          result = .true.
          return
        else
          this%hRank(1)=Card(i,1)
          result = .true.
          return
        end if
      end if
  end do
end function isFourOfKind

function isFullHouse(this) result(result)
  class(Player) :: this
  logical :: result
  integer :: i
  integer, dimension(14) :: faceCounts
  logical :: hasThree, hasTwo
  
  result = .false.

  ! Initialize faceCounts
  faceCounts = 0
  
  ! Count the number of cards with each face value
  do i = 1, 5
      faceCounts(this%hand(i)%Face) = faceCounts(this%hand(i)%Face) + 1
  end do
  
  hasThree = .false.
  hasTwo = .false.

  ! Check for three cards of one face value and two cards of another face value
  do i = 1, 13
      if (faceCounts(i) == 3) then
          hasThree = .true.
          if(i==1) then
            this%hRank(1)=Card(14,1)
          else
            this%hRank(1)=Card(i,1)
          end if
      else if (faceCounts(i) == 2) then
          hasTwo = .true.
      end if
  end do
  
  result = hasThree .and. hasTwo
end function isFullHouse

function isThreeOfKind(this) result(result)
  class(Player) :: this
  logical :: result
  integer :: i
  integer, dimension(14) :: faceCounts
  
  result = .false.

  ! Initialize faceCounts
  faceCounts = 0
  
  ! Count the number of cards with each face value
  do i = 1, 5
      faceCounts(this%hand(i)%Face) = faceCounts(this%hand(i)%Face) + 1
  end do

  ! Check for three cards of the same face value
  do i = 1, 13
      if (faceCounts(i) == 3) then
          if(i==1) then
            this%hRank(1)=Card(14,1)
            result = .true.
            return
          else
            this%hRank(1)=Card(i,1)
            result = .true.
            return
          end if
      end if
  end do
end function isThreeOfKind

function isTwoPair(this) result(result)
  class(Player) :: this
  logical :: result
  integer :: i, pairCount
  integer, dimension(14) :: faceCounts
  
  result = .false.

  ! Initialize faceCounts
  faceCounts = 0
  
  ! Count the number of cards with each face value
  do i = 1, 5
      faceCounts(this%hand(i)%Face) = faceCounts(this%hand(i)%Face) + 1
  end do
  
  pairCount = 0

  ! Check for two sets of two cards with the same face value
  do i = 1, 13
      if (faceCounts(i) == 2) then
        if(paircount==1) then
          this%hRank(2)=Card(i,1)
          pairCount= pairCount+1
        end if
        if(i==1) then
          this%hRank(1)=Card(14, 1)
        else
          this%hRank(1) = Card(i, 1)
          pairCount = pairCount + 1
        end if
      end if
  end do
  
  do i=1, size(this%hand)
    if(this%hand(i)%Face/=this%hRank(1)%Face .and. this%hand(i)%Face/=this%hRank(2)%Face) then
      this%hRank(3)=this%hand(i)
    end if
  end do
  result = (pairCount == 2)
  
end function isTwoPair

function isPair(this) result(result)
  class(Player) :: this
  logical :: result
  integer :: i
  integer, dimension(14) :: faceCounts
  type(Card), dimension(:), allocatable :: tempHand
  result = .false.

  ! Initialize faceCounts
  faceCounts = 0
  
  ! Count the number of cards with each face value
  do i = 1, 5
      faceCounts(this%hand(i)%Face) = faceCounts(this%hand(i)%Face) + 1
  end do

  ! Check for two cards with the same face value
  do i = 1, 13
      if (faceCounts(i) == 2) then
        if(i==1) then
          this%hRank(1) = Card(14, 1)
          result = .true.
          return
        else
          this%hRank(1) = Card(i, 1)
          result = .true.
          return
        end if
      end if
  end do
  if(this%hand(5)%Face== this%hRank(1)%Face) then
    this%hRank(2)=this%hand(3)
  else
    this%hRank(2)= this%hand(5)
  end if

end function isPair


end module class_Player