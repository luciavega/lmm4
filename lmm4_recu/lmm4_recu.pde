String estado = "PORTADA";

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);
  textSize(32);
  
}

void draw() {
  background(0); 
  fill(255); 
  text(estado, width / 2, height / 2); 
}

void keyPressed() {
  
  // cambio de estados con teclas d (adelante) y a (atras)
  if (key == 'D' || key == 'd') {
    if (estado.equals("PORTADA")) {
      estado = "ABIERTO1";
    } else if (estado.equals("ABIERTO1")) {
      estado = "ABIERTO2";
    } else if (estado.equals("ABIERTO2")) {
      estado = "ABIERTO3";
    } else if (estado.equals("ABIERTO3")) {
      estado = "ABIERTO4";
    } else if (estado.equals("ABIERTO4")) {
      estado = "FINAL";
    }
  } else if (key == 'A' || key == 'a') {
    if (estado.equals("ABIERTO1")) {
      estado = "PORTADA";
    } else if (estado.equals("ABIERTO2")) {
      estado = "ABIERTO1";
    } else if (estado.equals("ABIERTO3")) {
      estado = "ABIERTO2";
    } else if (estado.equals("ABIERTO4")) {
      estado = "ABIERTO3";
    } else if (estado.equals("FINAL")) {
      estado = "ABIERTO4";
    }
  }
}
