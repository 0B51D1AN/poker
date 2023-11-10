using Random

mutable struct Deck
    cards::Vector{Tuple{Int, Int}}
    
    function Deck()
        suits = 1:4
        faces = 1:13
        cards = [(suit, face) for suit in suits for face in faces]
        new(cards)
    end
    
end    
    
###############################################################################
### Deck Member Functions
function deal(deck::Deck)
    if length(deck.cards) > 0
        return pop!(deck.cards)
    else
        return nothing  # Return nothing if the deck is empty
    end
end

function showDeck(deck::Deck)
    index = 1
    for card in deck.cards
        print(card_to_string(card), " ")
        if index == 13
            println()
            index = 1
        else
            index += 1
        end
    end
end

function Shuffle(deck:: Deck)
    Random.shuffle!(deck.cards)
end

function card_to_string(card::Tuple{Int, Int})
    suits = ["S", "H", "C", "D"]
    faces = string.([2,3,4,5,6,7,8,9,10, "J", "Q", "K", "A", "A"]) #Extra A for when ace is calculated high
    suit_str = suits[card[1]]
    face_str = faces[card[2]]
    return "$face_str$suit_str"
end

############################################################################

mutable struct Player
    hand::Vector{Tuple{Int, Int}}
    handRank::String
    pair1::Int
    pair2::Int
    kicker::Int
    set::Int
    r::Int
    function Player()
        hand = Tuple{Int, Int}[]
        handRank = ""
        r=0
        pair1=0
        pair2=0
        kicker=0
        set=0
        new(hand, handRank)
    end
    
    
end

##############################################################################
##Player member functions

function collect_cards(player::Player, cards::Vector{Tuple{Int, Int}})
    append!(player.hand, cards)
end

function show_hand(player::Player)
    for card in player.hand
        print(card_to_string(card), " ")
    end
    if player.handRank != ""
        println(" - ", player.handRank)
    else
        println()
    end
end
    
function card_to_string(card::Tuple{Int, Int})
    suits = ["S", "H", "C", "D"]
    faces = string.([2,3,4,5,6,7,8,9,10, "J", "Q", "K", "A","A"])##Extra A for when ace is high
    suit_str = suits[card[1]]
    face_str = faces[card[2]]
    return "$face_str$suit_str"
end

function organize_hand_by_face(player::Player)
    sort!(player.hand, by = card -> card[2])
end

function determine_hand_rank(player::Player)
    organize_hand_by_face(player)
    if is_straight(player) && is_flush(player) && player.hand[1][2] == 1
        player.handRank = "Royal Flush"
        r=1
    elseif is_flush(player) && is_straight(player)
        player.handRank = "Straight Flush"
        r=2
    elseif is_four_of_a_kind(player)
        player.handRank = "Four of a Kind"
        r=3
    elseif is_full_house(player)
        player.handRank = "Full House"
        r=4
    elseif is_flush(player)
        player.handRank = "Flush"
        r=5
    elseif is_straight(player)
        player.handRank = "Straight"
        r=6
    elseif is_three_of_a_kind(player)
        player.handRank = "Three of a Kind"
        r=7
    elseif is_two_pair(player)
        player.handRank = "Two Pair"
        r=8
    elseif is_one_pair(player)
        player.handRank = "Pair"
        r=9
    else
        player.handRank = "High Card"
        r=10
    end
end

function tie_break(players, index::Int)
    if index == 0  # RoyalStraightFlush
        sort!(players, by = player -> player.hand[5][1])  # Sort by suit
    elseif index == 1  # StraightFlush
        flush(players)
    elseif index == 2  # FourofaKind
        for player in players
            if player.hand[1][2] == 1
                temp = player.hand[1][1]
                popfirst!(player.hand)
                push!(player.hand, (temp, 14))
            end
        end
        sort!(players, by = player -> player.hand[2][2], rev = true)
    elseif index == 3  # FullHouse
        sort!(players, by = player -> player.hand[3][2], rev = true)
    elseif index == 4  # Flush
        flush(players)
    elseif index == 5  # Straight
        straight(players)
    elseif index == 6  # ThreeofaKind
        sort!(players, by = player -> player.set, rev = true)
    elseif index == 7  # TwoPair
        two_pair(players)
    elseif index == 8  # Pair
        pair(players)
    elseif index == 9  # HighCard
        high_card(players)
    end
