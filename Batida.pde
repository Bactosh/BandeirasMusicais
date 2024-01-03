class Batida {

  SoundFile[] som = new SoundFile[6];
  Amplitude amp[] = new Amplitude[som.length];
  BeatDetector beatDetect[] = new BeatDetector[som.length];
  boolean ligaSom;

  Batida() {
    for (int i=0; i<percursaoKeys.length/2; i++) {
      som[i] = new SoundFile(Bandeiras_Musicais_vb02_3.this, "batida_" + i + ".wav");
      amp[i] = new Amplitude(Bandeiras_Musicais_vb02_3.this);
      amp[i].input(som[i]);
      beatDetect[i] = new BeatDetector(Bandeiras_Musicais_vb02_3.this);
      beatDetect[i].input(som[i]);
      beatDetect[i].sensitivity(75);
    }
  }

  void keyPressed() {
    for (int i=0; i < percursaoKeys.length/2; i++) {
      if ( key == percursaoKeys[i] || key == percursaoKeys[i+6]) {
        if (!ligaSom) {
          if (i<7) {
            som[i].loop();
            som[i].amp(1.0);
          } else {
            som[i+6].loop();
            som[i].amp(1.0);
          }
        } else {
          if (i<7) {
            som[i].stop();
            som[i].amp(0.0);
          } else {
            som[i+6].stop();
            som[i].amp(0.0);
          }
        }
        ligaSom = !ligaSom;
      }
    }
  }
}
