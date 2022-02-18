// limits to 0.001 seconds
class Timer {
  int endTime;
  int milliseconds;
  
  public Timer(float seconds) {
    this.milliseconds = (int)(max(0.001f, seconds) * 1000);
    endTime = millis() + milliseconds;
  }
  
  
  void newRate(float seconds) {
    int newMilli = (int)(max(0.001f, seconds) * 1000);
    endTime = endTime + newMilli - milliseconds;
    milliseconds = newMilli;
  }
  
  boolean timeDone() {
    if (millis() > endTime) {
      endTime = millis() + milliseconds;
      return true;
    }
    
    return false;
  }
}
