public void togglePauseResume() {
    /**
    * Toggles between pausing and resuming the game.
    * If the game is currently paused, it will resume the game.
    * If the game is currently playing, it will pause the game.
    */
    if(state == State.PAUSED) {
        resumeGame();
} else {
        pauseGame();
}
}

public void pauseGame() {
    /**
    * Pauses the game by setting the game state to PAUSED and updating the * time elapsed
    * since the game started running.
    */
    state = State.PAUSED;
    timeElapsed += millis() - runningTimerStart;
    message = 9;
}

public void resumeGame() {
    /**
    * Resumes the game by setting the game state to PLAYING and updating the
    * timer start time to the current time.
    */
    state = State.PLAYING;
    runningTimerStart = millis();
    message = 10;
}

void showTimer() {
    /**
    * Displays the timer in the game interface using a specific font and fill color.
    * If the game is paused, the time elapsed is shown.
    * If the game is over, the time to complete is shown.
    * Otherwise, the time elapsed so far in the current game is shown.
    * @param none
    * @return void
    */
    textFont(timerFont);
    fill(TIMER_FILL);
    //If the game is paused, show time elapsed
    //If the game is over, show time to complete
    //Otherwise, show time elapsed so far in current game
    if(state == State.PAUSED) {
        text("Time: " + timeElapsed / 1000, TIMER_LEFT_OFFSET, TIMER_TOP_OFFSET);
    } else if (state == State.GAME_OVER) { 
            text("Time: " + (runningTimerEnd - runningTimerStart + timeElapsed) / 1000, TIMER_LEFT_OFFSET, TIMER_TOP_OFFSET);
    } else {
            text("Time: " + (millis() - runningTimerStart + timeElapsed) / 1000, TIMER_LEFT_OFFSET, TIMER_TOP_OFFSET);
    }
}

public int timerScore() {
    /**
    * Calculates the number of points scored based on the amount of time taken to complete
    * the game. The score is determined as the greater of the following two values:
    *
    * 1. 300 minus the number of seconds taken to complete the game
    * 2. 0
    *
    * For example, if the game was completed in 277 seconds, this method will return 23
    * because 300 - 277 = 23. If the game was completed in 435 seconds, this method will
    * return 0 because 435 is greater than 300.
    *
    * @return the number of points scored based on the amount of time taken to complete
    *         the game
    */
    return max(300 - (runningTimerEnd - runningTimerStart + timeElapsed) / 1000, 0);
}