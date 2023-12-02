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

function shuffle(deck:: Deck)
    Random.shuffle!(deck.cards)
end

function card_to_string(card::Tuple{Int, Int})
    suits = ["S", "H", "C", "D"]
    faces = string.([2,3,4,5,6,7,8,9,10, "J", "Q", "K", "A"])
    suit_str = suits[card[1]]
    face_str = faces[card[2]]
    return "$face_str$suit_str"
end


#  players= [Player(), Player(), Player()]