import processing.video.*;
import processing.sound.*;

Batida batida;
Categoria verde, azul, amarelo;

Movie[] videos;

float smoothingFactor = 0.25;
float[] sum = new float[batida.som.length];
float[] amp_scaled = new float[batida.som.length];

PGraphics gPg, bPg, yPg;
PImage bMask, yMask;

color vCor, bCor, yCor;

char[] teclasVerde = {
  '0', '1', '2', '3', '4'
};
char[] teclasAzul = {
  '5', '6', '7', '8', '9'
};
char[] teclasAmarelo = {
  'a', 's', 'd', 'f', 'g'
};
char[] percursaoKeys = {
  'q', 'w', 'e', 'r', 't', 'y',
  'Q', 'W', 'E', 'R', 'T', 'Y'
};

void setup() {
  size(960, 540);
  videos = new Movie[15];

  batida = new Batida();

  vCor = #117621;
  bCor = #0000ee;
  yCor = #eeee00;

  gPg = createGraphics(width, height);
  bPg = createGraphics(width, height);
  yPg = createGraphics(width, height);

  for (int i = 0; i < 5; i++) {
    videos[i] = new Movie(this, "v_" + i + ".mov");
    videos[i+5] = new Movie(this, "b_" + i + ".mov");
    videos[i+10] = new Movie(this, "y_" + i + ".mov");
  }

  verde = new Categoria("verde", teclasVerde);
  azul = new Categoria("azul", teclasAzul);
  amarelo = new Categoria("amarelo", teclasAmarelo);
}

void draw() {
  for (int i=0; i < percursaoKeys.length/2; i++) {
    if (batida.beatDetect[i].isBeat()) {
      vCor = int(#+"11"+int(random(56, 76))+"21");
    } else {
      vCor = #117621;
    }
  }
  background(vCor);
  println("A cor é: "+vCor);
  verde.desenha();
  azul.desenha();
  amarelo.desenha();
}

void movieEvent(Movie m) {
  m.read();
}
void keyPressed() {
  verde.keyPressed();
  azul.keyPressed();
  amarelo.keyPressed();
  batida.keyPressed();
}
