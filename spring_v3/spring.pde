// Planetoids code by Chris Orban

float x;
float y;

float vx;
float vy;

float deltaVx;
float deltaVy;

float deltaVx_blob;

float theta = -PI;

float Fthrust = 30.0;
float mass = 3.0;
float dt = 0.1;

float Lrelaxed = 300;

float x_blob = Lrelaxed;
float y_blob = 250;
float mass_blob = 10.0;
float radius_blob = 50;

float vx_blob;
float vy_blob;

float k = 0.5;

float tcounter = 0;
float tlasttime = 0;

void setup() {
  size(750,500);
  x = 0.7*width;
  y = height/2;
}

// For people with C and C++ experience, draw() is
// very similar to main(), except that draw() 
// is run over and over again 
void draw() {
  
  // Update velocities
  vx += deltaVx;
  vx_blob += deltaVx_blob;

  // Update location
  x += vx*dt;
  x_blob += vx_blob*dt;

  // Set deltaV to zero (thrust off unless user turns it on)
  deltaVx = 0;

  float Fspring = -k*(x_blob-Lrelaxed);
  deltaVx_blob = Fspring/mass_blob*dt;

  float dx_blob = x - x_blob;
  float dy_blob = y - y_blob;
  if( sqrt(dx_blob*dx_blob + dy_blob*dy_blob) < radius_blob/3 ) {
  // Perfectly inelastic collision 
  vx = (mass*vx + mass_blob*vx_blob)/(mass + mass_blob);  
  vx_blob = vx; // The objects are stuck to each other  
  deltaVx_blob = Fspring/(mass_blob+mass)*dt;
  }

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

  ellipse(x_blob,y_blob,radius_blob,radius_blob);

  text("counter time = ",0.7*width,0.6*height);
  text(tcounter,0.75*width,0.65*height); 

  tcounter += dt;
  if ((abs(x_blob - Lrelaxed) < 5.0) & (tcounter > 10*dt)) {
  tlasttime = tcounter;
  tcounter = 0;
  } 
  
  text("half cycle time = ",0.7*width,0.75*height);
  text(tlasttime,0.75*width,0.8*height);

} // end draw()


