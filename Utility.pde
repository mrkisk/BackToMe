class PingPong extends GameObject {
    float value;
    float speed;
    boolean increasing;
    PingPong(float initialValue, float speed) {
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
