// Really important to remember that column and row for the
// card class refers to the column and row in the sprite sheet
public class Card {
  private int col;       // Column number in sheet
  private int row;       // Row number in sheet
  
  /**
  * Constructs a new Card object with the given column and row.
  * @param col the column number of the card in the sprite sheet
  * @param row the row number of the card in the sprite sheet
  */
  public Card(int col, int row) {
    this.col = col;
    this.row = row;
  }

  /**
   * Returns the row number of this card.
   * @return the row number of this card
   */
  public int getRow() { return row; }

  /**
   * Returns the column number of this card.
   * @return the column number of this card
   */
  public int getCol() { return col; }
  
  /**
   * Sets the row number of this card.
   * @param row the new row number for this card
   */
  public void setRow(int row) { this.row = row; }
  
  /**
   * Sets the column number of this card.
   * @param col the new column number for this card
   */
  public void setCol(int col) { this.col = col; }

  /**
   * Displays the card at the given board column and row.
   * If the card is paused, it displays as an orange rectangle.
   * Otherwise, it displays the image of the card from the sprite sheet.
   * @param boardCol the column number on the board where the card is displayed
   * @param boardRow the row number on the board where the card is displayed
   */  
  public void display(int boardCol, int boardRow) {
    if (state == State.PAUSED) {
      fill(#FF8800);
      rect(GRID_LEFT_OFFSET+boardCol*(CARD_WIDTH+GRID_X_SPACER), 
                GRID_TOP_OFFSET+boardRow*(CARD_HEIGHT+GRID_Y_SPACER),
                CARD_WIDTH, 
                CARD_HEIGHT);
    } else {
      image(cimg, GRID_LEFT_OFFSET+boardCol*(CARD_WIDTH+GRID_X_SPACER), 
                  GRID_TOP_OFFSET+boardRow*(CARD_HEIGHT+GRID_Y_SPACER),
                  CARD_WIDTH, 
                  CARD_HEIGHT,
                  LEFT_OFFSET + col*CARD_WIDTH, 
                  TOP_OFFSET + row*CARD_HEIGHT, 
                  (col+1)*CARD_WIDTH+CARD_X_SPACER, 
                  (row+1)*CARD_HEIGHT+CARD_Y_SPACER);
    }
  }

  /**
   * Checks if this card is equal to another card.
   * @param other the other card to compare to
   * @return true if this card is equal to the other card (same column and row), false otherwise
   */ 
  public boolean equals(Card other) {
    return (col == other.col && row == other.row);
  }
  
  /**
   * Returns a string representation of this card in the format "C(col,row)".
   * @return a string representation of this card
   */
  public String toString() {
    return "C(" + col + "," + row + ")";
  }
}
