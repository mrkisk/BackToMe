import java.util.HashMap;

HashMap<String, Object> parameters;

PImage[][] playerImage;
PImage block;
PImage grass;
PImage title;
// PFont fonta;
final int dx4[] = {-1, 0, 1, 0};
final int dy4[] = {0, -1, 0, 1};
final float GROUNDHEIGHT = 480;
Game game;

void setup() {
    size(720, 600);
    frameRate(60);
    imageMode(CENTER);
    setParameterGlobal("config.txt");
    loadImages();
    // fonta=loadFont("AngsanaNew-Bold-120.vlw");
    game = new Game();
}

void draw() {
    keyboardCheckOnDraw();
    game.update();
    game.display();
}
