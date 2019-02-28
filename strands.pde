class Strands {
    int strandNumber = 10;
    ArrayList<Strand> strandArr = new ArrayList<Strand>();
    ArrayList<Strand> hitStrands = new ArrayList<Strand>();
    int currentStrand;
    boolean isFlashing = false;
    int lastFlash = 0;
    int flashInterval = 3000;
    int flashDuration = 300;
    Song song;
    PApplet parent;

    Strands(PApplet theParent) {
        parent = theParent;
        int i = 0;
        while (i < strandNumber) {
            strandArr.add(new Strand(randomCurveCoordinates(), parent));
            i++;
        }

        song = new Song(parent, new ArrayList<float[]>());
    }

    void update() {
        int now = millis();

        // if is flashing and has been doing so for the last 2000ms, stop flashing
        if (isFlashing == true && now - lastFlash > flashDuration * strandNumber) {
            strand(currentStrand).deactivate();
            isFlashing = false;
            currentStrand = -1;
        }

        // if is not flashing and hasn't done so in 2000ms, start flashing
        if (isFlashing == false &&
            (now - lastFlash > flashInterval) &&
            (isFinished() == false)) {
            lastFlash = now;
            isFlashing = true;
            currentStrand = randomStrandIndex();
            strand(currentStrand).activate();
        }

    }

    void draw() {
        renderRemainingStrands();

        noFill();

        if (isFlashing && strandArr.size() > 0) {
            strand(currentStrand).draw();
        }

        for (Strand hitStrand : hitStrands) {
            hitStrand.draw();
        }

        song.play();
    }

    void renderRemainingStrands() {
        int i = 0;
        int len = strandArr.size();
        int width = 25;
        for (i = 0; i < len; i += 1) {
            noStroke();
            //stroke(255);
            fill(255, random(255), random(255));
            ellipse(i * (width + 10) + width, width + 10, width, width);
        }
    }

    void hit() {
        hitStrands.add(strand(currentStrand));
        strand(currentStrand).deactivate();
        song.addSheetToSheet(strand(currentStrand).sheet());
        strandArr.remove(currentStrand);
        strandNumber -= 1;
        currentStrand = -1;
        isFlashing = false;
    }

    int randomStrandIndex() {
        if (strandArr.size() < 1) {
            return -1;
        }

        return int(random(strandNumber));
    }

    Strand strand(int index) {
        if (index < 0) {
            return null;
        }
        return strandArr.get(index);
    }

    Strand hitStrand() {
        if (hitStrands.size() < 1) {
            return null;
        }
        int index = int(random(hitStrands.size()));
        return hitStrands.get(index);
    }



    float[] randomCurveCoordinates() {
        float[] coordinates = {
            random(width), random(height),
            random(width), random(height),
            random(width), random(height),
            random(width), random(height)
        };

        return coordinates;
    }

    boolean isFinished() {
        return strandArr.size() < 1;
    }

    void destroy() {
        song.pause();
    }

    void distortHitStrand(int amount) {
        Strand strand = hitStrand();

        if (strand == null) {
            return;
        }

        amount = random(10) > 6 ? amount * -1 : amount;

        strand.distort(amount);
    }

}
