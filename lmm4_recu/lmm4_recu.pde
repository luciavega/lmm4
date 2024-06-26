String estado = "PORTADA";
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);
  textSize(32);
  
  oscP5 = new OscP5(this, 7001); 
  myRemoteLocation = new NetAddress("127.0.0.1", 7000); 
}

void draw() {
  background(0); 
  fill(255); 
  text(estado, width / 2, height / 2); 
  
  OscMessage myMessage1 = new OscMessage("/composition/layers/1/clips/1/video/opacity");
  OscMessage myMessage2 = new OscMessage("/composition/layers/2/clips/1/video/opacity");
  OscMessage myMessage3 = new OscMessage("/composition/layers/3/clips/1/video/opacity");
  OscMessage myMessage4 = new OscMessage("/composition/layers/4/clips/1/video/opacity");
  OscMessage myMessage5 = new OscMessage("/composition/layers/5/clips/1/video/opacity");

  if (estado.equals("PORTADA")) {
    myMessage1.add(1.0); // 100% opacidad para capa 1
    myMessage2.add(0.0);
    myMessage3.add(0.0);
    myMessage4.add(0.0);
    myMessage5.add(0.0);
  } else if (estado.equals("ABIERTO1")) {
    myMessage1.add(0.0);
    myMessage2.add(1.0); // 100% opacidad para capa 2
    myMessage3.add(0.0);
    myMessage4.add(0.0);
    myMessage5.add(0.0);
  } else if (estado.equals("ABIERTO2")) {
    myMessage1.add(0.0);
    myMessage2.add(0.0);
    myMessage3.add(1.0); // 100% opacidad para capa 3
    myMessage4.add(0.0);
    myMessage5.add(0.0);
  } else if (estado.equals("ABIERTO3")) {
    myMessage1.add(0.0);
    myMessage2.add(0.0);
    myMessage3.add(0.0);
    myMessage4.add(1.0); // 100% opacidad para capa 4
    myMessage5.add(0.0);
  } else if (estado.equals("FINAL")) {
    myMessage1.add(0.0);
    myMessage2.add(0.0);
    myMessage3.add(0.0);
    myMessage4.add(0.0);
    myMessage5.add(1.0); // 100% opacidad para capa 5
  }
  
  oscP5.send(myMessage1, myRemoteLocation);
  oscP5.send(myMessage2, myRemoteLocation);
  oscP5.send(myMessage3, myRemoteLocation);
  oscP5.send(myMessage4, myRemoteLocation);
  oscP5.send(myMessage5, myRemoteLocation);
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
