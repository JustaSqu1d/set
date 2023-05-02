/**
* A Grid class that represents the board and cards in a SET game.
* The board contains the grid of cards and is typically called the board.
*/
public class Grid {
    //In the physical SET game, cards are placed on the table.
    //The table contains the grid of cards and is typically called the board.
    //
    //Note that the minimum number of cards that guarantees a set is 21,
    //so we create an array with enough columns to accommodate that.
    //(MAX_COLS == 7)
    Card[][] board = new Card[MAX_COLS][ROWS];   
    
    /**
    * Locations selected by the player.
    */
    ArrayList<Location> selectedLocs = new ArrayList<Location>();
    
    /**
    * Cards selected by the player (corresponds to the locations).
    */
    ArrayList<Card> selectedCards = new ArrayList<Card>();
    
    /**
    * Number of cards visible on the board.
    */
    int cardsInPlay;
    
    /**
    * Constructor for the Grid class.
    */
    public Grid() { 
        cardsInPlay = 0;
    }
    
    
    //GRID MUTATION PROCEDURES
    
    //1. Highlight (or remove highlight) selected card
    //2. Add (or remove) the location of the card in selectedLocs
    //3. Add the card to (or remove from) the list of selectedCards
    public void updateSelected(int col, int row) {
        /**
        * Highlights (or removes highlight) the selected card, adds (or removes) the location
        * of the card in selectedLocs, and adds the card to (or removes from) the list of selectedCards.
        * 
        * @param col The column of the selected card.
        * @param row The row of the selected card.
        */
        Card card = board[col][row];
        
        if (selectedCards.contains(card)) {
            int index = selectedCards.indexOf(card);
            selectedLocs.remove(index);
            selectedCards.remove(card);
            //score--;
        } else {
            selectedLocs.add(new Location(col, row));
            selectedCards.add(card);
        }
        
        //System.out.println("Cards = " + selectedCards + ", Locations = " + selectedLocs);
    }
    
    /**
    * Removes the selected set of cards from the board, adjusts the number of columns as needed,
    * and mutates the board to reflect the removal of the set.
    * 
    * Precondition: A Set has been successfully found
    * Postconditions:
    * - The number of columns is adjusted as needed to reflect removal of the set
    * - The number of cards in play is adjusted as needed
    * - The board is mutated to reflect removal of the set
    */
    public void removeSet() {
        // Because it seems to make for a better UX, cards should not change locations unless
        // the number of columns has decreased.  If that happens, cards from the rightmost
        // column should be moved to locations where cards that formed the selected set
        // Put the locations of the selected cells in order.  Cards from the rightmost column
        // that are part of the set should be removed instead of being migrated.
        
        selectedLocs.sort(null);  // Don't delete this line as it orders the selected locations
        // You may wish to look up how the Location class decides
        // how to compare two different locations.  Also look up the
        // documentation on ArrayList to see how sort(null) works
        
        // YOU WRITE THIS
        
        if (cardsInPlay == 12 && deck.size() != 0) { 
            // When there are 12 cards on the board, delete the 3 cards being selected and replace them with new ones
            for (Location location : selectedLocs) {
                board[location.getCol()][location.getRow()] = deck.deal();
            }
        } else {
            // When there are more than 12 cards on the board or there are no more cards in the deck
            int ind = 0;
            for (int i = 0; i < ROWS; i++) {
                boolean isInArray = false; // variable to check whether the position (currentCols-1, i) is in the Arraylist selectedLocs
                for (int j = 0; j < selectedLocs.size(); j++) {
                    if (selectedLocs.get(j).equals(new Location(currentCols - 1, i))) { // if the position (currentCols-1, i) is in the arraylist currentLocs, then isInArray=true
                        isInArray = true;
                        break;
                    }
                }
                // If the card is in the Arraylist currentLocs, then we don't need to care about it as it is going to be removed anyways
                if (!isInArray) { // otherwise
                    // We move the card at (currentCols, 1) to one of the removed positions
                    board[selectedLocs.get(ind).getCol()][selectedLocs.get(ind).getRow()] = board[currentCols - 1][i];
                    ind++; // and we move on to the next removed position
                }
                board[currentCols - 1][i] = null; // Remove the column
                
            }
            currentCols--; // Update the currentCols varible
            cardsInPlay -= 3; // Decrease the cards on the board counter by 3
        }
    }
    
