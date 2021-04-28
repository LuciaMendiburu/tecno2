Paleta paleta;

PImage Pinceladas[];
int cantidad = 32;



void setup() {
  size( 1200, 600 );
  imageMode( CENTER  );



  String estaObra= int(random(5)) + ".jpg" ;
  paleta = new Paleta( estaObra);  



  Pinceladas = new PImage[cantidad];
  for ( int i=0; i<cantidad; i++ ) {

    String nombre= nf(i, 2)+ ".png";
    Pinceladas[i] = loadImage(nombre);
  }

  background( 235,218,202 );
}
void draw() {
  int cual = int(random(cantidad));
  float posX = random( 50, width - 50 );
  float posY= random( 50, height - 50 );
  tint( paleta.darUnColor() );

  pushMatrix();

  translate (posX, posY);
  scale(random(0.1, 0.3));
  image(Pinceladas[cual], posX, posY);

  popMatrix();
}
