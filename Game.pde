class Game extends GameObject {
    // use grassImage, blockImage
    int mode;
    int RETRY, TITLE;
    float messageSize, messageY;
    Player[] players;
    HPBar[] hpBars;
    ArrayList<Bullet> bullets;
    Timer[] timers;
    int winner, phase;
    Game() {
        super();
        RETRY = (int) parameters.get("RETRY");
        TITLE = (int) parameters.get("TITLE");
        messageSize = 100;
        messageY = height / 2 - 40;
        init();
    }
    void init() {
        players = new Player[] {
            new Player(this, 0, 0, 50, 130),
            new Player(this, 1, 0, width - 50, 130)
        };
        hpBars = new HPBar[] {
            new HPBar(players[0], 210, 540),
            new HPBar(players[1], width - 210, 540)
        };
        bullets = new ArrayList<Bullet>();
        stop();
        timers = new Timer[] {
            new Timer(120),
            new Timer(30),
            new Timer(45),
            new Timer(15)
        };
        for (int i = 1; i < timers.length; i++) timers[i].setActive(false);
        winner = -1;
        phase = 0;
    }
    void setMode(int mode) {
        this.mode = mode;
        for (Player player : players) player.setMode(mode);
    }
    void stop() {
        for (Player player : players) player.setDoUpdate(false);
        for (HPBar hpBar : hpBars) hpBar.setDoUpdate(false);
        for (Bullet bullet : bullets) bullet.setDoUpdate(false);
    }
    @Override
    void update() {
        setPhase();
        for (Timer timer : timers) timer.runUpdate();
        for (Player player : players) player.runUpdate();
        for (HPBar hpBar : hpBars) hpBar.runUpdate();
        for (Bullet bullet : bullets) bullet.runUpdate();
        checkCollision();
        removeInactiveBullets();
    }
    @Override
    void display() {
        displayStage();
        for (Player player : players) player.runDisplay();
        for (HPBar hpBar : hpBars) hpBar.runDisplay();
        for (Bullet bullet : bullets) bullet.runDisplay();
        displayOnPhase();
    }
    void setPhase() {
        if (!timers[0].isFinished()) {
            phase = 0;
        } else if (!timers[1].isFinished()) {
            timers[1].setActive(true);
            for (Player player : players) player.setDoUpdate(true);
            phase = 1;
        } else if (winner == -1) {
            phase = 2;
        } else if  (!timers[2].isFinished()) {
            timers[2].setActive(true);
            for (Player player : players) player.setDoUpdate(false);
            for (HPBar hpBar : hpBars) hpBar.setDoUpdate(false);
            for (Bullet bullet : bullets) bullet.setDoUpdate(false);
            phase = 3;
        } else {
            timers[3].setActive(true);
            phase = 4;
            if (keyboardd[RETRY]) loadScene(1);
            else if (keyboardd[TITLE]) loadScene(0);
        }
    }
    void addBullet(int playerId, float x, float y, int dir) {
        bullets.add(new Bullet(playerId, x, y, dir));
    }
    void removeInactiveBullets() {
        for (int i = bullets.size() - 1; i >= 0; i--) {
            if (!bullets.get(i).getActive()) {
                bullets.remove(i);
            }
        }
    }
    void checkCollision() {
        for (Bullet bullet : bullets) {
            for (Bullet bullet_ : bullets) {
                if (bullet != bullet_ && bullet.playerId != bullet_.playerId && bullet.isCollidingBullet(bullet_)) {
                    bullet.setActive(false);
                    bullet_.setActive(false);
                }
            }
            for (Player player : players) {
                if (bullet.isColliding(player)) {
                    player.damage(bullet.POWER);
                    bullet.setActive(false);
                }
            }
        }
    }
    void setWinner(int playerId) {
        winner = (winner == -1) ? playerId : (winner == 1 - playerId) ? 2 : winner;
    }
    void displayStage() {
        background(128, 255, 255);
        for (int i = 15; i < width; i += 30) {
            image(grassImage, i, 480 + 15);
            for (int j = 510 + 15; j < height; j+=30) {
                image(blockImage, i, j);
            }
        }
    }
    void displayOnPhase() {
        if (phase == 0) {
            displayBlack();
            textSize(messageSize);
            fill(255, 0, 0);
            text("READY", width / 2, messageY);
        } else if (phase == 1) {
            textSize(messageSize);
            fill(255, 0, 0);
            text("GO", width / 2, messageY);
        } else if (phase == 2) {
        } else if (phase == 3) {
            displayBlack();
        } else if (phase == 4) {
            displayBlack();
            textSize(messageSize * (timers[3].getMaxTime() - timers[3].getTime()) / timers[3].getMaxTime());
            fill(255, 0, 0);
            String winnerText = (winner == 2) ? "DRAW" : ("PLAYER " + (winner + 1) + " WINS");
            text(winnerText, width / 2, messageY);
            if (timers[3].isFinished()) {
                textSize(messageSize / 3);
                text("R : Retry    T : Title", width / 2, messageY + 80);
            }
        }
    }
    void displayBlack() {
        fill(0, 0, 0, 100);
        noStroke();
        rect(0, 0, width, height);
        stroke(0);
    }
}
