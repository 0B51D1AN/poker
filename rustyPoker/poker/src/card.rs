#[derive(Clone)]
#[derive(Debug)]
#[derive(Ord)]
#[derive(Eq)]
#[derive(PartialOrd)]
#[derive(PartialEq)]
pub struct Card
{
    pub face: u8,
    pub suit: u8,
}

impl Card
{
    
    pub fn new(f: u8, s: u8) ->Self
    {
        Card {face:f, suit:s}
    }

    pub fn from_string(card: &str) -> Self
    {
        let mut face: u8 = 0;
        let mut suit: u8 = 0;

        match card.chars().next() 
        {
            Some('A') => face = 1,
            Some('K') => face = 13,
            Some('Q') => face = 12,
            Some('J') => face = 11,
            Some('1') => face = 10,
            Some(c) if c.is_digit(10) => face = c.to_digit(10).unwrap() as u8,
            _ => {}
        }

        match card.chars().last() 
        {
            Some('S') => suit = 1,
            Some('H') => suit = 2,
            Some('C') => suit = 3,
            Some('D') => suit = 4,
            _ => {}
        }

        Card { face, suit }
    }

    pub fn print_card(&self)
    {
        match self.face 
        {
            1 => print!("A"),
            13 => print!("K"),
            12 => print!("Q"),
            11 => print!("J"),
            10 => print!("10"),
            14=> print!("A"),
            _ => print!("{}", self.face),
        }

        match self.suit 
        {
            1 => print!("S"),
            2 => print!("H"),
            3 => print!("C"),
            4 => print!("D"),
            _ => {}
        }
    }
    

}

