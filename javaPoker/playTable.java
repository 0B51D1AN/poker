import java.util.*;
import java.io.File;
import java.util.Scanner;
import java.io.FileNotFoundException;
public class playTable 
{


    public static void main(String [] args)throws FileNotFoundException   
    {
        
        if(args.length==1) 
        {
            
            

                // Check for duplicate cards when scanning file 
                File test= new File(args[0]);
                System.out.print(test.canRead());
                Scanner s= new Scanner(test);
                s.useDelimiter(", |,|\n");
            
           
                Player[] players= new Player[6];
                int p=0;
                int i=0;

                
                 while(s.hasNext())
                 {
                    System.out.print(s.next());

                    //USE DELIMITER COMMA + \n

                    //System.out.print(s.next());
                    Card [] pHand= new Card[5];
                    
                        while(p<5)
                        {
                            
                            pHand[p]= new Card(s.next());
                            p++;
                                                                          
                        }
                    
                    
                     p=0;
                     players[i]= new Player(pHand);
                     i++;

                }

                for( Player a : players)
                {
                    a.showHand();
                }
                
                
                s.close();
        
            
        }
        else
        {
            //Card testCard= new Card("10","H");
            Deck deck= new Deck();
            deck.display();

            Player p1= new Player();
            Player p2= new Player();
            Player p3= new Player();
            Player p4= new Player();
            Player p5= new Player();
            Player p6= new Player();

            deck.shuffle();
            deck.deal(p1,p2,p3,p4,p5,p6);

            p1.showHand();
            System.out.println();
            p2.showHand();
            System.out.println();
            p3.showHand();
            System.out.println();
            p4.showHand();
            System.out.println();
            p5.showHand();
            System.out.println();
            p6.showHand();
            System.out.println();

            deck.display();
        }
            
    }

}
