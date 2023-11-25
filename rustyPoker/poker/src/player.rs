
use crate::card::Card;
#[derive(Debug)]
#[derive(Clone)]
pub struct Player {
    pub hand_rank: String,
    pub num_rank: i32,
    pub hand: Vec<Card>,
    pub h_rank: Vec<Card>,
    //h: Vec<String>, // Assuming this was intended to store strings (not used in the provided code)
}


impl Player 
{
    // Constructor methods
    pub fn new() -> Self {
        Player {
            hand_rank: String::new(),
            num_rank: -1,
            hand: Vec::new(),
            h_rank: Vec::new(),
            //h: Vec::new(),
        }
    }

    pub fn push_card(&mut self, c: Card) {
        self.hand.push(c);
    }


    pub fn show_hand(&self) {
        for c in &self.hand {
            
            c.print_card();
            print!(" ")
            // Implement the Card print method here
            //println!("{:?}", c);
        }
        if self.hand_rank.is_empty() {
            println!();
        } else {
            println!(" - {}", self.hand_rank);
        }
    }

    pub fn with_cards(cards: [Card; 5]) -> Self {
        Player {
            hand_rank: String::new(),
            num_rank: -1,
            hand: cards.to_vec(),
            h_rank: Vec::new(),
           // h: Vec::new(),
        }
    }




    // Implement other methods like rank_hand, compare functions, and helpers...

    pub fn rank_hand(&mut self) {
        self.hand.sort_by_key(|card| card.face);

        if self.is_flush() && self.is_straight() {
            if self.hand[0].face == 1 && self.hand[4].face == 13 {
                self.hand_rank = String::from("Royal Flush");
                self.num_rank = 0;
                return;
            }
            self.hand_rank = String::from("Straight Flush");
            self.num_rank = 1;
            self.h_rank.push(if self.hand[0].face == 1 { self.hand[0].clone() } else { self.hand[4].clone() });
            return;
        }

        if self.is_four_of_kind() {
            self.hand_rank = String::from("Four of a Kind");
            self.num_rank = 2;
            self.h_rank.push(self.hand[1].clone()); // Must be one of the four
            return;
        }

        if self.is_full_house() {
            self.hand_rank = String::from("Full House");
            self.num_rank = 3;
            self.h_rank.push(self.hand[2].clone()); // Must be 3pair
            return;
        }

        if self.is_flush() {
            self.hand_rank = String::from("Flush");
            self.num_rank = 4;
            return;
        }

        if self.is_straight() {
            self.hand_rank = String::from("Straight");
            self.num_rank = 5;
            self.h_rank.push(self.hand[4].clone());
            return;
        }

        if self.is_three_of_kind() {
            self.hand_rank = String::from("Three of a Kind");
            self.num_rank = 6;
            self.h_rank.push(self.hand[2].clone());
            return;
        }

        if self.is_two_pair() {
            self.hand_rank = String::from("Two Pair");
            self.num_rank = 7;
            // No specific card to add to h_rank
            return;
        }

        if self.is_pair() {
            self.hand_rank = String::from("Pair");
            self.num_rank = 8;
            //self.h_rank.push(if self.hand[4].face == self.h_rank[0].face { self.hand[4].clone() } else { self.hand[2].clone() });
            return;
        }

        self.hand_rank = String::from("High Card");
        self.num_rank = 9;
    }


    fn is_straight(&self) -> bool {
        if self.hand[0].face == 1 && self.hand[1].face == 10 && self.hand[2].face == 11 && self.hand[3].face == 12 && self.hand[4].face == 13 {
            return true;
        }

        self.hand.windows(2).all(|pair| pair[1].face == pair[0].face + 1)
    }

    fn is_flush(&self) -> bool {
        let first_suit = self.hand[0].suit;
        self.hand.iter().all(|card| card.suit == first_suit)
    }


    fn is_four_of_kind(&self) -> bool {
        let mut face_counts = vec![0; 14]; // Index 0 represents Face 1 (Ace), and index 13 represents Face 13 (King)
        for card in &self.hand {
            face_counts[card.face as usize] += 1;
        }

        face_counts.iter().any(|&count| count == 4)
    }

    fn is_full_house(&self) -> bool {
        let mut face_counts = vec![0; 14];
        for card in &self.hand {
            face_counts[card.face as usize] += 1;
        }

        face_counts.iter().any(|&count| count == 3) && face_counts.iter().any(|&count| count == 2)
    }

    fn is_three_of_kind(&self) -> bool {
        let mut face_counts = vec![0; 14];
        for card in &self.hand {
            face_counts[card.face as usize] += 1;
        }

        face_counts.iter().any(|&count| count == 3)
    }

    fn is_two_pair(&self) -> bool {
        let mut face_counts = vec![0; 14];
        for card in &self.hand {
            face_counts[card.face as usize] += 1;
        }

        face_counts.iter().filter(|&&count| count == 2).count() == 2
    }

    fn is_pair(&self) -> bool {
        let mut face_counts = vec![0; 14];
        for card in &self.hand {
            face_counts[card.face as usize] += 1;
        }

        face_counts.iter().any(|&count| count == 2)
    }

}

