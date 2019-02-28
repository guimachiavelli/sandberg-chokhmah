import processing.sound.*;

SinOsc sine;
Strands knowledge;

boolean hit = false;
color bgColour = color(255);
int lastFinished = 0;

void setup() {
    fullScreen(P2D);
    //size(600, 600, P2D);
    pixelDensity(displayDensity());

    sine = new SinOsc(this);
    sine.amp(0);
    sine.play();

    knowledge = new Strands(this);
}

void draw() {
    background(bgColour);

    knowledge.update();
    knowledge.draw();

    if (knowledge.isFinished() && lastFinished == 0) {
        lastFinished = millis();
    }

    if ((millis() - lastFinished > 5000) && (knowledge.isFinished())) {
        setupRestart();
    }

    if ((millis() - lastFinished > 2000) && (knowledge.isFinished())) {
        restart();
    }
}

void setupRestart() {
    knowledge.destroy();
    background(bgColour);
}

void restart() {
    exit();
    knowledge = new Strands(this);
    lastFinished = 0;
}

void keyReleased() {
    sine.amp(0);
    bgColour = color(255);
    knowledge.distortHitStrand(keyCode);
}

void keyPressed() {
    bgColour = color(255, random(255), random(255));
    sine.freq(keyCode * 5);
    sine.amp(0.5);

    if (knowledge.isFlashing) {
        hit = true;
        bgColour = color(0);
        knowledge.hit();
    }

    knowledge.lastFlash = millis();
}
