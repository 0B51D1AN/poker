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
        System.out.println(""+Face+""+Suit+"");
    }


}