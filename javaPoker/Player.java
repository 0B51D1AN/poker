import java.util.*;

public class Player extends Card
{
    
    ArrayList<Card> hand;

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

    //Sort hand into 4 suit arrays highest to lowest (Hash of 13????).
    //begin with weakest 
    public int rankHand()
    {
        int [] Spades= new int[13]; 
        int [] Hearts= new int [13];
        int [] Clubs= new int [13];
        int [] Diamonds= new int [13];

        for (Card c : hand)
        {
            switch(c.getSuit())
            {
                case "S": Spades[c.getFace()]=1;
                            break;
                case "H": Hearts[c.getFace()]=1;
                            break;
                case "C": Clubs[c.getFace()]=1;
                            break;
                case "D": Diamonds[c.getFace()]=1;
                            break;

            }
        }

        //Cards should now be represented in unique hash

        //Now begin analyzing different ranks      

        



        return 0;
    }


}