    /**
    * Processes a triple of selected cards. If the cards form a valid set,
    * updates the game state, score, and game message, and clears the selected cards list.
    * If the cards do not form a valid set, updates the game state and message, and clears the selected cards list.
    * 
    * Precondition: Three cards have been selected by the player.
    * Postcondition: Game state, score, game message mutated, selected cards list cleared.
    */
    public void processTriple() {
        if (isSet(selectedCards.get(0), selectedCards.get(1), selectedCards.get(2))) {
            score += 10;
            removeSet();
            if (isGameOver()) {
                state = State.GAME_OVER;
                runningTimerEnd = millis();
                score += timerScore();
                message = 7;
            } else {
                state = State.PLAYING;
                message = 1;
            }
        } else {
            state = State.PLAYING;
            message = 2;
            if (gamemode == Gamemode.SURVIVAL) {
                strikes += 1;
                if (isGameOver()) {
                    state = State.GAME_OVER;
                    runningTimerEnd = millis();
                    message = 7;
                    if (score > highScore) {
                        highScore = score;
                        saveHighScore();
                    }
                }
            } else if (gamemode == Gamemode.REGULAR) {
                score -= 5;
            }
        }
        clearSelected();
    }
    
    
    /**
    * Displays the board on the GUI.
    */
    public void display() {
        int cols = cardsInPlay / 3;
        for (int col = 0; col < cols; col++) {
            for (int row = 0; row < ROWS; row++) {
                board[col][row].display(col, row);
            }
        }
    }
    
    /**
    * Highlights the selected cards on the board based on the current game state and the selected cards.
    * If the game state is FIND_SET, highlights the cards that form a set using FOUND_HIGHLIGHT color,
    * and sets the selected locations to the locations of the cards that form the set.
    * If the game state is not FIND_SET and there are less than 3 selected cards, highlights the selected
    * cards using SELECTED_HIGHLIGHT color.
    * If the game state is not FIND_SET and there are 3 selected cards, highlights the selected cards using
    * CORRECT_HIGHLIGHT color if the selected cards form a set, or INCORRECT_HIGHLIGHT color otherwise.
    */
    public void highlightSelectedCards() {
        color highlight;
        if (state == State.FIND_SET) {
            highlight = FOUND_HIGHLIGHT;
            selectedLocs = findSet();
            if (selectedLocs.size() == 0) {
                message = 6;
                return;
            }
        } else if (selectedLocs.size() < 3) {
            highlight = SELECTED_HIGHLIGHT;
        } else {
            highlight = isSet(selectedCards.get(0), selectedCards.get(1), selectedCards.get(2)) ?
                CORRECT_HIGHLIGHT :
                INCORRECT_HIGHLIGHT;
        }
        for (Location loc : selectedLocs) {
            drawHighlight(loc, highlight);
        }
    }
    
