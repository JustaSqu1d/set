/**
 * A class that represents a standard deck of "Set" cards.
 */
public class Deck {
    /** 
     * The length of each sheet in the deck. 
     */
    private static final int SHEET_LENGTH = 4;
    
    /** 
     * The list of cards in the deck. 
     */
    private ArrayList<Card> cards = new ArrayList<Card>();
    
    /**
     * Creates a new deck of cards and initializes it.
     */
    public Deck() {
        initDeck();
    }
    
    /**
     * Initializes the deck of cards by adding 16 cards of each suit.
     */
    public void initDeck() {
        for (int col = 0; col < SHEET_LENGTH; col++) {
            for (int row = 0; row < SHEET_LENGTH; row++) {
                cards.add(new Card(col, row));
            }
        }
    }
    
    /**
     * Returns the card at the specified index.
     * 
     * @param n the index of the card to retrieve
     * @return the card at the specified index
     */
    public Card getCard(int n) {
        return cards.get(n);
    }
    
    /**
     * Removes and returns a random card from the deck.
     * 
     * @return a random card from the deck, or null if the deck is empty
     */
    public Card deal() {
        if (cards.size() == 0) return null;
        
        return cards.remove((int)(Math.random() * cards.size()));
    }
    
    /**
     * Returns the number of cards in the deck.
     * 
     * @return the number of cards in the deck
     */
    public int size() {
        return cards.size();
    }
}
