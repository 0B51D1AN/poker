import java.util.*;

public class Player
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
    



   
   

}
