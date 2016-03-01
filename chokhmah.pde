import processing.sound.*;

SinOsc sine;
int[] bezierLine = { 0,0, 100,100, 300,300, 400,400 };
float count;
int lastFlash = 0;
int lastHit = 0;
boolean isFlashing = false;
boolean hit = false;

void setup() {
    size(600, 600, P2D);
    background(0);

    count = 0;
    sine = new SinOsc(this);
    sine.amp(0);
    sine.play();
}

void draw() {
    background(0);
    count += 1;
    bezierLine[0] += random(100) > 50 ? 10 : -10;

    noFill();

    if (hit) {
        background(255);

        if (millis() - lastHit > 1000) {
            hit = false;
        }
    }

    if (isFlashing) {
        flash();
    }

    // if is flashing and has been doing so for the last 2000ms, stop flashing
    if (isFlashing == true && millis() - lastFlash > 200) {
        isFlashing = false;
    }

    // if is not flashing and hasn't done so in 2000ms, start flashing
    if (isFlashing == false && millis() - lastFlash > 2000) {
        lastFlash = millis();
        isFlashing = true;
    }


}

void keyReleased() {
    sine.amp(0);
}

void keyPressed() {
    background(255, random(255), random(255));
    sine.freq(keyCode * 5);
    sine.amp(0.5);

    if (isFlashing) {
        hit = true;
        lastHit = millis();
    }
}

void flash() {
    stroke(255);
    bezier(bezierLine[0], bezierLine[1], bezierLine[2], bezierLine[3],
           bezierLine[4], bezierLine[5], bezierLine[6], bezierLine[7]);

    bezier(bezierLine[1], bezierLine[0], bezierLine[6], bezierLine[7],
           width, bezierLine[5], bezierLine[3], bezierLine[2]);


}
