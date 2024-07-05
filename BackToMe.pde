import java.util.HashMap;

HashMap<String, Object> parameters;

PImage[][] playerImage;
PImage blockImage;
PImage grassImage;
PImage titleImage;
// PFont fonta;
final int dx4[] = {-1, 0, 1, 0};
final int dy4[] = {0, -1, 0, 1};
final float GROUNDHEIGHT = 480;
Game game;
Title title;
int scene;

void setup() {
    size(720, 600);
    frameRate(60);
    imageMode(CENTER);
    textAlign(CENTER, CENTER);
    // textFont(createFont("MS Gothic", 32, true));
    setParameterGlobal("config.txt");
    loadImages();
    // fonta=loadFont("AngsanaNew-Bold-120.vlw");
    scene = 0;
    loadScene(scene);
}

void draw() {
    keyboardCheckOnDraw();
    if (scene == 0) {
        title.runUpdate();
        title.runDisplay();
    } else if (scene == 1) {
        game.runUpdate();
        game.runDisplay();
    }
}

void loadScene(int scene_) {
    scene = scene_;
    if (scene_ == 0) {
        title = new Title();
    }else if (scene_ == 1) {
        game = new Game();
    }
}
