class Game {
    int scene;
    Player[] players;
    HPBar[] hpBars;
    ArrayList<Bullet> bullets;
    Game() {
        init();
        initScene1();
    }
    void init() {
        scene = 0;
        players = null;
        hpBars = null;
        bullets = null;
    }
    void initScene1() {
        players = new Player[] {
            new Player(this, 0, 50, 130),
            new Player(this, 1, width - 50, 130)
        };
        hpBars = new HPBar[] {
            new HPBar(players[0], 210, 540),
            new HPBar(players[1], width - 210, 540)
        };
        bullets = new ArrayList<Bullet>();
    }
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
    void display() {
        displayStage();
        for (Player player : players) player.display();
        for (HPBar hpBar : hpBars) hpBar.display();
        for (Bullet bullet : bullets) bullet.display();
    }
    void displayStage() {
        background(128, 255, 255);
        for (int i = 15; i < width; i += 30) {
            image(grass, i, 480 + 15);
            for (int j = 510 + 15; j < height; j+=30) {
                image(block, i, j);
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