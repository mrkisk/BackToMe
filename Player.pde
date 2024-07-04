class Player {
    Game game;
    int id;
    int UP, DOWN, LEFT, RIGHT, SHOOT;
    float SPEED, JUMPSPEED, GRAVITY;
    float x, y;
    float vx, vy;
    float hp;
    int width_, height_;
    boolean onGround;
    Player(Game game, int id, float x, float y) {
        this.game = game;
        this.id = id;
        this.x = x;
        this.y = y;
        hp = 1;
        setParameter();
        width_ = playerImage[id][0].width;
        height_ = playerImage[id][0].height;
        onGround = false;
    }
    void setParameter() {
        UP = (int) parameters.get("Player" + (id + 1) + "UP");
        DOWN = (int) parameters.get("Player" + (id + 1) + "DOWN");
        LEFT = (int) parameters.get("Player" + (id + 1) + "LEFT");
        RIGHT = (int) parameters.get("Player" + (id + 1) + "RIGHT");
        SHOOT = (int) parameters.get("Player" + (id + 1) + "SHOOT");
        SPEED = (float) (float) parameters.get("Speed");
        JUMPSPEED = (float) (float) parameters.get("JumpSpeed");
        GRAVITY = (float) (float) parameters.get("Gravity");
    }
    void update() {
        setVelocity();
        setPosition();
        shoot();
    }
    void display() {
        int imageid = (vx == 0) ? 0 : onGround ? 1 : 2;
        translate(x, y);
        boolean flip = (vx < 0);
        if (flip) {
            pushMatrix();
            scale(-1, 1);
        }
        image(playerImage[id][imageid], 0, 0);
        if (flip) {
            popMatrix();
        }
        translate(-x, -y);
    }
    void setVelocity() {
        if (keyboard[LEFT] && !keyboard[RIGHT]) {
            vx = -SPEED;
        } else if (!keyboard[LEFT] && keyboard[RIGHT]) {
            vx = SPEED;
        } else {
            vx = 0;
        }
        if (keyboard[UP] && onGround) {
            onGround = false;
            vy = -JUMPSPEED;
        }
        if (!onGround) {
            vy += GRAVITY;
        }
    }
    void setPosition() {
        x += vx;
        y += vy;
        if (x < width_ / 2 || x > width - width_ / 2) {
            vx = 0;
        }
        x = constrain(x, width_ / 2, width - width_ / 2);
        if (y > GROUNDHEIGHT - height_ / 2) {
            y = GROUNDHEIGHT - height_ / 2;
            vy = 0;
            onGround = true;
        } else if (y < 0) {
            y = 0;
            vy = -3; // 後で修正
        }
    }
    void shoot() {
        int dir = -1;
        if (keyboard[LEFT] && !keyboard[UP] && !keyboard[RIGHT] && !keyboard[DOWN]) {
            dir = 0;
        } else if (!keyboard[LEFT] && keyboard[UP] && !keyboard[RIGHT] && !keyboard[DOWN]) {
            dir = 1;
        } else if (!keyboard[LEFT] && !keyboard[UP] && keyboard[RIGHT] && !keyboard[DOWN]) {
            dir = 2;
        } else if (!keyboard[LEFT] && !keyboard[UP] && !keyboard[RIGHT] && keyboard[DOWN]) {
            dir = 3;
        }
        if (dir != -1 && keyboardd[SHOOT]) {
            game.addBullet(id, x + width_ * dx4[dir] / 2, y + height_ * dy4[dir] / 2, dir);
        }
    }
    void damage(float power) {
        hp -= power;
        hp = hp < 0 ? 0 : hp;
    }
}