end
######################################################################
### Hand rank Methods

function is_straight(player::Player)
    if player.hand[1][2] == 1 && player.hand[2][2] == 10 && player.hand[3][2] == 11 && player.hand[4][2] == 12 && player.hand[5][2] == 13
        return true
    end
    for i in 2:5
        if player.hand[i][2] != player.hand[i - 1][2] + 1
            return false
        end
    end
    return true
end

function is_flush(player::Player)
    for i in 2:5
        if player.hand[i][1] != player.hand[i - 1][1]
            return false
        end
    end
    return true
end

function is_four_of_a_kind(player::Player)
    for i in 3:5
        if player.hand[i][2] == player.hand[i - 1][2] == player.hand[i - 2][2] == player.hand[i - 3][2]
            return true
        end
    end
    return false
end

function is_full_house(player::Player)
    if (player.hand[1][2] == player.hand[2][2] == player.hand[3][2] && player.hand[4][2] == player.hand[5][2]) ||
        (player.hand[1][2] == player.hand[2][2] && player.hand[3][2] == player.hand[4][2] == player.hand[5][2])
        return true
    end
    return false
end

function is_three_of_a_kind(player::Player)
    for i in 3:5
        if player.hand[i][2] == player.hand[i - 1][2] == player.hand[i - 2][2]
            if player.hand[i][2] == 1
                player.set = 14
            else
                player.set = player.hand[i][2]
            end
            return true
        end
    end
    return false
end

function is_two_pair(player::Player)
    pairs = 0
    for i in 2:5
        if player.hand[i][2] == player.hand[i - 1][2]
            if player.hand[i][2] == 1
                player.pair1 = 14
            else
                player.pair1 = player.hand[i][2]
            end
            pairs += 1
            if pairs == 2
                player.pair2 = player.hand[i][2]
                if player.pair1 == 14
                    temp = player.pair2
                    player.pair2 = player.pair1
                    player.pair1 = temp
                end
                for card in player.hand
                    if card[2] != player.pair1 && card[2] != player.pair2
                        player.kicker = card[1]
                    end
                end
                return true
            end
        end
    end
    return false
end

function is_one_pair(player::Player)
    for i in 2:5
        if player.hand[i][2] == player.hand[i - 1][2]
            if player.hand[i][2] == 1
                player.pair1 = 14
                player.kicker = player.hand[5][1]
            else
                player.pair1 = player.hand[i][2]
                if i == 5
                    player.kicker = player.hand[3][1]
                else
                    player.kicker = player.hand[5][1]
                end
            end
            return true
        end
    end
    return false
end

function flush(players)
    for player in players
        if player.hand[1][2] == 1
            temp = player.hand[1][1]
            popfirst!(player.hand)
            push!(player.hand, (temp, 14))
        end
    end
    sort!(players, by = player -> player.hand[5][1], rev = true)

    # Sorted in suit order, now check if there are flush of the same suit and break by the highest card

    n = length(players)
    swapped = false

    for i in 1:(n - 1)
        swapped = false

        for j in 1:(n - 1 - i)
            if players[j].hand[5][1] == players[j + 1].hand[5][1]
                if players[j].hand[5][2] < players[j + 1].hand[5][2]
                    players[j], players[j + 1] = players[j + 1], players[j]
                end
                swapped = true
            end
        end

        if !swapped
            break
        end
    end
end

function straight(players)
    for player in players
        if player.hand[1][2] == 1 && player.hand[2][2] == 10
            temp = player.hand[1][1]
            popfirst!(player.hand)
            push!(player.hand, (temp, 14))
        end
    end
    sort!(players, by = player -> player.hand[5][2], rev = true)
end

function two_pair(players)
    sort!(players, by = player -> player.pair2, rev = true)

    n = length(players)
    swapped = false

    for i in 1:(n - 1)
        swapped = false

        for j in 1:(n - 1 - i)
            if players[j].pair1 == players[j + 1].pair1 && players[j].pair2 == players[j + 1].pair2
                if players[j].kicker > players[j + 1].kicker
                    players[j], players[j + 1] = players[j + 1], players[j]
                end
                swapped = true
            end
        end

        if !swapped
            break
        end
    end
