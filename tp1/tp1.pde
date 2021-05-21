/* Artista: Eduardo Vega de Seoane
 Tecnología Multimedial 2 - Comisión Lisandro
 Integrantes: Jaurena, Mendiburu, Parisi
 */

//PALETA DE COLORES:

Paleta paleta;
int aleatorio;
int opacidad1 ;
int opacidad3;
int aparecer1;
int aparecer3;

//lineas
PGraphics capa1;


//formas
PGraphics capa3;


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
  capa1 = createGraphics(1200, 600);

  capa3 = createGraphics(1200, 600);

  imageMode( CENTER  );
  opacidad1 = 255;
  opacidad3 = 255;
  
  // 900 porque si en 1s se imprimen 30img,en 30s, se imprimen 900, osea que si por segundo se le resta un valor, tardaria 30s en desaparecer si no se interactua
  aparecer1 = 900;
  aparecer3 = 900;
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

  aleatorio = round(random(100));



//si el mouse esta en la parte de arriba de la pantalla, se imprimela capa 1, si esta abajo, se imprime la 3 
if(mouseY>height/2){
  
      capa1();
    
  
}else if(mouseY<height/2){
    
     capa3();
    // capa1.blendMode(  SUBTRACT  );
}

// a la izquierda, disminuye la opacidad de la capa1, a la derecha, aumenta la opacidad de la capa1

if(mouseX<width/2){

  opacidad1 = opacidad1 - 1;
    

}else if(mouseX>height/2){
  
  
  opacidad1 = opacidad1 + 1;
  
  
  
}

// a la izquierda, disminuye la opacidad de la capa3, a la derecha, aumenta la opacidad de la capa3

if(mouseX<width/2){

  opacidad3 = opacidad3 - 1;


}else if(mouseX>height/2){
  
  
  opacidad3 = opacidad3 + 1;
  
  
  
}






  
  

  
  
  
  
  
  
  
}



void capa1(){




  capa1.beginDraw();
 // capa3.blendMode(ADD);
  int cual = int(random(cantidad));
  float posX = random(  width  );
  float posY= random( height );

 // tint( paleta.darUnColor() );
tint(0,255,0, opacidad1);

  pushMatrix();

  translate (posX, posY);

  //ESCALA USANDO EL MOUSE:
  scale(map(mouseY, 0, height, 0.15, 0.35));

  //VELOCIDAD USANDO EL MOUSE:
  // el && cual%2 == 0, es el que evalua si es numero es par o no, osea, si son lineas o manchas
  if (frameCount%int(map(mouseX, 0, width, 40, 2))==0 && cual%2 != 0 ) {
    image(Pinceladas[cual], posX, posY);
  }


  popMatrix();


  capa1.endDraw();
  
  




}

void capa3(){



    capa3.beginDraw();
 //  capa3.blendMode(MULTIPLY );
  int cual3 = int(random(cantidad));
  float posX3 = random(  width  );
  float posY3= random( height );

 // tint( paleta.darUnColor() );
tint(255,0,0, opacidad3);

  pushMatrix();

  translate (posX3, posY3);

  //ESCALA USANDO EL MOUSE:
  scale(map(mouseY, 0, height, 0.15, 0.35));

  //VELOCIDAD USANDO EL MOUSE:
  // el && cual%2 == 0, es el que evalua si es numero es par o no, osea, si son lineas o manchas
  if (frameCount%int(map(mouseX, 0, width, 40, 2))==0 && cual3%2 == 0 ) {
    image(Pinceladas[cual3], posX3, posY3);
  }


  popMatrix();


  capa3.endDraw();









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
