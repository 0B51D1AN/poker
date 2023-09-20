import java.util.*;
import java.io.File;
import java.io.FileNotFoundException;
public class playTable 
{


    public static void main(String [] args)throws FileNotFoundException   
    {
        //Player tester = new Player(new Card(2,"C"), new Card(2,"S"),new Card(2,"H"), new Card(2,"D"), new Card(8,"S"));
        
        //tester.checkRank();
        //System.out.print(tester.handRank+" -->  ");
        
        //tester.hRank.get(0).printCard();
        if(args.length==1) 
        {
            
                ArrayList<String> cardPool= new ArrayList<String>();
                ArrayList<String> extra= new ArrayList<String>();

                // Check for duplicate cards when scanning file 
                File test= new File(args[0]);
                //System.out.print(test.canRead());
                Scanner s= new Scanner(test);
                s.useDelimiter(", |,|\n");
            
           
                Player [] players= new Player[6];
                int p=0;
                int i=0;
                Card [] pHand= new Card[5];
                //Card c= new Card();
                 while(s.hasNext())
                 {
                    //System.out.print(s.next());

                    //USE DELIMITER COMMA + \n

                  
                    //c.printCard();
                    

                        while(p<5)
                        {
                            String temp = s.next();
                            if(cardPool.contains(temp))
                                extra.add(temp);
                            else
                                cardPool.add(temp);
                            //System.out.println(temp);
                            pHand[p]= new Card(temp);
                            p++;
                                                                          
                        }
                    players[i]=new Player(pHand);
                        // for(Card c : pHand)
                        // {
                        //     c.printCard();
                        // }
                        // System.out.println();
                    

                    p=0;
                    i++;
                   
                    //  Arrays.fill(pHand, null);

                }


                if(extra.size()>0)
                {
                    for(Player plr : players)
                    {
                        plr.showHand();
                        System.out.println();
                    }
                    System.out.println("ERROR: Duplicate Card(s) Detected\n");
                    for(String str : extra)
                    {
                        System.out.print(" "+str);
                    }
                    System.out.println();
                }
                for( Player a : players)
                {
                    a.sortHand();
                   // a.showHand();
                    a.checkRank();

                    //System.out.println(a.handRank);
                }
                
                
                sortHands(players);

                s.close();
                //boxofFate b = new boxofFate();
                //b.decideFate(players);
                // for(Player play : players)
                // {
                //     play.checkRank();
                //     System.out.println(play.handRank);
                // }
        
            
        }
        else
        {
            //Card testCard= new Card("10","H");
            Deck deck= new Deck();
            deck.display();
            System.out.println();
            Player [] game= new Player[] {

            new Player(),
            new Player(),
            new Player(),
            new Player(),
            new Player(),
            new Player()

            };

            deck.shuffle();

            deck.deal(game);
            for(Player p : game)
            {
                p.sortHand();
            }
            // for(Player p: game)
            // {
            //     p.showHand();
            //     System.out.println();
            // }

            //boxofFate b = new boxofFate();
            
            //b.decideFate(game);
            for(Player p : game)
            {
                
                p.checkRank();
                //p.showHand();
                //System.out.print("  -  "+p.handRank+"\n");
            }

            
            // for(Player p : game)
            // {
            //     System.out.print(p.handRank);
            // }

            sortHands(game);
            
            System.out.println("\n\n *** REMAINING CARDS IN DECK ***");
            deck.display();
            System.out.println();


        }



            
    }

    public static void sortHands(Player [] players)
    {
        try
        {
        ArrayList<Player> finalOrder= new ArrayList<Player>();
      

        ArrayList<ArrayList<Player>> ranks = new ArrayList<ArrayList<Player>>(10); 
        
        ArrayList<Player>start= new ArrayList<Player>(Arrays.asList(players));
        // Players should now be generally sorted into ranking orders. Now continue filtering through specific rankings to determine the higher if there are multiple of the same rank.

        for(int i=0; i<10; i++)
        {
            ranks.add(new ArrayList<Player>());
            //System.out.println("List "+i+" Added");
        }
        for(Player p : players)
        {
            //System.out.println(p.hRank.get(0).Face);
            ranks.get((p.hRank.get(0).Face)-1).add(p);
            //System.out.println("ADDING");
        }

        for(int i=0; i<ranks.size(); i++)
        {
            //System.out.println(ranks.get(i));
            if(ranks.get(i).size()>1)
            {
                sort(i, ranks.get(i));
            }
        }

        for(int i=0; i<ranks.size(); i++)
        {
            for(Player play : ranks.get(i))
            {
                play.showHand();
                System.out.print("   -  "+play.handRank+"\n");
            }
        }
        }
        catch(Exception e){
            System.out.println(e.getMessage());
        }

    }
    //use hRank to do initial sorting just find the winner. Focus on finding only the winning hand.
    public static void sort(int i, ArrayList<Player> p)
    {
        switch(i)
        {
            case 0:   
                    System.out.println("FLUSH");          //Royal straight flush - Sort via "alphabetical order"
                    royalFlush(p);
                    break;           
            
            case 1:             //Straight flush 
                    System.out.println("STRAIGHT FLUSH");
                    flush(p);
                    break;
            case 2:             //Four of a kind
                    System.out.println("FOUR OF A KIND");
                    fourOfKind(p);
                    break;
            case 3:             //Full House
                    System.out.println("FULL HOUSE");
                    fullHouse(p);
                    break;
            case 4:             //Flush
                    System.out.println("FLUSH");
                    flush(p);
                    break;
            case 5:             //Straight
                    System.out.println("STRAIGHT");
                    straight(p);
                    break;
            case 6:             //Three of a Kind
                    System.out.println("THREE OF A KIND");
                    threeOfKind(p);
                    break;
            case 7:             //Two Pair
                    System.out.println("TWO PAIR");
                    twoPair(p);
                    break;
            case 8:             //Pair
                    System.out.println("PAIR");
                    pair(p);
                    break;
            case 9:             //High Card
                    System.out.println("HIGH CARD");
                    highCard(p);
                    break;
            

        }
        //break 0;
    }

