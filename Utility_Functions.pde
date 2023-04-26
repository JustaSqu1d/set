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
  
  int column = card.getCol();
  
  if (between(column, 0, 2)) {
    return Color.WARPED;
  }
  
  else if (between(column, 3, 5)) {
    return Color.PURPUR;
  } 
  
  else if (between(column, 6, 8)) {
    return Color.CRIMSON;
  }
  
  else {
    return Color.KAICHENG;
  }
}

public enum Shape { DIAMOND, CYLINDER, WAVE, CONE };

public Shape getShape(Card card) {
  /**
  Returns the shape of card. If the shape is neither than it must be a <code>Shape.CONE</code>.
  
  @params Card card: the card's shape to return
  @returns Shape: the shape of the card
  
  */
  int column = card.getCol();
  
  if (column == 0 || column == 3 || column == 6) {
    return Shape.DIAMOND;
  }
  
  else if (column == 1 || column == 4 || column == 7) {
    return Shape.CYLINDER;
  }

  else if (column == 2 || column == 5 || column == 8) {
    return Shape.WAVE;
  }

  else {
    return Shape.CONE; 
  }

}

public enum Fill { SOLID, WIRED, EMPTY, IDK };

public Fill getFill(Card card) {
  /**
  Returns the fill of card. If the color is neither than it must be a <code>Fill.IDK</code>.
  
  @params Card card: the card's fill to return
  @returns Fill: the fill of the card
  
  */
  
  int row = card.getRow();
  
  if (between(row, 0, 2)) {
    return Fill.SOLID;
  }
  
  else if (between(row, 3, 5)) {
    return Fill.WIRED;
  } 
  
  else if (between(row, 6, 8)) {
    return Fill.EMPTY;
  }
  
  else {
    return Fill.IDK;
  }
}

public int getCount(Card card) {
  int row = card.getRow();
  
  return (row % 3) + 1;
}
