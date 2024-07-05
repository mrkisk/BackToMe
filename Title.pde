class Title extends GameObject{
    // use titleImage, grassImage, blockImage
    float titleY, messageSize, rotateSpeed;
    PingPong pingPong;
    boolean showingRule, selectingMode;
    int selectedMenu, selectedMode;
    int UP, DOWN, SHOOT;
    
    Title() {
        super();
        titleY = 100;
        messageSize = 50;
        rotateSpeed = 0.04;
        pingPong = new PingPong(0, rotateSpeed);
        showingRule = false;
        selectingMode = false;
        selectedMenu = 0;
        selectedMode = 0;
        setParameter();
    }
    void setParameter() {
        UP = (int) parameters.get("Player1UP");
        DOWN = (int) parameters.get("Player1DOWN");
        SHOOT = (int) parameters.get("Player1SHOOT");
    }
    @Override
    void update() {
        pingPong.runUpdate();
        if (!showingRule && !selectingMode) {
            if (keyboardd[UP]) selectedMenu = 0;
            else if (keyboardd[DOWN]) selectedMenu = 1;
            else if (keyboardd[SHOOT]) {
                if (selectedMenu == 0) selectingMode = true;
                else if (selectedMenu == 1) showingRule = true;
                selectedMenu = 0;
            }
        } else if (showingRule) {
            if (keyboardd[SHOOT]) {
                showingRule = false;
                selectingMode = true;
            }
        } else if (selectingMode) {
            if (keyboardd[UP]) selectedMode = 0;
            else if (keyboardd[DOWN]) selectedMode = 1;
            else if (keyboardd[SHOOT]) {
                loadScene(1);
                game.setMode(selectedMode);
            }
        }
    }
    @Override
    void display() {
        displayMain();
        if (!showingRule && !selectingMode) {
            displayMenu();
        } else if (showingRule) {
            displayRule();
        } else if (selectingMode) {
            displayMode();
        }
    }
    void displayMain() {
        background(128, 255, 255);
        for (int i = 15; i < width; i += 30) {
            image(grassImage, i, 480 + 15);
            for (int j = 510 + 15; j < height; j+=30) {
                image(blockImage, i, j);
            }
        }
        image(titleImage, width / 2, titleY);
    }
    void displayMenu() {
        float upperMessageY = height / 2 - 60;
        float lowerMessageY = height / 2 + 40;
        textSize(messageSize);
        fill(0);
        text("START GAME", width / 2, upperMessageY);
        text("GAME RULE", width / 2, lowerMessageY);
        if (selectedMenu == 0) displayTriangle(width / 2 - 160, upperMessageY);
        else displayTriangle(width / 2 - 160, lowerMessageY);
        displayDescription();
    }
    void displayRule() {
        fill(0);
        text("GAME RULE", width / 2, height / 2 - 40);
    }
    void displayMode() {
        float upperMessageY = height / 2 - 60;
        float lowerMessageY = height / 2 + 40;
        textSize(messageSize);
        fill(0);
        text("STANDARD MODE", width / 2, upperMessageY);
        text("SPECIAL MODE", width / 2, lowerMessageY);
        if (selectedMode == 0) displayTriangle(width / 2 - 220, upperMessageY);
        else displayTriangle(width / 2 - 220, lowerMessageY);
        displayDescription();
    }
    void displayDescription() {
        textSize(messageSize / 2);
        fill(0);
        text("W,S : Move    Q : Select", width / 2, height / 2 + 125);
    }
    void displayTriangle(float x, float y) {
        fill(0, 0, 0, 0);
        strokeWeight(3);
        float widthTriangle = 25;
        float heightTriangle = 20 * sin(pingPong.get() * PI / 2);
        triangle(x, y, x - widthTriangle, y - heightTriangle, x - widthTriangle, y + heightTriangle);
        triangle(width - x, y, width - x + widthTriangle, y - heightTriangle, width - x + widthTriangle, y + heightTriangle);
        strokeWeight(1);
    }
}
