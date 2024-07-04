class Bullet {
    boolean active;
    float x, y, speed;
    int dir, playerId;
    float RADIUS, SPEED, ACCEL, POWER;
    Bullet(int playerId, float x, float y, int dir) {
        active = true;
        setParameters();
        this.playerId = playerId;
        this.x = x + dx4[dir] * RADIUS;
        this.y = y + dy4[dir] * RADIUS;
        this.dir = dir;
        speed = SPEED;
    }
    void setParameters() {
        RADIUS = (float) (float) parameters.get("BulletRadius");
        SPEED = (float) (float) parameters.get("BulletSpeed");
        ACCEL = (float) (float) parameters.get("BulletAccel");
        POWER = (float) (float) parameters.get("BulletPower");
    }
    void update() {
        if (!active) return;
        speed -= ACCEL;
        x += dx4[dir] * speed;
        y += dy4[dir] * speed;
        checkOutOfScreen();
    }
    void display() {
        if (!active) return;
        if (playerId == 0) {
            fill(0, 0, 0);
        } else {
            fill(0, 255, 0);
        }
        ellipse(x, y, RADIUS * 2, RADIUS * 2);
    }
    boolean isColliding(Player player) {
        if (!active) return false;
        float closestX = constrain(x, player.x - player.width_ / 2, player.x + player.width_ / 2);
        float closestY = constrain(y, player.y - player.height_ / 2, player.y + player.height_ / 2);
        return (x - closestX) * (x - closestX) + (y - closestY) * (y - closestY) < RADIUS * RADIUS;
    }
    void deactive() { active = false; }
    void checkOutOfScreen() {
        if (x < -width || x > width * 2 || y < -height || y > height * 2) {
            active = false;
        }
    }
}
