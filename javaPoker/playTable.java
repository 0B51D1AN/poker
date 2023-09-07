public class playTable extends Card
{


    public static void main(String [] args)
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