    /**
    * Draws a highlighted rectangle at the specified Location with the given highlight color.
    * 
    * @param loc           the Location to draw the highlight at
    * @param highlightColor the color of the highlight as a Processing color value
    */
    public void drawHighlight(Location loc, color highlightColor) {
        stroke(highlightColor);
        strokeWeight(5);
        noFill();
        int col = loc.getCol();
        int row = loc.getRow();
        rect(GRID_LEFT_OFFSET + col * (CARD_WIDTH + GRID_X_SPACER), 
            GRID_TOP_OFFSET + row * (CARD_HEIGHT + GRID_Y_SPACER), 
            CARD_WIDTH, 
            CARD_HEIGHT);
        stroke(#000000);
        strokeWeight(1);
    }
    
    
    //DEALING CARDS
    
    /**
    * Adds the given card to the board.
    * Preconditions: cardsInPlay contains the current number of cards on the board,
    * the array board contains the cards that are on the board.
    * Postconditions: board has been updated to include the card,
    * the number of cardsInPlay has been increased by one.
    *
    * @param card the card to be added to the board.
    */
    public void addCardToBoard(Card card) {
        // YOU WRITE THIS
        for (int col = 0; col < currentCols; col++) {
            for (int row  = 0; row < ROWS; row++) {
                Card cardAtLocation = board[col][row];
                
                if (!(cardAtLocation instanceof Card)) {
                    board[col][row] = card;
                    cardsInPlay++;
                    return;
                }
            }
        }
    }
    
    
    /**
    * Adds a column of cards to the board according to game rules.
    * If there are no more cards in the deck, changes the message number to indicate this and returns without making any changes to the board.
    * If there are no sets on the board, adds five points to the player's score and adds three new cards to the board.
    * If there is a set on the board, subtracts five points from the player's score and changes the message number to indicate this.
    */
    public void addColumn() {
        // If there are no more cards in the deck, change the message number so this will be indicated and back out of the method. return with no inputs is how to break out of a void method.
        // If there are no sets on the board, then add five points to the player's score and add three new cards to the board. Change the message number to indicate that cards have been added to the board. Use the addCardToBoard method appropriately.
        // If there is a set on the board, subtract five points from the player's score and change the message number to indicate that there is a set on the board.
        // YOU WRITE THIS
        
        if (deck.size() == 0) {
            message = 5;
            return;
        }
        
        boolean hasSet = !(findSet().size() == 0);
        
        if (hasSet) {
            message = 4;
            score -= 5;
        } else if (!(hasSet)) {
            message = 3;
            score += 5;
            currentCols++;
            for (int i = 0; i < ROWS; i++) {
                addCardToBoard(deck.deal());
            }
        }
    }
    
    
    //GAME PROCEDURES
    
    /**
    * Determines whether the game is over or not.
    *
    * @return true if there are no more cards in the deck and no more sets can be formed, false otherwise.
    */
    public boolean isGameOver() {
        // YOU WRITE THIS
        
        if (DEBUG)
            System.out.println("Game Over:" + (deck.size() == 0 && findSet().size() == 0));
        
        if (gamemode == Gamemode.REGULAR) {
            return(deck.size() == 0 && findSet().size() == 0);
        } else if (gamemode == Gamemode.SURVIVAL) {
            return(deck.size() == 0 && findSet().size() == 0) || (strikes == MAX_STRIKES);
        } else {
            return false;
        }
    }
    
    /**
    * Checks if three locations have been selected on the game board.
    *
    * @return true if exactly three locations have been selected, false otherwise.
    */
    public boolean tripleSelected() {
        return(selectedLocs.size() == 3);
    }
    
    /**
    * Clears the selected locations and cards ArrayLists.
    *
    * @preconditions none
    * @postconditions The selected locations and cards ArrayLists are emptied.
    */
    public void clearSelected() {
        selectedLocs.clear();
        selectedCards.clear();
    }
    
    /**
    * Finds a set of three cards on the board.
    *
    * @return an ArrayList of Locations containing the locations of the cards that form a set, or an empty ArrayList if no set exists.
    * @preconditions none
    * @postconditions No change to any state variables.
    */
    public ArrayList<Location> findSet() {
        ArrayList<Location> locs = new ArrayList<Location>();
        for (int i = 0; i < currentCols * 3 - 2; i++) {
            for (int j = i + 1; j < currentCols * 3 - 1; j++) {
                for (int k = j + 1; k < currentCols * 3; k++) {
                    if (isSet(board[col(i)][row(i)], board[col(j)][row(j)], board[col(k)][row(k)])) {
                        locs.add(new Location(col(i), row(i)));
                        locs.add(new Location(col(j), row(j)));
                        locs.add(new Location(col(k), row(k)));
                        return locs;
                    }
                }
            }
        }
        return new ArrayList<Location>();
    }
    
    
    //UTILITY FUNCTIONS FOR GRID CLASS
    
    /**
    * Gets the column index from a linear index in the game grid.
    *
    * @param n the linear index
    * @return the column index
    */
    public int col(int n) {
        return n / 3;
    }
    
    /**
    * Gets the row index from a linear index in the game grid.
    *
    * @param n the linear index
    * @return the row index
    */
    public int row(int n) {
        return n % 3;
    }
    
    /**
    * Gets the right offset of the game grid.
    *
    * @return the right offset of the game grid.
    */
    public int rightOffset() {
        return GRID_LEFT_OFFSET + currentCols * (CARD_WIDTH + GRID_X_SPACER);
    }
}
