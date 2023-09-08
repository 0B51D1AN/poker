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
    
    public Card(String c)
    {
        if(c.length()==3)
        {
            Face= 10;
            Suit=""+c.charAt(2);
        }
        else
        {
            switch(c.charAt(0))
            {
                case 'A':   Face= 1;
                            Suit=""+c.charAt(1);
                            break;
                case 'K':   Face=13;
                            Suit=""+c.charAt(1);
                            break;
                case 'Q':   Face=12;
                            Suit=""+c.charAt(1);
                            break;
                case 'J':   Face=11;
                            Suit=""+c.charAt(1);
                            break;
                default :   Face=(int)c.charAt(0);
                            Suit=""+c.charAt(1);
                            break;
            }

        }


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
