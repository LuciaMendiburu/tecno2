Paleta paleta;
//PosLienzo posLienzo;
PImage Pinceladas[];
int cantidad = 32;



void setup() {
  
  
 // posLienzo = new PosLienzo();
  
  size(1200,600);
  imageMode( CENTER  );



  String estaObra= int(random(1,4)) + ".jpg" ;
  paleta = new Paleta( estaObra);  
//tambien se podria hacer una imagen con todas las obras juntas para sacar la paleta de ahi, pero remplazaría a la logia del aleatorio


  Pinceladas = new PImage[cantidad];
  for ( int i=0; i<cantidad; i++ ) {

    String nombre= nf(i, 2)+ ".png";
    Pinceladas[i] = loadImage(nombre);
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
  // scale(random(0.1, 0.3));
  scale(random(0.1, 0.2));
  image(Pinceladas[cual], posX, posY);

  popMatrix();
}
