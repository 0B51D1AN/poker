mod card; // Import the card module defined in card.rs
mod player;
mod deck;
use player::Player;
//use card::Card;
use crate::card::Card;
use deck::Deck;

use std::env;
//use std::fs::File;
use std::io::Read;
use std::error::Error;
use std::fs::File;
use std::io;
use std::io::prelude::*;
use std::path::Path;
use csv::Reader;



fn main() -> Result<(), Box<dyn std::error::Error>> {
    let args: Vec<String> = env::args().collect();

    if args.len()>1
    {
        println!("*** File: {}", args[1]);
        let file = File::open(&args[1])?;
        let mut reader = Reader::from_reader(file);

        let mut players = Vec::new();
        let mut input_cards = Vec::new();
        let mut duplicate_cards = Vec::new();

        for record in reader.records() {
            let record = record?;
            let mut cards = Vec::new();

            for field in record.iter() {
                let mut card = field.trim().to_string();
                card.retain(|c| !c.is_whitespace());
                if input_cards.iter().any(|s| &card == s) {
                    duplicate_cards.push(card.clone());
                }
                input_cards.push(card.clone());
                // Implement Card::from_string based on your Card struct
                cards.push(Card::from_string(&card));
            }

            if cards.len() != 5 {
                return Err("Each player must have exactly 5 cards".into());
            }

            // Implement Player::new based on your Player struct
            let player = Player::with_cards(cards.try_into());
            players.push(player);
        }

        println!("*** Using Test Deck ***");
        println!("*** File:  {}", args[1]);

        for player in &players {
            player.show_hand();
            player.rank_hand();
        }

        if !duplicate_cards.is_empty() {
            println!("*** ERROR - DUPLICATE CARD(s) DETECTED");
            println!("{:?}", duplicate_cards);
        }

        println!("---Winning Hand Order---");
        show_winners(&mut players.into()); // Implement show_winners based on your ShowWinners function
    }
    else
    {
        let mut deck = Deck::new();
        //deck.show_deck();
        println!("\n\n*** USING RANDOMIZED DECK OF CARDS ***\n\n");
        
        println!("*** Shuffled 52 card deck:");
        deck.shuffle();
        deck.show_deck();
        
        
        let mut player_array: [Player; 6] = [Player::new(),Player::new(),Player::new(),Player::new(),Player::new(),Player::new()];


        for _ in 0..=4
        {

                for player in &mut player_array
                {
                    if let Some(card1) = deck.pop_card() 
                    {
                        player.push_card(card1);
                    }

                }

        }

        println!("\n*** Here are the six hands...");
        for mut player in &mut player_array
        {
                //player.rank_hand();
                player.show_hand();

        }


        for mut player in &mut player_array
        {
                player.rank_hand();
        }

        println!("*** Here is what remains in the deck...");
        deck.show_deck();


        println!("\n---WINNING HAND ORDER---\n");
        show_winners(&mut player_array)
    }
    Ok(())
    
    
}


fn show_winners(players: &mut [Player; 6]) {
    let mut rank_tiers: Vec<Vec<Player>> = vec![Vec::new(); 10];

    for player in players.iter() {
        rank_tiers[player.num_rank as usize].push(player.clone());
    }

    for v in &mut rank_tiers {
        if v.len() > 1 {
            // Assuming tie_break is a function that handles tie-breaking
            //tie_break(v.to_vec());
        }
    }

    for v in &rank_tiers {
        if !v.is_empty() {
            for player in v {
                player.show_hand();
            }
        }
    }


}


fn tie_break(mut players: Vec<Player>) -> Vec<Player> {
    match players[0].num_rank {
        0 => {
            players.sort_by(|a, b| b.h_rank[0].suit.cmp(&a.h_rank[0].suit));
        }
        1 => {
            players.sort_by(|a, b| b.hand.iter().max().cmp(&a.hand.iter().max()));
        }
        2 | 3 | 6 => {
            players.iter_mut().for_each(|p| {
                if p.h_rank[0].face == 1 {
                    p.h_rank[0].face = 14;
                }
            });
            players.sort_by(|a, b| b.h_rank[0].face.cmp(&a.h_rank[0].face));
        }
        4 => {
            players.sort_by(|a, b| b.h_rank[0].suit.cmp(&a.h_rank[0].suit));
        }
        5 => {
            players.sort_by(|a, b| b.hand.iter().max().cmp(&a.hand.iter().max()));
        }
        7 => {
            // Implement your specific tie-breaking logic for two pair
            // Implement compareTwoPair function or logic here
        }
        8 => {
            players.iter_mut().for_each(|p| {
                if p.h_rank[0].face == 1 {
                    p.h_rank[0].face = 14;
                }
            });
            players.sort_by(|a, b| b.h_rank[0].face.cmp(&a.h_rank[0].face));
        }
        9 => {
            players.iter_mut().for_each(|p| {
                if p.hand[0].face == 1 {
                    p.hand[0].face = 14;
                }
            });
            players.sort_by(|a, b| b.hand.iter().max().cmp(&a.hand.iter().max()));
        }
        _ => {}
    }
    players
}