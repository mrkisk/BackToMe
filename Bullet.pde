class Bullet extends GameObject {
    float x, y, speed;
    int dir, playerId;
    float RADIUS, SPEED, ACCEL, POWER;
    Bullet(int playerId, float x, float y, int dir) {
        super();
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
    @Override
    void update() {
        speed -= ACCEL;
        x += dx4[dir] * speed;
        y += dy4[dir] * speed;
        checkOutOfScreen();
    }
    @Override
    void display() {
        if (playerId == 0) {
            fill(0, 0, 0);
        } else {
            fill(0, 255, 0);
        }
        ellipse(x, y, RADIUS * 2, RADIUS * 2);
    }
    boolean isColliding(Player player) {
        if (!getActive()) return false;
        float closestX = constrain(x, player.x - player.width_ / 2, player.x + player.width_ / 2);
        float closestY = constrain(y, player.y - player.height_ / 2, player.y + player.height_ / 2);
        return (x - closestX) * (x - closestX) + (y - closestY) * (y - closestY) < RADIUS * RADIUS;
    }
    boolean isCollidingBullet(Bullet bullet) {
        if (!getActive() || !bullet.getActive()) return false;
        return (x - bullet.x) * (x - bullet.x) + (y - bullet.y) * (y - bullet.y) < RADIUS * RADIUS * 4;
    }
    void checkOutOfScreen() {
        if (x < -width || x > width * 2 || y < -height || y > height * 2) {
            setActive(false);
        }
    }
}
