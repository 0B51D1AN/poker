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
        
        //System.out.println();
        
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
        if(handRank.equals(""))
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
                return;
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
                return;
            }
            else
            {
                handRank="Flush";//can have pairs in a flush
                hRank.add(new Card(5,hand.get(0).Suit));
                return;
            }
        }
        if(hand.get(0).Face==1 && hand.get(1).Face==10 && hand.get(2).Face==11 && hand.get(3).Face==12 && hand.get(4).Face==13)
            {
                handRank="Straight";
                hRank.add(new Card(6,"-"));
                hRank.add(hand.get(0));
                return;
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
                handRank="Straight";
                hRank.add(new Card(6,"-"));
                hRank.add(hand.get(4));
                return;
            }
    }

    public void checkSet()
    {
        int [] faces= new int [14];
        
        for(Card c : hand)
        {
            faces[c.Face]++;
        }
        //mini hash of all possible faces
          
        int set1=0; // P = pair  T= trio
        int set2=0;
        //boolean swap=true;
        // for(int i : faces)
        // {
        //     System.out.print(i);
        // }

        for(int i=0; i<faces.length; i++)
        {
            if((faces[i]>=2) && (set1==0))
            {
                set1=i; //index of possible pair
                //System.out.println(set1);
            }
            if((faces[i]>=2) && (set1>0) && (set1!= i))
            {
                set2=i;
                //System.out.println(set2);
            }
            
        }
        
        if(faces[set1]==4)//4 of a kind
        {
                
            handRank= "Four of a Kind";
            hRank.add(new Card(3,"-"));
            hRank.add(new Card(set1, "-"));
            return;
        }
        if((faces[set1]==3 && faces[set2]==2)||(faces[set2]==3 && faces[set1]==2))
        {
            handRank="Full House";
            hRank.add(new Card(4,"-"));
            hRank.add(new Card(set1,"-"));
            hRank.add(new Card(set2,"-"));
            return;
        }
        if(faces[set1]==2)
        {
            if(set2>0)
            {
                handRank="2 Pair";
                hRank.add(new Card(8,"-"));
                hRank.add(new Card(set1,"-"));
                hRank.add(new Card(set2, "-"));
                return;
            }
            else
            {
                handRank="Pair";
                hRank.add(new Card(9,"-"));
                hRank.add(new Card(set1,"-"));
                return;
            }
        }
        if(faces[set1]==3)
        {
            handRank="3 of a Kind";
            hRank.add(new Card(7,"-"));
            hRank.add(new Card(set1,"-"));
            return;
        }
        if(faces[set1]==2)
        {
            handRank="Pair";
            hRank.add(new Card(9,"-"));
            hRank.add(new Card(set1,"-"));
            return;
        }

        handRank="High Card";
        hRank.add(new Card(10,"-"));
        
        if(hand.get(0).Face!=1)
            hRank.add(hand.get(4));
        else
        {
            hRank.add(hand.get(0));
        }
        return;
       //return new Card[]{}; 

    }

    

}
