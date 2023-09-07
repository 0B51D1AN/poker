import java.util.*;
//import java.util.Integer;
public class Card
{

// Card class holds identity of card with values. Will be extended to be included in a deck class to add uniqueness to cards and sort them.
    String Face;
    String Suit;


    public Card()
    {
        Face= "";
        Suit= "";
    }

    public Card(String f, String s)
    {
        Face= f;
        Suit= s;
    }

    public String getFace()
    {
        return Face;
    }

    public String getSuit()
    {
        return Suit;
    }

    public void printCard()
    {
        
        switch(Integer.parseInt(Face))
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
