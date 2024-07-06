class HPBar extends GameObject{
    Player player;
    float x, y;
    float width_, height_;
    HPBar(Player player, float x, float y) {
        super();
        this.player = player;
        this.x = x;
        this.y = y;
        width_ = 220;
        height_ = 30;
    }
    @Override
    void update() {}
    @Override
    void display() {
        displayIcon();
        displayGauge();
    }
    void displayIcon() {
        float x_, y_;
        if (player.id == 0) {
            x_ = x - width_ / 2 - 30;
        } else {
            x_ = x + width_ / 2 + 30;
        }
        y_ = y;
        image(playerImage[player.id][0], x_, y_, height_ * 2, height_, 0, 0, player.width_, player.width_ / 2);
    }
    void displayGauge() {
        fill(255);
        rect(x - width_ / 2 - 1, y - height_ / 2 - 1, width_ + 2, height_ + 1);
        int colorRate = 5;
        if (player.hp > 0) {
            for (int i = 0; i < height_; i++) {
                if (player.hp > 0.5) {
                    stroke(i * colorRate, i * colorRate, 255);
                } else if (player.hp > 0.25) {
                    stroke(255 - i * colorRate, 255 - i * colorRate, 0);
                } else {
                    stroke(255 - i * colorRate, 0, 0);
                }
                line(x - width_ / 2, y - height_ / 2 + i, x - width_ / 2 + width_ * player.hp, y - height_ / 2 + i);
            }
        }
        stroke(0);
    }
}