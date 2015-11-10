// Bellicose Birds code by Chris Orban

float x;
float y;

float vx;
float vy;

float deltaVx;
float deltaVy;

float theta = 0;

float Fthrust = 30.0;
float mass = 3.0;
float dt = 0.1;

float g = 0;

float vinit = 50;

PImage img;

void setup() {
  size(750,500);
  x = 0.2*width;
  y = 0.95*height;
  img = loadImage("http://www.physics.ohio-state.edu/~orban/processing_2015/rougebird.jpg");
}

// For people with C and C++ experience, draw() is
// very similar to main(), except that draw() 
// is run over and over again 
void draw() {
  
  // Update velocities
  vx += deltaVx;
  vy += deltaVy;

  // Update location
  x += vx*dt;
  y += vy*dt;

  // Set deltaV to zero (thrust off unless user turns it on)
  deltaVx = 0;
  deltaVy = 0;

  // Turn or thrust the ship depending on what key is pressed
  if (keyPressed) {
    if (key == CODED && keyCode == LEFT) {
      theta += 0.05;
    } else if (key == CODED && keyCode == RIGHT) {
      theta += -0.05;
    } else if (key == CODED &&  keyCode == UP ) {
      // Rockets on!
      float accelx = Fthrust*cos(theta)/mass;
      deltaVx = accelx*dt;
      float accely = -Fthrust*sin(theta)/mass;
      deltaVy = accely*dt;
    } else if (key == ' ') { // spacebar is pressed
      g = 9.8;
      vx = vinit*cos(theta);
      vy = -vinit*sin(theta);      
    } 
  }

  // Add gravity, note that down is positive
  deltaVy += g*dt;

  // Draw ship and other stuff
  // This will clear the screen and re-draw it
  display();

  line(0,height,width,height);

  float x0 = 0.2*width;
  float y0 = 0.95*height;

  int Npoints=1000;
  for(int i=1;i<=Npoints;i+=1)
  {
  float t = (i-1)*dt;
  float xdraw = x0 + vinit*cos(theta)*t;
  float ydraw = y0 - vinit*sin(theta)*t + 0.5*9.8*t*t;
  point(xdraw,ydraw);
  }  

  if (y > height) {
  text("Game Over!",width/2,height/2);
  text(x*180/3.14,width/2,height/2 + 20);
  text(theta*180/3.14,width/2,height/2 + 40);
  noLoop();
  }

} // end draw()


