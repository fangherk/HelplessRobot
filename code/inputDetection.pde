// Detects if a face is visible from the webcam
boolean detectFace() {
  
  // Load the image and detect faces
  opencv.loadImage(cam); 
  faces = opencv.detect();
  
  // Return faces if it is true. Otherwise, return false.
  if (faces != null && faces.length != 0) {
    return true;
  }else{
    return false;
  }
}

// Detects if a friend is still in frame through mechanical means
boolean detectFriend(){
  if (controller.digitalRead(FRIENDPIN) == 1){
     return true; 
  }else{
     return false; 
  }
}