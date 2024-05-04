class ImagenAleatoria {
  float x, y;
  PImage imagen;
  float ancho, alto;
  
  ImagenAleatoria(float x, float y, PImage imagen, float ancho, float alto) {
    this.x = x;
    this.y = y;
    this.imagen = imagen;
    this.ancho = ancho;
    this.alto = alto;
  }
  
  void mostrar() {
    imageMode(CENTER);
    image(imagen, x, y, ancho, alto);
  }
}
