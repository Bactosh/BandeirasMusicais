class Categoria {

  String nome;
  char[] teclas;
  boolean[] tocando;


  Categoria(String n, char[] t) {
    nome = n;
    teclas = t;
    tocando = new boolean[15];
    if (nome == "amarelo") {
      yPg.beginDraw();
      yPg.background(0);
      yPg.noStroke();
      yPg.fill(255);
      pushMatrix();
      yPg.ellipse(width*0.5, height*0.5, height*0.55, height*0.55);
      yMask = yPg.get();
      yPg.background(yCor);
      yPg.endDraw();
    } else if (nome == "azul") {
      bPg.beginDraw();
      bPg.background(0);
      bPg.noStroke();
      bPg.fill(255);
      bPg.quad(width*0.5, height*0.05, width*0.90, height*0.5,
        width*0.5, height*0.95, width*0.10, height*0.5
        );
      bMask = bPg.get();
      bPg.background(bCor);
      bPg.endDraw();
    }
  }

  void desenha() {
    for (int i = 0; i < 15; i++) {
      if (tocando[i] && nome == "amarelo") {
        yPg.beginDraw();
        //yPg.background(255,255,0);
        yPg.image(videos[i], 0, 0, width, height);
        yPg.endDraw();
        yPg.mask(yMask);
        pushMatrix();
        translate(width/2, height/2);
        for (int I=0; I<5; I++) {
          if (batida.beatDetect[I].isBeat()) {
            sum[I] += (batida.amp[I].analyze() - sum[I]) * smoothingFactor;
            amp_scaled[I] = sum[I] * (height/2) * 5;
            println(
              "amp: " + batida.amp[I].analyze() + "  |sum: " + sum[I]
              + "  |scaled: " + amp_scaled[I] );
            scale(batida.amp[I].analyze()*3);
          }
        }
        image(yPg, -width/2, -height/2, width, height);
        popMatrix();
      } else if (tocando[i] && nome == "azul") {
        bPg.beginDraw();
        bPg.image(videos[i], 0, 0, width, height);
        bPg.endDraw();
        bPg.mask(bMask);
        pushMatrix();
        translate(width/2, height/2);
        for (int I=0; I<5; I++) {
          if (batida.beatDetect[I].isBeat()) {
            sum[I] += (batida.amp[I].analyze() - sum[I]) * smoothingFactor;
            amp_scaled[I] = sum[I] * (height/2) * 5;
            println(
              "amp: " + batida.amp[I].analyze() + "  |sum: " + sum[I]
              + "  |scaled: " + amp_scaled[I] );
            translate(amp_scaled[I] * 0.05, 0);
            println("sum: " + sum[I]);
          }
        }
        image(bPg, -width/2, -height/2, width, height);
        popMatrix();
      } else if (tocando[i]) {
        image(videos[i], 0, 0, width, height);
      }
    }
  }

  void keyPressed() {
    for (int i = 0; i < 5; i++) {
      if (key == teclas[i] && nome == "verde") {
        if (!tocando[i]) {
          desabilitarAudio();
          videos[i].volume(1);
          videos[i].loop();
          println("On: " + nome + "_" + key);
        } else {
          videos[i].pause();
          println("Off: " + nome + "_" + key);
        }
        tocando[i] = !tocando[i];
      } else if (key == teclas[i] && nome == "azul") {
        if (!tocando[i+5] && i+5 > 4 && i+5 < 10) {
          desabilitarAudio();
          videos[i+5].volume(1);
          videos[i+5].loop();
          videos[i+5].play();
          println("On: " + nome + "_" + key);
        } else if ( i+5 > 4 && i+5 < 10 ) {
          videos[i+5].stop();
          println("Off: " + nome + "_" + key);
        }
        tocando[i+5] = !tocando[i+5];
      } else if (key == teclas[i] && nome == "amarelo") {
        if (!tocando[i+10]) {
          desabilitarAudio();
          videos[i+10].volume(1);
          videos[i+10].loop();
          videos[i+10].play();
          println("On: " + nome + "_" + key);
        } else {
          videos[i+10].stop();
          println("Off: " + nome + "_" + key);
        }
        tocando[i+10] = !tocando[i+10];
      }
    }
  }

  void desabilitarAudio() {
    for (int i = 0; i < 15; i++) {
      if (tocando[i]) {
        videos[i].volume(0);
      }
    }
  }
}
