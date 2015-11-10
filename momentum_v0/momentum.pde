// Planetoids code by Chris Orban

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

float x_blob;
float y_blob;
float mass_blob;
float radius_blob;

float vx_blob;
float vy_blob;

void setup() {
  size(750,500);
  x = 0.2*width;
  y = height/2;
}

// For people with C and C++ experience, draw() is
// very similar to main(), except that draw() 
// is run over and over again 
void draw() {
  
  // Update velocities
  vx += deltaVx;

  // Update location
  x += vx*dt;

  // Set deltaV to zero (thrust off unless user turns it on)
  deltaVx = 0;

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
    } else if (key == CODED &&  keyCode == DOWN ) {
      // Do nothing
    } 
  } 

  // Draw ship and other stuff
  // This will clear the screen and re-draw it
  display();

  // Add more graphics here before the end of draw()

} // end draw()


