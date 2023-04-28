public boolean between(double a, double low, double high) {
    return(a >= low) && (a <= high);
}

public enum Color { WARPED, PURPUR, CRIMSON, KAICHENG };

public Color getColor (Card card) {
  /**
  Returns the color of card. If the color is neither than it must be a <code>Color.KAICHENG</code>.
  
  @params Card card: the card's color to return
  @returns Color: the color of the card
  
  */

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

public enum Shape { DIAMOND, CYLINDER, WAVE, CONE };

public Shape getShape(Card card) {
  /**
  Returns the shape of card. If the shape is neither than it must be a <code>Shape.CONE</code>.
  
  @params Card card: the card's shape to return
  @returns Shape: the shape of the card
  
  */
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

public enum Fill { SOLID, WIRED, EMPTY, IDK };

public Fill getFill(Card card) {
  /**
  Returns the fill of card. If the color is neither than it must be a <code>Fill.IDK</code>.
  
  @params Card card: the card's fill to return
  @returns Fill: the fill of the card
  
  */
  
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

public int getCount(Card card) {
  /**
  Returns the count of card.

  @params Card card: the card's count to return
  @returns int: the number of shapes on the card
  
  */
  int row = card.getRow();

  int count = (row % 3) + 1;

  if (DEBUG)
    System.out.println(count);

  return count;
}
