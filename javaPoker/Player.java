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
        hand= new ArrayList<Card>();
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
        Collections.sort(hand, new Comparator<Card>(){
            public int compare(Card c, Card c2)
            {
                return Integer.valueOf(c.getFace()).compareTo(c2.getFace());
            }
        });

    }



 //SEND TO THE JUDGE
   
   

}
