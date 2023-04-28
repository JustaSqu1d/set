/**
 * This method handles the key press events for the game.
 * 
 * @param none
 * @return void
 */
public void keyPressed() {
    if(key == ENTER || key == RETURN) {
        newGame();
        return;
    }
    
    if(state == State.GAME_OVER) return;
    
    if(key == ' ') {
        togglePauseResume();
        return;
    }
    
    //No fair playing with timer paused
    if(state != State.PLAYING) return;
    
    String legal = "QWERTYUASDFGHJZXCVVBNMqwertyuasdfghjzxcvbnm+=-_Pp ";
    
    // If the key is not a legal key, display a message and return
    if(legal.indexOf(key) < 0) {
        message = 8;
        return;
    }
    
    // Handle the special keys
    if("+=-_ ".indexOf(key) >= 0) {
        switch(key) {
            case ' ' : togglePauseResume(); break;
            case '=':
            case '+' : grid.addColumn(); break;
            case '_':
            case '-' : state = State.FIND_SET; highlightCounter = 0; break;
            default : break;
        }
        return;
    }
    
    // Calculate the column and row based on the key pressed
    int col = "qazQAZ".indexOf(key) >= 0 ? 0 :
        "wsxWSX".indexOf(key) >= 0 ? 1 :
        "edcEDC".indexOf(key) >= 0 ? 2 :
        "rfvRFV".indexOf(key) >= 0 ? 3 :
        "tgbTGB".indexOf(key) >= 0 ? 4 :
        "yhnYHN".indexOf(key) >= 0 ? 5 :
        "ujmUJM".indexOf(key) >= 0 ? 6 : 7;
    int row = "qwertyuQWERTYU".indexOf(key) >= 0 ? 0 :
        "asdfghjASDFGHJ".indexOf(key) >= 0 ? 1 : 2;
    
    // Update the selected card based on the column and row
    if(col < currentCols) {
        grid.updateSelected(col, row);
    } else {
        message = 8;
    }
}
