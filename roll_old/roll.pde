// By Chris Orban

// Much of the code is derived and modified from Daniel 
// Schiffman's Nature of Code

// An uneven surface

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;

// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;

// An object to store information about the uneven surface
//Surface surface;

ArrayList<Vec2> surface_vector;

boolean definesurface = true;
int clickcounter = 0;



void setup() {
  size(600,400);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -9.8);

  // Create the empty list
  particles = new ArrayList<Particle>();

  surface_vector = new ArrayList<Vec2>();
}



void draw() {
  
  if (definesurface) {
  display_while_drawing_surface();
  
  if (mousePressed) {
  surface_vector.add(new Vec2(mouseX,mouseY));
  }  
  
  // Define surface until spacebar is pressed
  if (keyPressed && (key == ' ')) {
    surface = new Surface();
    definesurface = false;
  }
    
} else {  
    
  // If the mouse is pressed, we make new particles
  if (mousePressed) {
    // Randomly sized particles
    // float sz = random(2,6);
    // particles.add(new Particle(mouseX,mouseY,sz));
      particles.add(new Particle(mouseX,mouseY,6.0));
  }

  // We must always step through time!
  box2d.step();

  background(255);

  // Draw the surface
  surface.display();

  // Draw all particles
  for (Particle p: particles) {
    p.display();
  }

  // Particles that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    if (p.done()) {
      particles.remove(i);
    }
  }
}
}


void display_while_drawing_surface() {
    background(255);
    strokeWeight(2);
    stroke(0);
    noFill();
    beginShape();
    for (Vec2 v: surface_vector) {
      vertex(v.x,v.y);
    }
    endShape();  
    fill(0);
    textSize(20);
    text("Click the screen to define the surface",0.2*width,0.1*height);
    text("Press SPACEBAR when finished",0.25*width,0.15*height);
}



