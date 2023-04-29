/**
* Checks if a double value is between two other double values.
* 
* @param a the double value to check
* @param low the lower bound of the range (inclusive)
* @param high the upper bound of the range (inclusive)
* @return true if a is between low and high (inclusive), false otherwise
*/
public boolean between(double a, double low, double high) {
  return(a >= low) && (a <= high);
}

/**
  * An enumeration of possible colors for a Set card.
  */
public enum Color { WARPED, PURPUR, CRIMSON, KAICHENG };

/**
  * Gets the color of a given Set card.
  * 
  * @param card the card whose color to return
  * @return the color of the card
  */
public Color getColor (Card card) {
  Color cardColor;
  
  int column = card.getCol();
  
  if (between(column, 0, 2)) {
    cardColor = Color.WARPED;
  }
  
  else if (between(column, 3, 5)) {
    cardColor = Color.PURPUR;
  } 
  
  else if (between(column, 6, 8)) {
    cardColor = Color.CRIMSON;
  }
  
  else {
    cardColor = Color.KAICHENG;
  }

  if (DEBUG) 
    System.out.println(cardColor);

  return cardColor;
}

/**
  * An enumeration of possible shapes for a Set card.
  */
public enum Shape { DIAMOND, CYLINDER, WAVE, CONE };

/**
  * Gets the shape of a given Set card.
  * 
  * @param card the card whose shape to return
  * @return the shape of the card
  */
public Shape getShape(Card card) {
  int column = card.getCol();

  Shape shape;
  
  if (column == 0 || column == 3 || column == 6) {
    shape = Shape.DIAMOND;
  }
  
  else if (column == 1 || column == 4 || column == 7) {
    shape = Shape.CYLINDER;
  }

  else if (column == 2 || column == 5 || column == 8) {
    shape = Shape.WAVE;
  }

  else {
    shape = Shape.CONE; 
  }

  if (DEBUG)
    System.out.println(shape);

  return shape;

}

/**
  * An enumeration of possible fills for a Set card.
  */
public enum Fill { SOLID, WIRED, EMPTY, IDK };

/**
  * Gets the fill of a given Set card.
  * 
  * @param card the card whose fill to return
  * @return the fill of the card
  */
public Fill getFill(Card card) {
  int row = card.getRow();

  Fill fill;
  
  if (between(row, 0, 2)) {
    fill = Fill.SOLID;
  }
  
  else if (between(row, 3, 5)) {
    fill = Fill.WIRED;
  } 
  
  else if (between(row, 6, 8)) {
    fill = Fill.EMPTY;
  }
  
  else {
    fill = Fill.IDK;
  }

  if (DEBUG)
    System.out.println(fill);

  return fill;
}

/**
  * Returns the number of shapes on the given card.
  *
  * @param card the card to get the count from
  * @return the number of shapes on the card
  */
public int getCount(Card card) {
  int row = card.getRow();

  int count = (row % 3) + 1;

  if (DEBUG)
    System.out.println(count);

  return count;
}
