void loadImages() {
    playerImage = new PImage[2][3];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            playerImage[i][j] = loadImage("players.png").get(j*24, i*35, 24, 35);
        }
    }
    grassImage = loadImage("grass.png");
    blockImage = loadImage("block.png");
    titleImage = loadImage("title.png");
    ruleImage = loadImage("rule.png");
}
