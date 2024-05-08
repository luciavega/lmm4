import netP5.*;
import oscP5.*;

float xPos = 0f;
float yPos = 0f;

OscP5 oscP5;
NetAddress myRemoteLocation;

int clip2Opacity = 255;
int clip3Opacity = 0;
int opacityChange = 10; // Cambio en la opacidad al mover el mouse

void setup() {
  size(400, 400);
  frameRate(25);

  oscP5 = new OscP5(this, 7001);
  myRemoteLocation = new NetAddress("127.0.0.1", 7000);
}

void draw() {
  background(0);
  text("This small example will set layer 1 position X and Y", 20, 20);
  text(" based on where you move the mouse in this window.", 20, 40);
  text("mouse xPos : " + xPos + "   yPos : " + yPos, 20, 60);
  ellipse(mouseX, mouseY, 7, 7);
  
  // Update the opacity of clips based on mouse movement
  if (mouseY < pmouseY) { // Mouse moving up
    clip2Opacity += opacityChange;
    clip3Opacity -= opacityChange;
  } else if (mouseY > pmouseY) { // Mouse moving down
    clip2Opacity -= opacityChange;
    clip3Opacity += opacityChange;
  }
  
  // Ensure opacity values stay within valid range
  clip2Opacity = constrain(clip2Opacity, 0, 255);
  clip3Opacity = constrain(clip3Opacity, 0, 255);
  
  // Send OSC messages for opacity changes
  OscBundle myBundle = new OscBundle();
  OscMessage clip2OpacityMessage = new OscMessage("/composition/layers/2/video/opacity");
  clip2OpacityMessage.add("f"); // "f" for float value
  clip2OpacityMessage.add((float)clip2Opacity / 255.0); // Normalize opacity to range [0, 1]
  myBundle.add(clip2OpacityMessage);

  OscMessage clip3OpacityMessage = new OscMessage("/composition/layers/3/video/opacity");
  clip3OpacityMessage.add("f");
  clip3OpacityMessage.add((float)clip3Opacity / 255.0);
  myBundle.add(clip3OpacityMessage);

  oscP5.send(myBundle, myRemoteLocation);
}

void mouseMoved() {
  xPos = mouseX - (width / 2);
  yPos = mouseY - (height / 2);
}

void keyPressed() {
  if (key == 'a') {
    // Set opacity of clips 2 and 3 to maximum
    clip2Opacity = 255;
    clip3Opacity = 255;
  }
}
