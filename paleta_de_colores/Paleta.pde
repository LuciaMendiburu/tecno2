class Paleta {

  PImage imagen;
  int posX, posY;

  Paleta (String nombreArchivo) {

    imagen = loadImage(nombreArchivo);
  }

  color darUnColor() {

    posX = int(random(imagen.width));
    posY = int(random(imagen.height));
    return imagen.get(posX, posY);
  }
}
