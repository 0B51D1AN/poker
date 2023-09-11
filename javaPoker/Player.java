import java.util.*;

public class Player extends Card
{
    
    ArrayList<Card> hand;
    Card handRank=new Card();

    public Player()
    {
        hand= new ArrayList<Card>();
    }

    public Player(Card ... cards)
    {
        for(Card c : cards)
        {
            hand.add(c);
        }

    }

    //Methods
    //show hand
    public void showHand()
    {
        for(Card i : hand)
            i.printCard();
        
    }

    //read hand
    
    //addcard
    public void addCard(Card c)
    {
        hand.add(c);
    }

    //fold
    public void fold()
    {
        hand.removeAll(hand);
    }
    

    public void sortHand()
    {
        

    }


    public Card findHighest()
    {
        return new Card(); 

    }
    //Sort hand into 4 suit arrays highest to lowest (Hash of 13????).
    //begin with weakest 
    // Return card that represents the rank of the hand

    public Card[] rankHand()
    {
        
        
        int [] Spades= new int[13]; 
        int [] Hearts= new int [13];
        int [] Clubs= new int [13];
        int [] Diamonds= new int [13];

        int [][] theDeck={Spades, Hearts, Clubs, Diamonds};

        Arrays.fill(Spades, 0);
        Arrays.fill(Hearts, 0);
        Arrays.fill(Clubs, 0);
        Arrays.fill(Diamonds, 0);


            //Check for duplicates as well
        for (Card c : hand)
        {
            switch(c.getSuit())
            {
                case "S": Spades[c.getFace()-1]++;
                            break;
                case "H": Hearts[c.getFace()-1]++;
                            break;
                case "C": Clubs[c.getFace()-1]++;
                            break;
                case "D": Diamonds[c.getFace()-1]++;
                            break;
                //Scan theDeck to check if total >5 for duplicates
            }
        }

        // Cards should now be represented in unique hash

        // Now begin analyzing different ranks      

        // Begin by analyzing Flushes by adding each column and checking for 5 in a column
        int straight=0; //Track straight by checking initial row for items then checking adjacent rows
        int flush=0; //Track flush by adding items in the same column
        int indexS=0; //Index for straight tracks the beginning row of a straight to check for royal straight+flush
        int set=0; // Set tracks the pairs that are possible. If set reaches 4 = 4 of a kind. if set and set2 reach 2 and 2/3= full house/2pair
        int set2=0;
        int highCard=0; //Track high card for hand by checking index.
        int suit=0; //Tracks suit which earned the flush
        for(int s=0;  s<theDeck.length; s++)
        {
            
            for(int f : theDeck[s])
            {
                flush=flush+theDeck[s][f];
            }
                if(flush==5)
                {
                    //Hand must now be a flush, next check for straight within the flush
                    for(int a : theDeck[s])
                    {
                        if(theDeck[s][a]==1)
                        {
                            straight++;
                        }
                        else if(theDeck[s][a]==0)
                        {
                            straight=0;
                        }
                    

                        if(straight==5 || (straight==4 && theDeck[s][0]==1 && theDeck[s][9]==1))
                        {
                            for(int b : theDeck[s])
                            {
                                if (theDeck[s][b]==1)
                                {
                                    if(b==9)
                                    {
                                        System.out.println("Royal Flush");
                                        return new Card[]{new Card(1,s)}; //Royal Flush
                                    }
                                    else
                                    {
                                        System.out.println("Straight Flush");
                                        return new Card[]{new Card(2,s)}; //Straight Flush
                                    }
                                }
                            }                    
                        }
                    }
                    System.out.println("Flush");
                    return new Card[]{new Card(5,s),}; //Flush

                }

                



        }
        // Royal Straight Flush

        // Straight Flushes

        // Four of a Kind

        // Full House

        // Flush

        // Straights

        // Three of a Kind

        // Two Pair

        // Pair

        // High Card






        return new Card[]{new Card(0,"-")};
    }


}
