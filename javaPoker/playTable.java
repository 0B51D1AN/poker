import java.util.*;
import java.io.File;
import java.util.Scanner;
import java.io.FileNotFoundException;
public class playTable 
{


    public static void main(String [] args)throws FileNotFoundException   
    {
        Player tester = new Player(new Card(2,"C"), new Card(13,"S"),new Card(13,"H"), new Card(7,"S"), new Card(8,"S"));
        
        tester.checkRank();
        System.out.print(tester.handRank+" -->  ");
        
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
                // for( Player a : players)
                // {
                //     a.showHand();
                // }
                
                
                s.close();
                //boxofFate b = new boxofFate();
                //b.decideFate(players);
        
            
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

}
