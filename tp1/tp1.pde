/* Artista: Eduardo Vega de Seoane
Tecnología Multimedial 2 - Comisión Lisandro
Integrantes: Jaurena, Mendiburu, Parisi
*/

//PALETA DE COLORES:

Paleta paleta;
//PosLienzo posLienzo;
PImage Pinceladas[];
int cantidad = 32;

import oscP5.*; // importacion de libreria OSC

//=======================================
//variables de calibración del sonido

float minimoAmp = 45; 
float maximoAmp = 100; 

float minimoPitch = 46;
float maximoPitch = 96;

float f = 0.9;

boolean monitor = false;
//=======================================

OscP5 osc; // declaracion del objeto osc

float amp = 0.0;
float pitch = 0.0;

GestorSenial gestorAmp;
GestorSenial gestorPitch;


void setup() {
  size(1200, 600);
  imageMode( CENTER  );

  osc = new OscP5(this, 12345); // parametros: puntero a processing y puerto

  //inicialización
  //por defecto el rango es 0-100
  gestorAmp = new GestorSenial( minimoAmp, maximoAmp, f );
  gestorPitch = new GestorSenial( minimoPitch, maximoPitch, f );

  String estaObra= int(random(1, 4)) + ".jpg" ;
  paleta = new Paleta( estaObra);  
  //tambien se podria hacer una imagen con todas las obras juntas para sacar la paleta de ahi, pero remplazaría a la logica del aleatorio


  Pinceladas = new PImage[cantidad];
  for ( int i=0; i<cantidad; i++ ) {

    String nombre= nf(i, 2)+ ".png";
    Pinceladas[i] = loadImage(nombre);
    //tambien se podria hacer una imagen con todas las obras juntas para sacar la paleta de ahi, pero remplazaría a la logia del aleatorio
    //chequear si sacar las que estan texturizadas
  }

  background(paleta.darUnColorFondo() );
}
void draw() {

  int cual = int(random(cantidad));
  //float posX = random( 50, width - 50 );
  //float posY= random( 50, height - 50 );

  float posX = random(  width  );
  float posY= random( height );

  tint( paleta.darUnColor() );
  pushMatrix();
  translate (posX, posY);

  //ESCALA USANDO EL MOUSE:
  scale(map(mouseY, 0, height, 0.15, 0.35));

  /* ESCALA USANDO SONIDO:   
   scale(random(0.1, gestorAmp.filtradoNorm())/1.5);
   */

  //VELOCIDAD USANDO EL MOUSE:
  if (frameCount%int(map(mouseX, 0, width, 40, 2))==0) {
    image(Pinceladas[cual], posX, posY);
  }

  /* VELOCIDAD USANDO SONIDO:
   
   if (frameCount%int(map(gestorPitch.filtradoNorm(), 0, 1, 40, 2))==0) {
   image(Pinceladas[cual], posX, posY); 
   println(gestorPitch.filtradoNorm());
   }
   */
  popMatrix();

  //en cada fotograma hay que actualizar
  gestorAmp.actualizar( amp );
  gestorPitch.actualizar( pitch );

  if (monitor) {
    gestorAmp.imprimir( 150, 150 );
    gestorPitch.imprimir( 150, 350, 500, 100, false, true);
  }
}

void oscEvent( OscMessage m) { //Función para monitoriar sonido

  if (m.addrPattern().equals("/amp")) {
    amp = m.get(0).floatValue();
    //println("amp: " + gestorAmp.filtradoNorm());
  }

  if (m.addrPattern().equals("/pitch")) {
    pitch = m.get(0).floatValue();
    //println("pitch: " + pitch);
  }
}
