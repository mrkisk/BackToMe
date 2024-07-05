class Player extends GameObject {
    // use playerImage
    Game game;
    int id, mode;
    int UP, DOWN, LEFT, RIGHT, SHOOT;
    float SPEED, JUMPSPEED, GRAVITY, SPECIALJUMPRATE, SPECIALDAMAGE;
    float x, y, vx, vy, hp;
    int width_, height_;
    boolean onGround;
    Player(Game game, int id, int mode, float x, float y) {
        super();
        this.game = game;
        this.id = id;
        this.mode = mode;
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
        SPECIALJUMPRATE = (float) (float) parameters.get("SpecialJumpRate");
        SPECIALDAMAGE = (float) (float) parameters.get("SpecialDamage");
    }
    @Override
    void update() {
        setVelocity();
        setPosition();
        specialDamage();
        shoot();
    }
    @Override
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
    void setMode(int mode) {
        this.mode = mode;
    }
    void setVelocity() {
        if (mode == 0) {
            setVelocityMode0();
        } else if (mode == 1) {
            setVelocityMode1();
        }
    }
    void setVelocityMode0() {
        if (!onGround) {
            vy += GRAVITY;
        }
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
    }
    void setVelocityMode1() {
        if (!onGround) {
            vy += GRAVITY;
        }
        if (keyboard[LEFT] && !keyboard[RIGHT]) {
            vx = -SPEED;
        } else if (!keyboard[LEFT] && keyboard[RIGHT]) {
            vx = SPEED;
        } else {
            vx = 0;
        }
        if (keyboard[UP]) {
            onGround = false;
            vy -= JUMPSPEED * SPECIALJUMPRATE;
        }
        if (vy < -JUMPSPEED) {
            vy = -JUMPSPEED;
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
        } else if (y < height_ / 2) {
            y = height_ / 2;
            vy = 3; // 後で修正
        }
    }
    void specialDamage() {
        if (mode == 1 && onGround) {
            damage(SPECIALDAMAGE);
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
        if (hp < 0) {
            hp = 0;
            game.setWinner(1 - id);
        }
    }
}