end

function pair(players)
    sort!(players, by = player -> player.pair1, rev = true)

    n = length(players)
    swapped = false

    for i in 1:(n - 1)
        swapped = false

        for j in 1:(n - 1 - i)
            if players[j].pair1 == players[j + 1].pair1
                if players[j].kicker > players[j + 1].kicker
                    players[j], players[j + 1] = players[j + 1], players[j]
                end
                swapped = true
            end
        end

        if !swapped
            break
        end
    end
end

function high_card(players)
    for player in players
        if player.hand[1][2] == 1
            temp = player.hand[1][1]
            popfirst!(player.hand)
            push!(player.hand, (temp, 14))
        end
    end
    sort!(players, by = player -> player.hand[5][2], rev = true)

    n = length(players)
    swapped = false

    for i in 1:(n - 1)
        swapped = false

        for j in 1:(n - 1 - i)
            if players[j].hand[5][2] == players[j + 1].hand[5][2]
                if players[j].hand[5][1] > players[j + 1].hand[5][1]
                    players[j], players[j + 1] = players[j + 1], players[j]
                end
                swapped = true
            end
        end

        if !swapped
            break
        end
    end
end

function rank_index(rank_name::String)
    for rank_tuple in hand_rank_values
        if rank_tuple[1] == rank_name
            return rank_tuple[2]
        end
    end
    return -1  # Default to 0 if the rank name is not found in the list
end

###################################################
#File read Methods


function read_hands_from_csv(file_path::String)
    hands = Tuple{String}[]
    duplicateCards = Tuple{String}[]
    
    open(file_path, "r") do file
        for line in eachline(file)
            hand = strip.(split(line, ','))
            
            if length(hand) != 5
                println("Each hand must have exactly 5 cards.")
                return
            end
            
            for card in hand
                if card in readCards
                    push!(duplicateCards, card)
                end
                push!(readCards, card)
            end
            
            push!(hands, hand)
        end
    end
    
    if length(duplicateCards) > 0
        println("Duplicate Cards detected:")
        for card in duplicateCards
            println(card)
        end
        return
    end
    
    return hands
end




#######################################################################################################

##MAIN

################################################
##File Input
if length(ARGS)==1
    input_file=ARGS[1]
    println(input_file)
else
################################################
##Random Deck


    deck=Deck()
    Shuffle(deck)
    showDeck(deck)

    players=[Player(), Player(), Player(), Player(), Player(), Player()]
    
    hands=[Vector{Tuple{Int, Int}}([]),Vector{Tuple{Int, Int}}([]),Vector{Tuple{Int, Int}}([]),Vector{Tuple{Int, Int}}([]),Vector{Tuple{Int, Int}}([]),Vector{Tuple{Int, Int}}([])]
    for i in 1:5
        for a in 1:6 
            push!(hands[a], deal(deck))
        end
    end 
    
    for player in players
        collect_cards(player,pop!(hands))
    end

    #for player in players
    #    show_hand(player)
    #end
    


   for player in players
        determine_hand_rank(player)
        #show_hand(player)
    end

    hand_rank_values = [
        ("Royal Flush", 0, []),
        ("Straight Flush", 1, []),
        ("Four of a Kind", 2, []),
        ("Full House", 3, []),
        ("Flush", 4, []),
        ("Straight", 5, []),
        ("Three of a Kind", 6, []),
        ("Two Pair", 7, []),
        ("Pair", 8, []),
        ("High Card", 9, [])
    ]
    

    players_by_rank = Dict(rank[1] => rank[3] for rank in hand_rank_values)

    # Add each player to the corresponding list based on their hand rank
    for player in players
        push!(players_by_rank[player.handRank], player)
    end

    

    for (rank, player_list) in players_by_rank
        if rank in ["Royal Flush", "Straight Flush", "Four of a Kind", "Full House", "Flush", "Straight", "Three of a Kind", "Two Pair", "Pair", "High Card"]
            tie_break(player_list, rank_index(rank))  # Run tie-breaker for all ranks
        end
    end

    for (rank, player_list) in players_by_rank
        # println("Players with $rank:")
        for player in player_list
            show_hand(player)
        end
    end


end
