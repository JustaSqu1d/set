public class Grid {
    //In the physical SET game, cards are placed on the table.
    //The table contains the grid of cards and is typically called the board.
    //
    //Note that the minimum number of cards that guarantees a set is 21,
    //so we create an array with enough columns to accommodate that.
    //(MAX_COLS == 7)
    Card[][] board = new Card[MAX_COLS][ROWS];   
    
    ArrayList<Location> selectedLocs = new ArrayList<Location>();  // Locations selected by the player
    ArrayList<Card> selectedCards = new ArrayList<Card>();         // Cards selected by the player 
    // (corresponds to the locations)  
    int cardsInPlay;    // Number of cards visible on the board
    
    public Grid() { 
        cardsInPlay = 0;
    }
    
    
    //GRID MUTATION PROCEDURES
    
    //1. Highlight (or remove highlight) selected card
    //2. Add (or remove) the location of the card in selectedLocs
    //3. Add the card to (or remove from) the list of selectedCards
    public void updateSelected(int col, int row) {
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
    
    //Precondition: A Set has been successfully found
    //Postconditions: 
    //* The number of columns is adjusted as needed to reflect removal of the set
    //* The number of cards in play is adjusted as needed
    //* The board is mutated to reflect removal of the set
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
                    if (selectedLocs.get(j).equals(new Location(currentCols-1, i))) { // if the position (currentCols-1, i) is in the arraylist currentLocs, then isInArray=true
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
            cardsInPlay-=3; // Decrease the cards on the board counter by 3
        }
    }
    
    //Precondition: Three cards have been selected by the player
    //Postcondition: Game state, score, game message mutated, selected cards list cleared
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
            score -= 5;
            state = State.PLAYING;
            message = 2;
        }
        clearSelected();
}
    
    
    //DISPLAY CODE
    
    public void display() {
        int cols = cardsInPlay / 3;
        for (int col = 0; col < cols; col++) {
            for (int row = 0; row < ROWS; row++) {
                board[col][row].display(col, row);
        }
        }
}
    
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
    
    //Preconditions: cardsInPlay contains the current number of cards on the board
    //the array board contains the cards that are on the board
    //Postconditions: board has been updated to include the card
    //the number of cardsInPlay has been increased by one
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
    
    public boolean isGameOver() {
        // YOU WRITE THIS

        if (DEBUG)
            System.out.println("Game Over:" + (deck.size() == 0 && findSet().size() == 0));

        return (deck.size() == 0 && findSet().size() == 0);
    }
    
    public boolean tripleSelected() {
        return(selectedLocs.size() == 3);
}
    
    //Preconditions: --
    //Postconditions: The selected locations and cards ArrayLists are empty
    public void clearSelected() {
        selectedLocs.clear();
        selectedCards.clear();
}
    
    //findSet(): If there is a set on the board, existsSet() returns an ArrayList containing
    //the locations of three cards that form a set, an empty ArrayList (not null) otherwise
    //Preconditions: --
    //Postconditions: No change to any state variables
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
    
    public int col(int n) {
        return n / 3;
}
    
    public int row(int n) {
        return n % 3;
}
    
    public int rightOffset() {
        return GRID_LEFT_OFFSET + currentCols * (CARD_WIDTH + GRID_X_SPACER);
}
}
