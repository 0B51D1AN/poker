#![allow(dead_code)]
#![allow(unused_imports)]
mod card; // Import the card module defined in card.rs
mod player;
mod deck;
use player::Player;
//use card::Card;
use crate::card::Card;
use deck::Deck;
use core::cmp::Ordering;
use std::env;
//use std::fs::File;
use std::io::Read;
use std::error::Error;
use std::fs::File;
use std::io;
use std::io::prelude::*;
use std::path::Path;
use csv::Reader;
use std::convert::TryInto;


fn main() -> Result<(), Box<dyn std::error::Error>> {
    let args: Vec<String> = env::args().collect();

    if args.len()>1
    {
        //println!("*** File: {}", args[1]);
        let file = File::open(&args[1])?;
        let mut reader = Reader::from_reader(file);

        let mut players = Vec::new();
        let mut input_cards = Vec::new();
        let mut duplicate_cards = Vec::new();

        for record in reader.records() {
            let record = record?;
            //println!("{}",record);
            let mut cards = Vec::new();

            for field in record.iter() {
                let mut card = field.trim().to_string();
                //println!("{}", card);
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
            //let mut temp_card: [<Card>; 5]= cards.try_into();
            
            if let Ok(temp_card) = cards.try_into()
            {
                // Implement Player::new based on your Player struct
                let player = Player::with_cards(temp_card);
                players.push(player);
                //println!("{}",players.len());
            }   
            else{
                println!("Error");
            }
            
        }

        println!("*** Using Test Deck ***");
        println!("*** File:  {}", args[1]);

        for player in &mut players {
           
            player.show_hand(); 
            player.rank_hand();           
        }

        if !duplicate_cards.is_empty() {
            println!("*** ERROR - DUPLICATE CARD(s) DETECTED");
            println!("{:?}", duplicate_cards);
        }

        println!("---Winning Hand Order---");
       
        if players.len() != 6 {
            println!("Error: Expected 6 players");
            // Handle the case where there aren't exactly 6 players
        } else {
            let mut temp_players = [Player::new(),Player::new(),Player::new(),Player::new(),Player::new(),Player::new()];

    
            // Assuming the 'players' vector contains exactly 6 players
            for (i, player) in players.iter().enumerate() {
                temp_players[i] = player.clone(); // Assuming Player is Copy or has a clone method
            }
    
            println!("Array: {:?}", temp_players);
        }
        
        
       
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
        for player in &mut player_array
        {
                //player.rank_hand();
                player.show_hand();

        }


        for player in &mut player_array
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
            tie_break(v);
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


fn tie_break(players: &mut Vec<Player>) -> &mut Vec<Player> {
    match players[0].num_rank {
        0=>{players.sort_by(|a,b| b.hand[4].suit.cmp(&a.hand[4].suit));}// Royal Flush

        1=>{players.sort_by(|a,b| b.hand[4].suit.cmp(&a.hand[4].suit));} // Straight Flush

        2=>{players.sort_by(|a,b| b.hand[2].face.cmp(&a.hand[2].face));} // Four of a Kind

        3=>{players.sort_by(|a,b| b.hand[2].face.cmp(&a.hand[2].face));} // Full House

        4=>{players.sort_by(|a,b| b.hand[4].suit.cmp(&a.hand[4].suit));} // Flush

        5=>{players.sort_by(compare_by_suit)} // Straight

        6=>{players.sort_by(|a,b| b.hand[2].face.cmp(&a.hand[2].face));} // Three of a Kind

        7=>{} // Two Pair

        8=>{


        } // Pair

        9=>{

            players.iter_mut().for_each(|p| {
                if p.hand[0].face == 1 {
                    p.hand[0].face = 14;
                    p.hand.sort_by(|a,b| a.face.cmp(&b.face));
                }
            });
            players.sort_by(compare_by_high_card);
            
        } // High Card


        _ => {}
    }
    players
}

// fn reverse(s: &mut [Player]) {
//     for i in 0..s.len() / 2 {
//         s.swap(i, s.len() - 1 - i);
//     }
// }

fn compare_two_pair(a: &Player, b: &Player) -> Ordering {
    if a.h_rank[1].face == b.h_rank[1].face {
        if a.h_rank[0].face == b.h_rank[0].face {
            return a.h_rank[2].suit.cmp(&b.h_rank[2].suit);
        }
        return a.h_rank[0].face.cmp(&b.hand[0].face);
    }
    a.h_rank[1].face.cmp(&b.h_rank[1].face)
}

fn compare_by_high_card(a: &Player, b: &Player)-> Ordering 
{
    if a.hand[4].face==b.hand[4].face
    {
        return a.hand[4].suit.cmp(&b.hand[4].suit);
    }
    b.hand[4].face.cmp(&a.hand[4].face)

}
fn compare_by_suit(a: &Player, b: &Player)-> Ordering 
{
    if a.hand[4].suit==b.hand[4].suit
    {
        return b.hand[4].face.cmp(&a.hand[4].face);
    }
    a.hand[4].suit.cmp(&b.hand[4].suit)

}