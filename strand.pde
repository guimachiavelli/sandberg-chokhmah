class Strand {
    SinOsc voice;
    PApplet parent;
    float[] coordinates;
    boolean isActive = false;
    Song song;

    int currentNote = 0;
    int currentDuration = 0;

    Strand(float[] bezierLine, PApplet theParent) {
        coordinates = bezierLine;
        parent = theParent;
        voice = new SinOsc(parent);
        voice.amp(0);
        voice.play();

        song = new Song(parent);
    }

    void update() {

    }

    void draw() {
        //background(255, coordinates[0], coordinates[1]);
        stroke(255, random(255), random(255));
        bezier(coordinates[0], coordinates[1],
               coordinates[2], coordinates[3],
               coordinates[4], coordinates[5],
               coordinates[6], coordinates[7]
        );

        if (isActive) {
            song.play();
        }
    }

    ArrayList<float[]> sheet() {
        return song.sheet;
    }

    void activate() {
        isActive = true;
    }

    void deactivate() {
        isActive = false;
        song.pause();
    }

    void distort(int amount) {
        int index = int(random(coordinates.length));
        coordinates[index] += amount;

    }

}
