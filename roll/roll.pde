// Roll by Chris Orban
// including a user-defined surface

// This code is derived and (sometimes heavily) modified from Daniel 
// Schiffman's Nature of Code

// REQUIRES DOWNLOADING THE BOX2DPROCESSING LIBRARY!!!!
// in the processing interface, click sketch -> import library
// then click to install Box2DProcessing by Daniel Schiffman

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;

// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;

// An ArrayList to store information about the user-defined surface
ArrayList<Vec2> surface_vector;

// When the user is finished defining the surface, we will 
// change this to false
boolean definesurface = true;

// Particle properties
float particle_radius = 6.0;
float coeff_friction = 0.05;
float coeff_restitution = 0.3; // =1 for elastic collisions
                               // =0 for (almost) perfeclty inelastic collisions 

// For people with C++ experience, box2d is a class
Box2DProcessing box2d;

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
  
  if (definesurface) 
  { 
   // Let the user define the surface
  
   display_while_drawing_surface();
  
   if (mousePressed) {
    // The position of the mouse on each click defines the surface
    surface_vector.add(new Vec2(mouseX,mouseY));
   }  
  
   // Define surface until spacebar is pressed
   if (keyPressed && (key == ' ')) {
    create_surface();
    definesurface = false;
   }
    
  } else {   
   // now we are finished defining the surface, let the fun begin!
    
   // If the mouse is pressed, we make new particles
   if (mousePressed) {
       particles.add(new Particle(mouseX,mouseY,particle_radius));
   }

   // We must always step through time!
   box2d.step();

   // Draw the user-defined surface
   display_surface();

   // Draw each particle
   for (int i = 0; i < particles.size() ; i++) {
      particles.get(i).display();
   }
  
   // Delete particles that are leaving the box 
   delete_leaving_particles();

  } //end if-else
} // end draw()

