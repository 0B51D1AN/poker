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
                    //a.showHand();
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
            for(Player p: game)
            {
                p.showHand();
                System.out.println();
            }

            //boxofFate b = new boxofFate();
            
            //b.decideFate(game);
            for(Player p : game)
            {
                p.checkRank();
            }

            
            for(Player p : game)
            {
                System.out.print(p.handRank);
            }


            
            System.out.println("\n\n *** REMAINING CARDS IN DECK ***");
            deck.display();


        }



            
    }

    public static void sortHands(Player [] players)
    {
        try
        {
        ArrayList<Player> finalOrder= new ArrayList<Player>();
        
        // boolean swapped;
        // int n = players.length;
        // for (int i = 0; i < n - 1; i++) {
        //     swapped = false;
        //     for (int j = 0; j < n - 1 - i; j++) {
        //         if (players[j].hRank.get(0).Face > players[j + 1].hRank.get(0).Face) {
        //             // Swap arr[j] and arr[j + 1]
        //             Player temp = players[j];
        //             players[j] = players[j+1];
        //             players[j+1] = temp;
        //             swapped = true;
        //         }
        //     }
        //     // If no two elements were swapped in inner loop, the array is already sorted.
        //     if (!swapped) {
        //         break;
        //     }
        // }

        ArrayList<Player>[] ranks = new ArrayList[10]; 
        
        ArrayList<Player>start= new ArrayList<Player>(Arrays.asList(players));
        // Players should now be generally sorted into ranking orders. Now continue filtering through specific rankings to determine the higher if there are multiple of the same rank.

        for(Player p : players)
        {
            ranks[p.hRank.get(0).Face-1].add(p);
            
        }

        for(int i=0; i<ranks.length; i++)
        {
            if(ranks[i].size()>1)
            {
                sort(i, ranks[i]);
            }
        }

        for(int i=0; i<ranks.length; i++)
        {
            for(Player play : ranks[i])
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
    //use hRank to do initial sorting
    public static void sort(int i, ArrayList<Player> p)
    {
        switch(i)
        {
            case 0:             //Royal straight flush - Sort via "alphabetical order"
                    Player [] P= new Player[4];
                    for(Player player : p)
                    {
                        String s= player.hRank.get(0).Suit;
                                                 //Only 4 possible flushes available, we can sort through placing each found suit in the correct order in a temp array
                        switch(s){ 
                            case "S":   P[0]=player;
                            case "H":   P[1]=player;
                            case "C":   P[2]=player;
                            case "D":   P[3]=player;
                        }
                    }
                    for(Player play : P)
                    {
                        p.add(play);
                    }
                    break;
                    //All straights should now be in sorted order
            
            
            case 1:             //Straight flush
            
                    
                    return;
            case 2:             //Four of a kind
            
            
                    return;
            case 3:             //Full House
            
                    return;
            case 4:             //Flush
            
                    return;
            case 5:             //Straight
            
                    return;
            case 6:             //Three of a Kind
            
                    return;
            case 7:             //Two Pair
            
                    return;
            case 8:             //Pair
            
                    return;
            case 9:             //High Card
            
                    return;
            

        }
        //return 0;
    }


}
