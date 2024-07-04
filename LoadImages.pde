void loadImages() {
    playerImage = new PImage[2][3];
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            playerImage[i][j] = loadImage("players.png").get(j*24, i*35, 24, 35);
        }
    }
    grass = loadImage("grass.png");
    block = loadImage("block.png");
    title = loadImage("title.png");
}
