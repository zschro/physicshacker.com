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

float x_blob = 375;
float y_blob = 250;
float mass_blob = 10.0;
float radius_blob = 50;

float vx_blob = random(-20,20);
float vy_blob = random(-20,20);

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
  vy += deltaVy;


  // Update location
  x += vx*dt;
  y += vy*dt;
  x_blob += vx_blob*dt;
  y_blob += vy_blob*dt;

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
    } else if (key == CODED &&  keyCode == DOWN ) {
      // Do nothing
    } 
  } 

  // Draw ship and other stuff
  // This will clear the screen and re-draw it
  display();

  ellipse(x_blob,y_blob,radius_blob,radius_blob);

  float dx_blob = x - x_blob;
  float dy_blob = y - y_blob;
  if( sqrt(dx_blob*dx_blob + dy_blob*dy_blob) < radius_blob ) {
  // Perfectly inelastic collision 
  vx = (mass*vx + mass_blob*vx_blob)/(mass + mass_blob);  
  vx_blob = vx; // The objects are stuck to each other  
  vy = (mass*vy + mass_blob*vy_blob)/(mass + mass_blob);  
  vy_blob = vy; // The objects are stuck to each other  
  }


} // end draw()


