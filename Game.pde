class Game extends GameObject {
    // use grassImage, blockImage
    int mode;
    Player[] players;
    HPBar[] hpBars;
    ArrayList<Bullet> bullets;
    Game() {
        // this.mode = mode;
        init();
        initScene1();
    }
    void init() {
        players = null;
        hpBars = null;
        bullets = null;
    }
    void initScene1() {
        players = new Player[] {
            new Player(this, 0, mode, 50, 130),
            new Player(this, 1, mode, width - 50, 130)
        };
        hpBars = new HPBar[] {
            new HPBar(players[0], 210, 540),
            new HPBar(players[1], width - 210, 540)
        };
        bullets = new ArrayList<Bullet>();
    }
    @Override
    void update() {
        for (Player player : players) player.update();
        for (HPBar hpBar : hpBars) hpBar.update();
        for (Bullet bullet : bullets) bullet.update();
        for (Bullet bullet : bullets) {
            for (Player player : players) {
                if (bullet.isColliding(player)) {
                    player.damage(bullet.POWER);
                    bullet.deactive();
                }
            }
        }
        removeInactiveBullets();
    }
    @Override
    void display() {
        displayStage();
        for (Player player : players) player.display();
        for (HPBar hpBar : hpBars) hpBar.display();
        for (Bullet bullet : bullets) bullet.display();
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
    void addBullet(int playerId, float x, float y, int dir) {
        bullets.add(new Bullet(playerId, x, y, dir));
    }
    void removeInactiveBullets() {
        for (int i = bullets.size() - 1; i >= 0; i--) {
            if (!bullets.get(i).active) {
                bullets.remove(i);
            }
        }
    }
}