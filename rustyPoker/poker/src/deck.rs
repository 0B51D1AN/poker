
use crate::card::Card;
use rand::seq::SliceRandom;
use rand::prelude::*;

#[derive(Debug)]
pub struct Deck {
    deck: Vec<Card>,
}

impl Deck {
    pub fn new() -> Self {
        let mut deck = Vec::new();
        for suit in 1..=4 {
            for face in 1..=13 {
                let card = Card::new(face, suit);
                deck.push(card);
            }
        }
        Deck { deck }
    }

    pub fn shuffle(&mut self) {
        let mut rng = thread_rng();
        self.deck.shuffle(&mut rng);
    }

    pub fn pop_card(&mut self) -> Option<Card> {
        self.deck.pop()
    }

    pub fn show_deck(&self) {
        for (i, c) in self.deck.iter().enumerate() {
            c.print_card();
            print!(" ");
            if (i + 1) % 13 == 0 {
                println!();
            }
        }
        println!();
    }
}