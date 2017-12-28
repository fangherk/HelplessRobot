
// Reach for the air to find the lost friend
void beHelpless(int millis){
  controller.digitalWrite(HANDREACHER, Arduino.HIGH);
  delay(millis);
  controller.digitalWrite(HANDREACHER, Arduino.LOW);
}


boolean generateFace(int choice) {
  boolean hasFace = false;
  background(0);
  opencv.loadImage(cam); 

  //translate(width - 320, height - 240);
  faces = opencv.detect();
  if (faces != null && faces.length != 0) {
    hasFace = true;
    
    image(cam, 0, 0);
    noFill();
    stroke(255, 0, 0);
    strokeWeight(3);
    for (int i = 0; i < faces.length; i++) {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
    
    tts.speak(hopeless[choice]);
    // println("faces.length", faces.length);
  }else{
    image(cam, 0, 0);
    tts.speak(polite[choice]);
  }

  return hasFace;
}

void destruction(){
  background(255);
  float reading = 225;
  float widthR, heightR;
  // Create a gradient of red 
  float coloration = (float) 1/ (reading / 200.0);
  int circleFills =  (int) (coloration * 255);
  fill(circleFills,0,0);
  
  // Create a robot in disarray;
  for(int i = 0; i < 420-reading; i++){
    widthR = random(width);
    heightR = random(height);
    ellipse(widthR, heightR, reading/10, reading/10);
  }
}

void generateTreasure(boolean hasFace) {
  // Create a guard around the chest
  pushMatrix();
  translate(width/2, 0);
  int xVal = width/4;
  int yVal = height/2;
  if (hasFace) {
    fill(200, 30, 0);
    ellipse(xVal, yVal, 500, 500);
  } else {
    fill(0, 157, 0);
    ellipse(xVal, yVal, 500, 500);
  }

  // Create a Dog Representation
  noStroke();
  fill(139, 69, 19);
  rect(xVal -50, yVal- 50, 100, 120, 7);
  fill(218, 165, 32);
  rect(xVal - 60, yVal - 60, 120, 30, 5);
  fill(0,0,0);
  ellipse(xVal-20, yVal, 15, 15);
  ellipse(xVal+20, yVal, 15, 15);
  fill(101, 67, 33);  
  ellipse(xVal, yVal+20, 15, 15);
  stroke(43, 29, 14);
  line(xVal-20, yVal+50, xVal+20, yVal+50);
  noStroke();
  popMatrix();
}

void fullOutputs(boolean face, boolean friend){
   int choice = (int) random(5);
   // Create the snapshot of face on the screen.
   
   if(face == true){
      pushMatrix();
      translate(width/8, height/3.5);
      image(cam, 0, 0);
      // Generate the color of the the face detection. to red
      noFill(); stroke(255, 0, 0); strokeWeight(3);
      for (int i = 0; i < faces.length; i++) {
        rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
      }
      popMatrix();
      generateTreasure(face);
      if(friend == true){ // Friend + Face
        tts.speak(concerned[choice]);
      }else{ // No Friend + Face
        tts.speak(agitated[choice]);
      }
   }else{// No face + Friend
     if(friend == true){
       pushMatrix();
       translate(width/8, height/3.5);
       // image(cam, 0, 0);
       popMatrix();
       // Good Days
       generateTreasure(face);
       //file.play();
       tts.speak(polite[choice]);
       rect(0, 0, width/2, height);
     }else{ // No Face No Friend
        // Destruction
        destruction();
        //beHelpless(500);
        controller.servoWrite(HANDREACHER, 0);
        delay(250);
        controller.servoWrite(HANDREACHER, 90);
        tts.speak(hopeless[choice]);
        //rect(0, 0, width/2, height);
     }
   }
}