import java.util.*;
import java.util.Collections;
import java.util.List;
//import java.util.String;

public class Deck extends Card
{
	//Deck class extends card and assembles card objects into deck. 
	//Methods needed:
	//Shuffle
	//Deal
	//Remove Card (popCard)
	//Add Card (pushCard)
	//Sort
	//Display remaining cards
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
				if(f>10)
				{
					switch (f){
					case 11: temp="J";
					case 12: temp="Q";
					case 13: temp="K";			
					}
				}
				else
				{
					temp= String.valueOf(f);
				}
				
				
				switch(s){
				case 1:	deck.add(new Card(temp,"H"));
				case 2: deck.add(new Card(temp,"D"));
				case 3: deck.add(new Card(temp,"S"));
				case 4: deck.add(new Card(temp,"C"));
				default: break;
				}

			}

		}		
				
	}
	

	
	




}
