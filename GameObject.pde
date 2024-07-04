abstract class GameObject {
    boolean active, doUpdate, doDisplay;
    GameObject() {
        active = true;
        doUpdate = true;
        doDisplay = true;
    }
    abstract void update();
    abstract void display();
    void setActive(boolean active) { this.active = active; }
    boolean getActive() { return active; }
    void setDoUpdate(boolean doUpdate) { this.doUpdate = doUpdate; }
    void setDoDisplay(boolean doDisplay) { this.doDisplay = doDisplay; }
    boolean getDoUpdate() { return doUpdate; }
    boolean getDoDisplay() { return doDisplay; }
    void runUpdate() { if (active && doUpdate) update(); }
    void runDisplay() { if (active && doDisplay) display(); }
}
