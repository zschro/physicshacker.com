/* @pjs pauseOnBlur="true"; */

Ball[] myBalls = new Ball[2];

//-------------------------------------------------------------------------------
// Draw function which will be called continuously after setup()
//-------------------------------------------------------------------------------
void draw(){
  background(255);
  
  // For each ball update the position based on velocity
  for(int a = 0; a<myBalls.length; a++) {
    myBalls[a].render(str(a+1));
    myBalls[a].update(1);
  }
  
  // Check if there is overlap
  for(int a = 0; a<myBalls.length; a++){
    for(int b = a+1; b<myBalls.length; b++) {
      boolean isOverlap = myBalls[a].checkOverlap(myBalls[b]);
      
      if(isOverlap){
        myBalls[a].collideWith(myBalls[b]);  
      }
      
    }
  }
  
}

//-------------------------------------------------------------------------------
// Our initial setup loop
//-------------------------------------------------------------------------------
void setup() {
  // Set up a frame and make the entire frame our canvas
  int width = 700;
  int height = 125;
  size(width, height);
  colorMode(RGB,255);
  
  noFill();
  smooth();
  background(255);
  
  myBalls[0] = new Ball(1, 50, 3.0, 0, 0.1*width, height/2);
  myBalls[1] = new Ball(3, 60, -.5, 0, 0.8*width, height/2);

}


//-------------------------------------------------------------------------------
// The Ball class to make ball objects
//-------------------------------------------------------------------------------
class Ball {
  
  float mass;
  float radius;
  
  float vX, vY, pX, pY;

  float t;
   
  public Ball(float m, float r, float initvx, float initvy, float initpx, float initpy) {
    mass = m;
    radius = r;
    
    vX = initvx;
    vY = initvy;
    pX = initpx;
    pY = initpy;
  }
  
  void render(String ballnumber) {   
    ellipse(pX,pY,radius*2,radius*2); 
    ellipse(pX+width,pY,radius*2,radius*2);
    ellipse(pX-width,pY,radius*2,radius*2);
//    ellipse(pX,pY+height,radius*2,radius*2);
//    ellipse(pX,pY-height,radius*2,radius*2); 
//    ellipse(pX+width,pY+height,radius*2,radius*2);
//    ellipse(pX+width,pY-height,radius*2,radius*2);
//    ellipse(pX-width,pY+height,radius*2,radius*2);
//    ellipse(pX-width,pY-height,radius*2,radius*2); 
    fill(0,0,0);
    textSize(20);
    text(ballnumber,pX-5,pY+7);
    fill(255,255,255);
  }
  
  void update(float dt) {
    pX = pX + vX*dt;
//    pY = pY + vY*dt;

    t += dt;

    if (t > 1250) {
//    background(255);
    fill(0,0,0);
    textSize(20);
    text("Refresh the webpage to restart the animation",0.2*width,0.25*height);
    fill(255,255,255);
    noLoop();
    }

    
    // Invoke periodic boundary conditions
    if (pX < 0) {
      pX = pX + width;
    } else if(pX > width) {
      pX = pX - width;
    }
    /*
    if (pY < 0) {
      pY = pY + height;
    } else if(pY > height) {
      pY = pY - height;
    } 
    */   
  }
  
  boolean checkOverlap(Ball b2) {
    float[] dists = new float[9];
    dists[0] = sqrt( pow(pX-b2.pX,2) + pow(pY-b2.pY,2) );
    dists[1] = sqrt( pow(pX-b2.pX-width,2) + pow(pY-b2.pY,2) );
    dists[2] = sqrt( pow(pX-b2.pX,2) + pow(pY-b2.pY-height,2) );
    dists[3] = sqrt( pow(pX-b2.pX+width,2) + pow(pY-b2.pY,2) );
    dists[4] = sqrt( pow(pX-b2.pX,2) + pow(pY-b2.pY+height,2) );
    dists[5] = sqrt( pow(pX-b2.pX-width,2) + pow(pY-b2.pY-height,2) );
    dists[6] = sqrt( pow(pX-b2.pX-width,2) + pow(pY-b2.pY+height,2) );
    dists[7] = sqrt( pow(pX-b2.pX+width,2) + pow(pY-b2.pY-height,2) );
    dists[8] = sqrt( pow(pX-b2.pX+width,2) + pow(pY-b2.pY+height,2) );
    
    float dist = min(dists);
    
    if(dist <= (radius + b2.radius) ) {
      return true;
    } else {
      return false;
    }
  }
  
  void collideWith(Ball b2) {
    float origvX = vX;
    float orig2vX = b2.vX;
    
    vX = (mass*origvX + b2.mass*orig2vX)/(mass+b2.mass);
    b2.vX = vX;

    /*
    float origvY = vY;
    float orig2vY = b2.vY;
    
    vY = (mass*origvY + b2.mass*orig2vY)/(mass+b2.mass);
    b2.vY = vY;
    */
  }
    
}
