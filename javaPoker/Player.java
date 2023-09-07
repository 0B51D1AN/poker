import java.util.*;

public class Player extends Card
{
    
    ArrayList<Card> hand;

    public Player()
    {
        hand= new ArrayList<Card>();
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
    


}