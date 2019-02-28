import java.util.Collections;

class Song {
    SinOsc voice;
    ArrayList<float[]> sheet;
    int currentNote = 0;
    int currentDuration = 0;
    float[] notes2 = { 65.406, 69.296, 69.296, 73.416, 77.782, 77.782, 82.407,
                      116.541, 116.541, 123.471
                    };
    float[] notes3 = { 130.813, 138.591, 138.591, 146.832, 155.563, 155.563,
                       207.652, 220, 233.082, 233.082, 246.942
                     };
    float[][] notes = { notes2, notes3 };


    Song(PApplet parent) {
        sheet = generatedSheet();
        voice = new SinOsc(parent);
        voice.amp(0);
        voice.play();
    }

    Song(PApplet parent, ArrayList<float[]> theSheet) {
        sheet = theSheet;
        voice = new SinOsc(parent);
        voice.amp(0);
        voice.play();
    }

    void addSheetToSheet(ArrayList<float[]> anotherSheet) {
        sheet.addAll(anotherSheet);
        Collections.shuffle(sheet);
    }

    ArrayList<float[]> generatedSheet() {
        int sheetLength = int(random(15)) + 2;
        int i = 0;
        ArrayList<float[]> newSheet;
        float duration = random(25)/1000;
        float amp = int(random(150) * 1.5);

        newSheet = new ArrayList<float[]>();
        while (i < sheetLength - 1) {
            float[] note = {
                amp,
                randomNote(),
                duration
            };
            newSheet.add(note);
            i += 1;
        }

        return newSheet;
    }

    float randomNote() {
        float[] octave = notes[int(random(notes.length))];
        int numberOfNotes = octave.length;
        return octave[int(random(numberOfNotes))];
    }

    void play() {
        if (sheet.size() < 1) {
            return;
        }

        int now = millis();
        float[] note = sheet.get(currentNote);

        if (now - currentDuration > note[0]) {
            currentDuration = now;
            currentNote += 1;

            if (currentNote >= sheet.size() - 1) {
                currentNote = 0;
            }
        }

        voice.freq(note[1]);
        voice.amp(0.25);
    }

    void pause() {
        voice.amp(0);
    }

    void stop() {
        voice.stop();
    }
}
