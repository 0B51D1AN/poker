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
	//REMINDER TO CREATE DECK THAT IS READ FROM CSV FILE

	public Deck()
	{
		
		deck= new ArrayList<Card>(); //Perhaps change to arraylist later
							// Fill Deck with Cards
		for(int s=1; s<5; s++)
		{
			for(int f= 1; f<14; f++)	
			{
			
				
				switch (s){
					case 1:	deck.add(new Card(f,"H"));
							break;
					case 2: deck.add(new Card(f,"D"));
							break;
					case 3: deck.add(new Card(f,"S"));
							break;
					case 4: deck.add(new Card(f,"C"));
							break;
					default: break;
				}

			}

		}		
			
		//System.out.println("Deck has been initialized and sorted");
	
	}
	

	//Methods needed:


	//Shuffle
	public void shuffle()
	{

		Collections.shuffle(deck);

	}

	


	//Deal
	public void deal(Player ... players)
	{
		if(deck.size()!= 52)
		{
			System.out.println("Incomplete deck, please make sure deck is full");
			return;
		}

		while(players[players.length-1].hand.size()<5)
		{
			for(Player p : players)
			{
				p.addCard(popCard());
			}
		}

	}

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

	



	//Display remaining cards
	public void display()
	{
		int format=0;
		for(int i=0; i<deck.size(); i++)
		{
			if(format==13)
			{
				System.out.println();
				format=0;
			}
			deck.get(i).printCard();
			format++;
		}

		System.out.println();

	}





}
