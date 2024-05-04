int estado = 1; 
int tiempoInicial; 
PImage imagen1, imagen2, imagen3, imagen4; 
String parrafo = "Dylan se está maquillando el tatuaje del juguito de su pómulo derecho antes de comenzar la producción de fotos para la tapa de Rolling Stone (la misma que el año pasado sugirió que nos la metamos en el orto en su tema “Ola de suicidios”, aunque enseguida nos confesó que es superfan de la revista y que aquello fue “una broma para picantear un poco el asunto”). Lo de taparse el tatuaje no lo hace por nada. El juguito es una marca indeleble de Dillom, ese joven con cara de nene travieso que en 2020 se coló en el auge de la escena urbana local con espíritu dark y mirada perdida. El nuevo personaje que Dylan viene construyendo desde que enterró, con cajón incluido, su etapa Post Mortem un año atrás, no tiene tatuaje de juguito en la cara.\n\nEl Dillom 2024 es como un punk inglés de los años 70 por fuera y una suerte de Norman Bates por dentro. De hecho, en un encuentro virtual con Dylan y su equipo creativo un mes antes de la producción fotográfica, con la excusa de contar por dónde venía la estética de su nuevo álbum (para esta nota, luego vendrían una escucha del disco junto al músico y su entorno más cercano, una extensa entrevista en su departamento y un último round en el set de fotos), la imagen de Ian Curtis, de Joy Division, aparecía como inspiración. “El tipo empieza así y después es como que va enloqueciendo a lo largo de la historia, del disco, hasta que termina superloco, medio creyéndose que es su propia madre”, dice Dylan un tanto dormido, desde el otro lado de la pantalla, en un horario poco rockero: lunes a las nueve de la mañana. “Me gusta aprovechar las mañanas… a veces”, dice y sonríe.";
ArrayList<ImagenAleatoria> imagenes;

void setup() {
  size(600, 900); 
  
  tiempoInicial = millis(); 
  
  imagen1 = loadImage("imagen1.jpg");
  imagen2 = loadImage("imagen2.jpg");
  imagen3 = loadImage("imagen3.jpg");
  imagen4 = loadImage("imagen4.jpg");
 
  imagenes = new ArrayList<ImagenAleatoria>();
}
void draw() {
  if (estado == 1) {
    estado1();
  } else if (estado == 2) {
    estado2();
  } else if (estado == 3) {
    estado3(); 
  }
  
}

void estado1() {
  background(255);
  rectMode(CENTER); 
  fill(0);
  rect(width/2, height/2, 200, 100); 

  textAlign(CENTER, CENTER); 
  fill(255);
  textSize(32);
  text("portada", width/2, height/2); 
}

void estado2() {
  background(255); 

  textAlign(CENTER, TOP); 
  fill(#FF0000);
  textSize(24);
  text("Dillom: Las confesiones de un psicópata (sud)americano", width/2, 50);
 
  if (millis() - tiempoInicial > 1000 && imagenes.size() < 4) {
    generarNoticiaAleatoria();
    tiempoInicial = millis(); 
  }
  for (int i = 0; i < imagenes.size(); i++) {
    ImagenAleatoria img = imagenes.get(i);
    img.mostrar();
  }
  
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(14); 
  text(parrafo, width/2, height/2, width - 100, height - 200);
}


void estado3() {
  background(255); 
  textAlign(CENTER, CENTER); 
  fill(0);
  textSize(32); 
  text("Estado Final (B)", width/2, height/2); 
}


void generarNoticiaAleatoria() {
  PImage[] imagenesDisponibles = {imagen1, imagen2, imagen3, imagen4}; 
  
  int numImagenesAGenerar = int(random(1, 3)); 

  for (int i = 0; i < numImagenesAGenerar; i++) {
    PImage noticiaAleatoria = imagenesDisponibles[int(random(imagenesDisponibles.length))];
  
    float posX = random(width);
    float posY = random(height);
    
    float escala = random(0.05, 0.2); 
    float anchoAleatorio = noticiaAleatoria.width * escala; 
    float altoAleatorio = noticiaAleatoria.height * escala; 
  
    imagenes.add(new ImagenAleatoria(posX, posY, noticiaAleatoria, anchoAleatorio, altoAleatorio));
  }
}


void keyPressed() {
  if (key == 'a') {
    if (estado == 1) {
      estado = 2; 
    } else if (estado == 3 && imagenes.size() > 0) {
      estado = 2;
    }
  } else if (key == 'd') {
    if (imagenes.size() > 1) {
      imagenes.remove(imagenes.size() - 1);
    } else if (imagenes.size() == 1) {
      imagenes.remove(0);
      estado = 3; 
    }
  }
}
