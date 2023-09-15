import java.util.*;

import java.util.Arrays;

 //Sort hand into 4 suit arrays highest to lowest (Hash of 13????).
    //begin with weakest 
    // Return card that represents the rank of the hand

public class boxofFate extends Player
{
    private int [] Spades= new int[13]; 
    private int [] Hearts= new int [13];
    private int [] Clubs= new int [13];
    private int [] Diamonds= new int [13];

    int [][] theBOX={Spades, Hearts, Clubs, Diamonds};

    
  
    //Final method called to decide final ranking of all players
    public void decideFate(Player ... players)
    {
        

        ArrayList<Card[]> fates= new ArrayList<Card[]>();

        for(Player p : players)
        {
            //Arrays.fill(theBOX, 0);
            
            sendtoTheBOX(p);
            fates.add(findFate()); // Filters through output of minor methods and returns final ranking of player's hand
        }
        Collections.sort(fates, new Comparator<Card[]>(){
        
            public int compare(Card [] c, Card[] c2)
            {
                return Integer.valueOf(c[0].getFace()).compareTo(c2[0].getFace());
            }

        });

        


    }

    // Analyze each Player and rank their hand

    // Use sub methods to help organize ordering
    public void sendtoTheBOX(Player player)
    {
        
        for (Card c : player.hand)
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
                //Scan theBOX to check if total >5 for duplicates
            }
        }

    }

    //returns highest card of hand
    // High Card

    public Card highCard()
    {
        for(int i : theBOX[0])
        {
            if(theBOX[i][0]==1)
                return new Card(1,i);               
        }
        
        //If no ace is found, scroll through deck from high low starting with spades to return the first occurence of a card since that will be the highest card
            for(int a= 12; a>1; a--)
            {
                for(int i=0; i<theBOX.length; i++)
                {
                    if(theBOX[i][a]==1)
                        return new Card(a+1,i);
                }

            }
            return new Card(0, "-");
        
        
    }

    //Scan horizontal to find certain trends and send to other method if certain patterns arise
    // Four of a Kind

    // Full House

    // Three of a Kind

    // Two Pair

    // Pair

    public Card [] scanH()
    {
      int pair=0;
      int pair2=0;//can be up to 3 for full house
      boolean full=false;
      int low=0;
      int mark=0;
     //Checking for sets at this point 
     for(int i=12; i>0; i--)
     {
        
        for(int a=0; a<theBOX.length; a++)
        {
            if(theBOX[i][a]==1 && full==false)
            {
                pair++;
                mark=i;
            }
            else if (theBOX[i][a]==1 && full==true)
            {
                pair2++;
                low=i;
            }   
            
        


        }
        if(pair==4)
            return new Card[]{new Card(3,"S"),new Card(i,"S"), highCard()}; // 4 of a kind, face of set, highCard (catches stray card)
        else if (pair== 3 || pair ==2)
            full=true;
        

     }

     if((pair==2 && pair2==3) || (pair==3 && pair2==2))
        return new Card[]{new Card(4,"S"), new Card(low,"S"),highCard()}; // Full House, low set, high set
     else if(pair==2 && pair2==2)
        return new Card[]{new Card(8,"S"), new Card(low,"S"),highCard()}; // 2 pair, low set, high set
     else if ((pair==2 || pair==3) && pair2<2)
        {
            //must be 3 of a kind or 1 pair

            if(pair==3)
                return new Card[]{new Card(7,"S"),new Card(mark,"S"),highCard()}; // 3 pair, face or set, highCard
            else
                return new Card[]{new Card(9,"S"),new Card(mark,"S"),highCard()}; // 2 pair, face of set, highCard
        }

        return new Card[]{highCard()};

    }

    //Scan vertical in case 

    // Royal Straight Flush

    // Straight Flushes

    // Flush
    public Card[] scanV()
    {
        int straight=0;
        int flush=0;

        
        for(int s=0;  s<theBOX.length; s++)
        {
            
            for(int f : theBOX[s])
            {
                flush=flush+theBOX[s][f];
            }
                if(flush==5)
                {
                    //Hand must now be a flush, next check for straight within the flush
                    for(int a : theBOX[s])
                    {
                        if(theBOX[s][a]==1)
                        {
                            straight++;
                        }
                        else if(theBOX[s][a]==0)
                        {
                            straight=0;
                        }
                    

                        if(straight==5 || (straight==4 && theBOX[s][0]==1 && theBOX[s][9]==1))
                        {
                            for(int b : theBOX[s])
                            {
                                if (theBOX[s][b]==1)
                                {
                                    if(b==9)
                                    {
                                        System.out.println("Royal Flush");
                                        return new Card[]{new Card(1,s)}; //Royal Flush
                                    }
                                    else
                                    {
                                        System.out.println("Straight Flush");
                                        return new Card[]{new Card(2,s), highCard()}; //Straight Flush
                                    }
                                }
                            }                    
                        }
                    }
                    System.out.println("Flush");
                    return new Card[]{new Card(5,s),highCard()}; //Flush

                }

        }
        return new Card[]{highCard()};

    }

    public Card[] checkStraight()
    {
        int count = 0;
        boolean found=false;
        for(int i=12; i>=0; i--)
        {
            found=false;
            for(int a=0; a<theBOX.length; a++)
            {
                
                if(theBOX[i][a]==1 && found==false)
                {
                    count++;
                    found=true;
                }


            }
        }
            if(count==5)
                return new Card[]{new Card(6,"S"), highCard()};

        return new Card[]{highCard()};

    }


    public Card[] findFate()
    {
        System.out.println(scanV());
        System.out.println(scanH());
        System.out.println(checkStraight());
        
        
        return new Card[]{};

    }





}


        // Cards should now be represented in unique hash

        // Now begin analyzing different ranks      


    
        // // Begin by analyzing Flushes by adding each column and checking for 5 in a column
        // int straight=0; //Track straight by checking initial row for items then checking adjacent rows
        // int flush=0; //Track flush by adding items in the same column
        // // int indexS=0; //Index for straight tracks the beginning row of a straight to check for royal straight+flush
        // // int set=0; // Set tracks the pairs that are possible. If set reaches 4 = 4 of a kind. if set and set2 reach 2 and 2/3= full house/2pair
        // // int set2=0;
        // // int highCard=0; //Track high card for hand by checking index.
        // // int suit=0; //Tracks suit which earned the flush

        
        
        
        
        

        // Straights

        

        





         
    

    