    public static void royalFlush(ArrayList<Player> p)
    {
        Player [] ranks= new Player [4];
        //ArrayList<Player> last= new ArrayList<Player>();

        for(Player Player : p)
        {
            String s= Player.hRank.get(0).Suit;
            switch(s)
            {
                case "S":

                            ranks[0]=Player;
                            break;
                case "H":

                            ranks[1]=Player;
                            break;
                case "C":

                            ranks[2]=Player;
                            break;
                case "D":
                            
                            ranks[3]=Player;
                            break;


            }

        }
        p.clear();
        for(Player play : ranks)
        {
            
            p.add(play);
            
            //System.out.println(play.handRank);

        }
        
        //p.removeAll();
        

    }
    public static void flush(ArrayList<Player> p) //multipurpose since we can just examine the highest card for either straight flush or normal flush
    {
        Collections.sort(p, new Comparator<Player>()
        {
                public int compare (Player s1, Player s2)
                {
                    return Integer.valueOf(s1.hand.get(4).Face).compareTo(s2.hand.get(4).Face);
                }
        });
        ArrayList<Player> temp = new ArrayList<Player>();

        for(int i=p.size()-1; i>=0; i--)
        {
            temp.add(p.get(i));
        }
        //checkDouble(temp);
	p.clear();
        for(Player play : temp)
        {
            p.add(play);
        }

    }
    public static void fourOfKind(ArrayList<Player> p) 
    {
        Collections.sort(p, new Comparator<Player>()
        {
                public int compare (Player s1, Player s2)
                {
                    return Integer.valueOf(s1.hRank.get(1).Face).compareTo(s2.hRank.get(1).Face);
                }
        });
        
        ArrayList<Player> temp = new ArrayList<Player>();

        while(!p.isEmpty())
        {
            	if(p.get(0).hRank.get(1).Face==1)
                {
                    temp.add(p.get(0));
                    p.remove(0);
                }
                else    
                {
                    temp.add(p.get(p.size()-1));
                    p.remove(p.size()-1);
                }
        }

        p.clear();
        for(Player play : temp)
        {
            p.add(play);
        }
        
    }
    public static void fullHouse(ArrayList<Player> p)
    {
        Collections.sort(p, new Comparator<Player>()
        {
                public int compare (Player s1, Player s2)
                {
                    return Integer.valueOf(s1.hRank.get(2).Face).compareTo(s2.hRank.get(2).Face);
                }
        });
        
        ArrayList<Player> temp = new ArrayList<Player>();
       while(!p.isEmpty())
        {
            	if(p.get(0).hRank.get(1).Face==1)
                {
                    temp.add(p.get(0));
                    p.remove(0);
                }
                else    
                {
                    temp.add(p.get(p.size()-1));
                    p.remove(p.size()-1);
                }
        }

        p.clear();
        for(Player play : temp)
        {
            p.add(play);
        }


    }
    public static void straight(ArrayList<Player> p)
    {
        Collections.sort(p, new Comparator<Player>()
        {
                public int compare (Player s1, Player s2)
                {
                    return Integer.valueOf(s1.hand.get(4).Face).compareTo(s2.hand.get(4).Face);
                }
        });
        ArrayList<Player> temp = new ArrayList<Player>();

        while(!p.isEmpty())
        {
            	if(p.get(0).hRank.get(1).Face==1)
                {
                    temp.add(p.get(0));
                    p.remove(0);
                }
                else    
                {
                    temp.add(p.get(p.size()-1));
                    p.remove(p.size()-1);
                }
        }
        //checkDouble(temp);
        p.clear();
        for(Player play : temp)
        {
            p.add(play);
        }



    }
    public static void threeOfKind(ArrayList<Player> p)
    {
        Collections.sort(p, new Comparator<Player>()
        {
                public int compare (Player s1, Player s2)
                {
                    return Integer.valueOf(s1.hRank.get(1).Face).compareTo(s2.hRank.get(1).Face);
                }
        });
        
        ArrayList<Player> temp = new ArrayList<Player>();
        while(!p.isEmpty())
        {
            	if(p.get(0).hRank.get(1).Face==1)
                {
                    temp.add(p.get(0));
                    p.remove(0);
                }
                else    
                {
                    temp.add(p.get(p.size()-1));
                    p.remove(p.size()-1);
                }
        }

        p.clear();
        for(Player play : temp)
        {
            p.add(play);
        }


    }
    public static void twoPair(ArrayList<Player> p)
    {
        Collections.sort(p, new Comparator<Player>()
        {
                public int compare (Player s1, Player s2)
                {
                    return Integer.valueOf(s1.hRank.get(2).Face).compareTo(s2.hRank.get(2).Face);
                }
        });
        
        ArrayList<Player> temp = new ArrayList<Player>();
        while(!p.isEmpty())
        {
            	if(p.get(0).hRank.get(1).Face==1)
                {
                    temp.add(p.get(0));
                    p.remove(0);
                }
                else    
                {
                    temp.add(p.get(p.size()-1));
                    p.remove(p.size()-1);
                }
        }

        p.clear();
        for(Player play : temp)
        {
            p.add(play);
        }


    }
    public static void pair(ArrayList<Player> p)
    {
        Collections.sort(p, new Comparator<Player>()
        {
                public int compare (Player s1, Player s2)
                {
                    return Integer.valueOf(s1.hRank.get(1).Face).compareTo(s2.hRank.get(1).Face);
                }
        });
        
        ArrayList<Player> temp = new ArrayList<Player>();
        while(!p.isEmpty())
        {
            	if(p.get(0).hRank.get(1).Face==1)
                {
                    temp.add(p.get(0));
                    p.remove(0);
                }
                else    
                {
                    temp.add(p.get(p.size()-1));
                    p.remove(p.size()-1);
                }
        }
        //ArrayList<Player> tempo = new ArrayList<Player>();
        // for(int i=1; i<p.size(); i++)
        // {
        //     if((p.get(i).hRank.get(1).Face==p.get(i-1).hRank.get(1).Face))
        //     {
        //         if(swap(p.get(i-1).hRank.get(1),p.get(i).hRank.get(1)))
        //         {
        //             tempo.add(p.get(i-1));
        //             p.set(i-1,p.get(i));
        //             p.set(i, temp.get(0));  
        //             tempo.clear();  
        //         }
                
                
        //     }
        // }
        //checkDouble(temp);
        p.clear();
        for(Player play : temp)
        {
            p.add(play);
        }


    }
    public static void highCard(ArrayList<Player> p)
    {
        //check for aces
        //find highest card(s)
        Collections.sort(p, new Comparator<Player>()
        {
                public int compare (Player s1, Player s2)
                {
                    return Integer.valueOf(s1.hRank.get(1).Face).compareTo(s2.hRank.get(1).Face);
                }
        });
        
        ArrayList<Player> temp = new ArrayList<Player>();
        while(!p.isEmpty())
        {
            	if(p.get(0).hand.get(0).Face==1)
                {
                    temp.add(p.get(0));
                    p.remove(0);
                }
                else    
                {
                    temp.add(p.get(p.size()-1));
                    p.remove(p.size()-1);
                }
        }

       checkDouble(temp);

        
        p.clear();
        for(Player play : temp)
        {
            p.add(play);
        }


    }

