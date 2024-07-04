class PingPong extends GameObject {
    float value;
    float speed;
    boolean increasing;
    PingPong(float initialValue, float speed) {
        super();
        this.value = initialValue;
        this.speed = speed;
        this.increasing = true;
    }
    @Override
    void update() {
        if (increasing) {
            value += speed;
            if (value >= 1) {
                value = 2 - value;
                increasing = false;
            }
        } else {
            value -= speed;
            if (value <= 0) {
                value = -value;
                increasing = true;
            }
        }
    }
    @Override
    void display() {
    }
    float get() {
        return value;
    }
}

class Timer extends GameObject {
    int time, maxTime;
    Timer(int time) {
        super();
        this.time = time;
        this.maxTime = time;
    }
    @Override
    void update() {
        time--;
    }
    @Override
    void display() {
    }
    boolean isFinished() { return time <= 0; }
    int getTime() { return time; }
    void reset() { time = maxTime; }
    int getMaxTime() { return maxTime; }
}
