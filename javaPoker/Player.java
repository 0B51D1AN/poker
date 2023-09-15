import java.util.*;

public class Player
{
    
    ArrayList<Card> hand;
    String handRank="";
    ArrayList<Card> hRank; // card representation of the rank of hand

    public Player()
    {
        hand= new ArrayList<Card>();
        hRank=new ArrayList<Card>();
        handRank="";
    }

    public Player(Card ... cards)
    {
        hand= new ArrayList<Card>();
        for(Card c : cards)
        {
            hand.add(c);
        }
        hRank=new ArrayList<Card>();
        handRank="";

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



    public void checkRank() // Update handRank and hRank to the correct values then sort array according to the rank order
    {
       
        checkRun();
        checkSet();
        



    }
   
    public void checkRun()
    {
        String s=hand.get(0).Suit;
        boolean flush=true;
        for(Card c : hand)
        {
            if(!c.Suit.equals(s))
                flush=false;
        }
        
        if(flush)
        {
            if(hand.get(0).Face==1 && hand.get(1).Face==10 && hand.get(2).Face==11 && hand.get(3).Face==12 && hand.get(4).Face==13)
            {
                handRank="ROYAL FLUSH";
                hRank.add(new Card(1,hand.get(0).Suit));
            }

            boolean straight=true;
            int run=hand.get(0).Face;
            for(Card c : hand)
            {
                if(c.Face==run)
                {
                    run++;
                }   
                else
                  straight=false;
                
            }
            if(straight)
            {
                handRank="STRAIGHT FLUSH";
                hRank.add(new Card(2, hand.get(0).Suit));
            }
            else
            {
                handRank="Flush";//can have pairs in a flush
                hRank.add(new Card(5,hand.get(0).Suit));
            }
        }
        if(hand.get(0).Face==1 && hand.get(1).Face==10 && hand.get(2).Face==11 && hand.get(3).Face==12 && hand.get(4).Face==13)
            {
                handRank="ROYAL FLUSH";
                hRank.add(new Card(1,hand.get(0).Suit));
            }

            boolean straight=true;
            int run=hand.get(0).Face;
            for(Card c : hand)
            {
                if(c.Face==run)
                {
                    run++;
                }   
                else
                  straight=false;
                
            }
    }

    public void checkSet()
    {
        Card set1=hand.get(0);
        Card set2;
        for(Card c : hand)
        {
           
        }

       //return new Card[]{}; 

    }

    

}