	public static void checkDouble(ArrayList<Player> p)
	{	
	
        ArrayList<Player> temp = new ArrayList<Player>();
        for(int i=1; i<p.size(); i++)
        {
            if(((p.get(i).hand.get(0).Face==1) && (p.get(i-1).hand.get(0).Face==1))|| (p.get(i).hand.get(4).Face==p.get(i-1).hand.get(4).Face))
            {
                if(swap(p.get(i-1).hRank.get(1),p.get(i).hRank.get(1)))
                {
                    temp.add(p.get(i-1));
                    p.set(i-1,p.get(i));
                    p.set(i, temp.get(0));  
                    temp.clear();  
                }
                
                
            }
        }

        
	}	

    public static boolean swap(Card c1, Card c2) //assuming cards input are the same face, there can be no double suit
    {
        Card [] ranks= new Card [4];
        //ArrayList<Player> last= new ArrayList<Player>();
            switch(c1.Suit)
            {
                case "S":
                            ranks[0]=c1;
                            break;
                case "H":
                            ranks[1]=c1;
                            break;
                case "C":
                            ranks[2]=c1;
                            break;
                case "D":        
                            ranks[3]=c1;
                            break;
            }
            switch(c2.Suit)
            {
                case "S":
                            ranks[0]=c2;
                            break;
                case "H":
                            ranks[1]=c2;
                            break;
                case "C":
                            ranks[2]=c2;
                            break;
                case "D":   
                            ranks[3]=c2;
                            break;
            }
        
            for(Card c: ranks)
            {
                if(c.Suit.equals(c2.Suit))
                    return true;
                else
                    return false;
            }
            return true;

        

    }


}
