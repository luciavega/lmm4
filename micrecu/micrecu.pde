import processing.sound.*;
import processing.core.*;
import java.util.ArrayList;
import processing.serial.*;

AudioIn input;
Amplitude analyzer;
ArrayList<ImageInfo> images = new ArrayList<ImageInfo>();
PImage[] imgArray;
int imgDuration = 60;

int timerStart = 0;
int valueSend = 0;
boolean timerActive = false;
boolean showImages = false;
boolean suddenImages = false;
int circleDiameter = 50;

Serial myPort;

void setup() {
  size(400, 400);
  background(0);

  imgArray = new PImage[2];
  imgArray[0] = loadImage("1.png");
  imgArray[1] = loadImage("2.png");

  input = new AudioIn(this, 0);
  input.start();

  analyzer = new Amplitude(this);
  analyzer.input(input);
  
  String portName = "COM3";
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(0);

  float vol = analyzer.analyze();
  boolean controlByKey = false;

  if (keyPressed && key == 'R') {
    vol = 0.2; // Simula que el volumen es mayor a 0.1
    controlByKey = true;
  }

  if (vol > 0.1) {
    if (!timerActive) {
      timerActive = true;
      timerStart = millis();
    }    
    if (millis() - timerStart < 1000) {
      suddenImages = true;
      showImages = false;
      valueSend = 1;
    } else  if (millis() - timerStart >= 1000) {
      suddenImages = false;
      showImages = true;
      valueSend = 2;
    }
  } else {
    valueSend = 0;
    timerActive = false;
    showImages = false;
    suddenImages = false;
    images.clear();
    circleDiameter = 50 + (int)(10 * sin(millis() / 100.0));
  }

  myPort.write(valueSend);
  println(valueSend);

  if (showImages) {
    if (images.size() < 50) {
      ImageInfo newImage = new ImageInfo(random(width), random(height), int(random(imgArray.length)));
      images.add(newImage);
    }
    circleDiameter += 5; 
  } else if (suddenImages) {
    images.clear();
    for (int i = 0; i < 50; i++) { 
      ImageInfo burstImage = new ImageInfo(random(width), random(height), int(random(imgArray.length)));
      images.add(burstImage);
    }
    circleDiameter = 300;  
    
    if (millis() - timerStart >= 1000) {
      suddenImages = false;
      images.clear();
      circleDiameter = 50;
    }
  }

  for (int i = images.size() - 1; i >= 0; i--) {
    ImageInfo imgInfo = images.get(i);
    PImage img = imgArray[imgInfo.imgIndex];

    image(img, imgInfo.x, imgInfo.y, imgInfo.size, imgInfo.size);

    imgInfo.size += imgInfo.direction * 2;
    if (imgInfo.size >= 70 || imgInfo.size <= 30) {
      imgInfo.direction *= -1;
    }

    imgInfo.timer++;
    if (imgInfo.timer >= imgDuration) {
      images.remove(i);
    }
  }

  drawBlurredCircle(width / 2, height + circleDiameter / 2 - 20, circleDiameter);
}

void drawBlurredCircle(float x, float y, float diameter) {
  int layers = 20;
  for (int i = layers; i > 0; i--) {
    float alpha = map(i, 0, layers, 0, 255);
    float d = diameter * (i / (float)layers);
    fill(255, 127, 0, alpha);
    noStroke();
    ellipse(x, y, d, d);
  }
}

void stop() {
  input.stop();
  super.stop();
}
