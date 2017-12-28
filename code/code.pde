/* 
 * Herrick Fang
 * 11/29/2017
 * Inspired by the Helpless Robot
 * A Robot Protect its Friend, the Dog
 */
 
import processing.sound.*;
SoundFile file;


import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;
import java.awt.Rectangle;
import processing.video.*;
import gab.opencv.*;
import guru.ttslib.*;

TTS tts;
Arduino controller;
OpenCV opencv;
Rectangle[] faces;
Capture cam;

int FRIENDPIN = 5;
int FOILDRIVER = 6;
int HANDREACHER = 7;

boolean hasFace = false;
boolean hasDog = true;
void setup() {   
  // Create Background Image
  fullScreen();
  //size(1280, 480); //testing mode

  // Create a new Arduino object and turn on respective digital read pins
  controller = new Arduino(this, Arduino.list()[0], 57600);
  controller.pinMode(FRIENDPIN, Arduino.INPUT);
  controller.pinMode(FOILDRIVER, Arduino.OUTPUT);
  controller.pinMode(HANDREACHER, Arduino.SERVO);
  controller.digitalWrite(FOILDRIVER, Arduino.HIGH);
  
  // Set up Text to Speech 
  System.setProperty("mbrola.base", "C:\\mbrola");
  tts = new TTS("mbrola_us2");
  
  // Set up OpenCV face detection.
  cam = new Capture(this, 640, 480);
  cam.start();
  opencv = new OpenCV(this, cam.width, cam.height);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  //opencv.startBackgroundSubtraction(4, 3, .4);
}


void draw() {
  background(55);
    

  // Create outputs depending on the detection of a 
  // face and a friend
  hasFace = detectFace();
  hasDog = detectFriend();
  println(hasDog);
  
  fullOutputs(hasFace, hasDog);
  
  
  delay(1000);
 
}

// New images from camera
void captureEvent(Capture cam) {
  cam.read();
}