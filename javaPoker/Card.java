import java.util.*;
//import java.util.Integer;
public class Card
{

// Card class holds identity of card with values. Will be extended to be included in a deck class to add uniqueness to cards and sort them.
    int Face;
    String Suit;


    public Card()
    {
        Face= 0;
        Suit= "";
    }

    public Card(int f, String s)
    {
        Face= f;
        Suit= s;
    }

    public int getFace()
    {
        return Face;
    }

    public String getSuit()
    {
        return Suit;
    }

    public void printCard()
    {
        
        switch(Face)
        {
            case 1: System.out.print("A"+Suit+" ");
                    break;
            case 11: System.out.print("J"+Suit+" ");
                    break;
            case 12: System.out.print("Q"+Suit+" ");
                    break;
            case 13: System.out.print("K"+Suit+" ");
                    break;
            default: System.out.print(""+Face+""+Suit+" ");
                    break;
        }
        
    }


}
