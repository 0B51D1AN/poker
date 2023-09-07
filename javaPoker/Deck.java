import java.util.*;
import java.util.Collections;
import java.util.List;
//import java.util.String;

public class Deck extends Card
{
	//Deck class extends card and assembles card objects into deck. 
	
	private List<Card> deck;

	//Need to check to make sure all cards in a deck are placed inside of the deck object.
	//
	//
	public Deck()
	{
		
		deck= new ArrayList<Card>(); //Perhaps change to arraylist later
							// Fill Deck with Cards
		for(int s=1; s<5; s++)
		{
			for(int f= 1; f<14; f++)	
			{
			String temp="";
			
				switch (f){

					case 1: temp= "A";
							break;
					case 11: temp="J";
							break;
					case 12: temp="Q";
							break;
					case 13: temp="K";
							break;			
					default: temp= String.valueOf(f);
							break;
				}
				
				
				switch (s){
					case 1:	deck.add(new Card(temp,"H"));
							break;
					case 2: deck.add(new Card(temp,"D"));
							break;
					case 3: deck.add(new Card(temp,"S"));
							break;
					case 4: deck.add(new Card(temp,"C"));
							break;
					default: break;
				}

			}

		}		
			
		System.out.println("Deck has been initialized and sorted");
	
	}
	

	//Methods needed:


	//Shuffle
	public void shuffle()
	{

		Collections.shuffle(deck);

	}



	//Deal
	// public void deal(Player ... players)
	// {
		

	// }

	//Remove Card (popCard)
	public Card popCard()
	{
		Card temp= deck.get(0);
		deck.remove(0);
		return temp;

	}
	//Add Card (pushCard)
	public void pushCard(Card c)
	{
		deck.add(c);
	}

	// Dont need to Sort rn since deck is organized at initialization
	public void sort()
	{


	}


	//Display remaining cards
	public void display()
	{

		for(int i=0; i<deck.size(); i++)
		{
			deck.get(i).printCard();
		}

	}





}
