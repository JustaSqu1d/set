boolean sameColor(Card a, Card b, Card c) {
    /**
    * Checks if the given cards have the same color.
    * 
    * @param a the first card
    * @param b the second card
    * @param c the third card
    * @return {@code true} if all three cards have the same color, {@code false} otherwise
    */
    return allEqual(getColor(a).ordinal(), getColor(b).ordinal(), getColor(c).ordinal());
}

boolean sameShape(Card a, Card b, Card c) {
    /**
    * Checks if the given cards have the same shape.
    * 
    * @param a the first card
    * @param b the second card
    * @param c the third card
    * @return {@code true} if all three cards have the same shape, {@code false} otherwise
    */
    return allEqual(getShape(a).ordinal(), getShape(b).ordinal(), getShape(c).ordinal());
}

boolean sameFill(Card a, Card b, Card c) {
    /**
    * Checks if the given cards have the same fill.
    * 
    * @param a the first card
    * @param b the second card
    * @param c the third card
    * @return {@code true} if all three cards have the same fill, {@code false} otherwise
    */
    return allEqual(getFill(a).ordinal(), getFill(b).ordinal(), getFill(c).ordinal());
}

boolean sameCount(Card a, Card b, Card c) {
    /**
    * Checks if the given cards have the same count.
    * 
    * @param a the first card
    * @param b the second card
    * @param c the third card
    * @return {@code true} if all three cards have the same count, {@code false} otherwise
    */
    return allEqual(getCount(a), getCount(b), getCount(c));
}

boolean diffColor(Card a, Card b, Card c) {
    /**
    * Checks if the given cards have different colors.
    * 
    * @param a the first card
    * @param b the second card
    * @param c the third card
    * @return {@code true} if all three cards have different colors, {@code false} otherwise
    */
    return allDifferent(getColor(a).ordinal(), getColor(b).ordinal(), getColor(c).ordinal());
}

boolean diffShape(Card a, Card b, Card c) {
    /**
    * Checks if the given cards have different shapes.
    * 
    * @param a the first card
    * @param b the second card
    * @param c the third card
    * @return {@code true} if all three cards have different shapes, {@code false} otherwise
    */
    return allDifferent(getShape(a).ordinal(), getShape(b).ordinal(), getShape(c).ordinal());
}

boolean diffFill(Card a, Card b, Card c) {
    /**
    * Checks if the given cards have different fills.
    * 
    * @param a the first card
    * @param b the second card
    * @param c the third card
    * @return {@code true} if all three cards have different fills, {@code false} otherwise
    */
    return allDifferent(getFill(a).ordinal(), getFill(b).ordinal(), getFill(c).ordinal());
}

boolean diffCount(Card a, Card b, Card c) {
    /**
    * Checks if the given cards have different counts.
    * 
    * @param a the first card
    * @param b the second card
    * @param c the third card
    * @return {@code true} if all three cards have different counts, {@code false} otherwise
    */
    return allDifferent(getCount(a), getCount(b), getCount(c));
}  

boolean isSet(Card a, Card b, Card c) {
    /**
    * Determines if three given cards constitute a valid set. A set is valid if all the
    * properties are the same or all different for all three cards. This is true if the
    * following are all true:
    * 1. The colors are all the same or all different
    * 2. The shapes are all the same or all different
    * 3. The fills are all the same or all different
    * 4. The counts are all the same or all different
    *
    * @param a the first card
    * @param b the second card
    * @param c the third card
    * @return true if the cards constitute a valid set, false otherwise
    */
    return (
     (sameColor(a, b, c) || diffColor(a, b, c)) && 
     (sameShape(a, b, c) || diffShape(a, b, c)) &&
     (sameFill(a, b, c) || diffFill(a, b, c)) &&
     (sameCount(a, b, c) || diffCount(a, b, c))
   );
}

boolean allEqual(int one, int two, int three) {
    /**
    * Determines if three given integers are all equal.
    *
    * @param one the first integer
    * @param two the second integer
    * @param three the third integer
    * @return true if all integers are equal, false otherwise
    */
    return (one==two) && (one==three) && (two==three);
}

boolean allDifferent(int one, int two, int three) {
    /**
    * Determines if three given integers are all different.
    *
    * @param one the first integer
    * @param two the second integer
    * @param three the third integer
    * @return true if all integers are different, false otherwise
    */
    return (one!=two) && (one!=three) && (two!=three);
}

