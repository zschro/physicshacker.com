// Planetoids code by Chris Orban 
// modified from Daniel Shiffman's Nature of Code 2011 book
// http://www.shiffman.net

float x;
float y;

float vx;
float vy;

float deltaVx;
float deltaVy;

float theta = 0;

float Fthrust = 10.0;
float mass = 1.0;
float dt = 0.1;

// For people with C and C++ experience, draw() is
// very similar to main(), except that draw() 
// is run over and over again 
void draw() {
  
  // Update velocities
  vx += deltaVx;

  // Update location
//  x += vx*dt;

  // Set deltaV to zero (thrust off unless user turns it on)
  deltaVx = 0;

  // Draw ship and other stuff
  display();
//  String message = "theta = " + theta;
  textSize(30);
  text("theta = ",0.4*width,0.4*height);
  text(theta*180./PI,0.6*width,0.4*height);

  // Turn or thrust the ship depending on what key is pressed
  if (keyPressed) {
    if (key == CODED && keyCode == LEFT) {
      theta += 0.01;
    } else if (key == CODED && keyCode == RIGHT) {
      theta += -0.01;
    } else if (key == CODED &&  keyCode == UP ) {
      // Rockets on!
      float accelx = Fthrust*cos(theta)/mass;
      deltaVx = accelx*dt;
    } else if (key == CODED &&  keyCode == DOWN ) {
      // Do nothing
    } 
  } 

} // end draw()


