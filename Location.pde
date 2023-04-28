/**
 * The Location class represents a 2D point in a grid.
 * It implements the Comparable interface to allow for sorting.
 */
public class Location implements Comparable<Location> {

    /** The column index of the Location */
    private int col;
    
    /** The row index of the Location */
    private int row;
    
    /**
     * Creates a new Location object with the given column and row indices.
     * @param col The column index of the Location.
     * @param row The row index of the Location.
     */
    public Location(int col, int row) {
        this.col = col;
        this.row = row;
    }
    
    /**
     * Sets the column index of the Location.
     * @param col The new column index of the Location.
     */
    public void setCol(int col) {
        this.col = col;
    }
    
    /**
     * Sets the row index of the Location.
     * @param row The new row index of the Location.
     */
    public void setRow(int row) {
        this.row = row;
    }
    
    /**
     * Returns the column index of the Location.
     * @return The column index of the Location.
     */
    public int getCol() {
        return col;
    }
    
    /**
     * Returns the row index of the Location.
     * @return The row index of the Location.
     */
    public int getRow() {
        return row;
    }
    
    /**
     * Returns the linear index of the Location based on a 3x3 grid layout.
     * @return The linear index of the Location.
     */
    public int getIndex() {
        return 3 * col + row;
    }
    
    /**
     * Compares this Location to another Location.
     * @param other The other Location to compare to.
     * @return An int value indicating the comparison result.
     *         Returns a negative value if this Location is less than the other,
     *         zero if they are equal, and a positive value if this Location is greater than the other.
     */
    public int compareTo(Location other) {
        return getIndex() - other.getIndex();
    }
    
    /**
     * Returns a String representation of the Location in the format "[col,row]".
     * @return The String representation of the Location.
     */
    public String toString() {
        return "[" + col + "," + row + "]";
    }
    
    /**
     * Determines whether this Location is equal to another Location.
     * @param other The other Location to compare to.
     * @return true if the Locations have the same column and row indices, false otherwise.
     */
    public boolean equals(Location other) {
        return col == other.getCol() && row == other.getRow();
    }
}
