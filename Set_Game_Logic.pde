boolean sameColor(Card a, Card b, Card c) {
    //YOU WRITE THIS
    return allEqual(getColor(a).ordinal(), getColor(b).ordinal(), getColor(c).ordinal());
}

boolean sameShape(Card a, Card b, Card c) {
    //YOU WRITE THIS
    return allEqual(getShape(a).ordinal(), getShape(b).ordinal(), getShape(c).ordinal());
}

boolean sameFill(Card a, Card b, Card c) {
    //YOU WRITE THIS
    return allEqual(getFill(a).ordinal(), getFill(b).ordinal(), getFill(c).ordinal());
}

boolean sameCount(Card a, Card b, Card c) {
    //YOU WRITE THIS
    return allEqual(getCount(a), getCount(b), getCount(c));
}

boolean diffColor(Card a, Card b, Card c) {
    //YOU WRITE THIS
    return allDifferent(getColor(a).ordinal(), getColor(b).ordinal(), getColor(c).ordinal());
}

boolean diffShape(Card a, Card b, Card c) {
    //YOU WRITE THIS
    return allDifferent(getShape(a).ordinal(), getShape(b).ordinal(), getShape(c).ordinal());
}

boolean diffFill(Card a, Card b, Card c) {
    //YOU WRITE THIS
    return allDifferent(getFill(a).ordinal(), getFill(b).ordinal(), getFill(c).ordinal());
}

boolean diffCount(Card a, Card b, Card c) {
    //YOU WRITE THIS
    return allDifferent(getCount(a), getCount(b), getCount(c));
}  

boolean isSet(Card a, Card b, Card c) {
    /** 
    * A set is valid if all the properties are the same or all different
    * for all three cards.  This is true if the following are all true:
    * 1.  The colors are all the same or all different
    * 2.  The shapes are all the same or all different
    * 3.  The fills are all the same or all different
    * 4.  The counts are all the same or all different

    @param a  The first card
    @param b  The second card
    @param c  The third card
    @return boolean true if the cards constitute a set, false otherwise
    */
    return (
     (sameColor(a, b, c) || diffColor(a, b, c)) && 
     (sameShape(a, b, c) || diffShape(a, b, c)) &&
     (sameFill(a, b, c) || diffFill(a, b, c)) &&
     (sameCount(a, b, c) || diffCount(a, b, c))
   );
}

boolean allEqual(int one, int two, int three) {
    return (one==two) && (one==three) && (two==three);
}

boolean allDifferent(int one, int two, int three) {
    return (one!=two) && (one!=three) && (two!=three);
}

