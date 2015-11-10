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

void  create_surface() {

    // This is what box2d uses to put the surface in its world
    ChainShape chain = new ChainShape();
    
    // Build an array of vertices in Box2D coordinates
    // from the ArrayList we made
    Vec2[] vertices = new Vec2[surface_vector.size()];

    int counter = 0;
      for (int i = 0; i < (vertices.length-1); i++) {
      Vec2 edge = box2d.coordPixelsToWorld(surface_vector.get(i));
      Vec2 edge_next = box2d.coordPixelsToWorld(surface_vector.get(i+1)); 
       if ((edge.x != edge_next.x) && (edge.y != edge_next.y)) {
       vertices[counter] = edge;
       counter += 1;
       }
      }
      
      // Get the endpoint, assume it is unique
      vertices[counter] = box2d.coordPixelsToWorld(surface_vector.get(vertices.length-1));
      counter += 1;
      
    Vec2[] vertices_no_double_count = new Vec2[counter];
    for (int i = 0;i< counter; i++) {
    vertices_no_double_count[i] = vertices[i];
    }
        
    // Create the chain!
    chain.createChain(vertices_no_double_count,vertices_no_double_count.length);
    
    // The edge chain is now attached to a body via a fixture
    BodyDef bd = new BodyDef();
    bd.position.set(0.0f,0.0f);
    Body body = box2d.createBody(bd);
    // Shortcut, we could define a fixture if we
    // want to specify frictions, restitution, etc.
    body.createFixture(chain,1);

  }

  // A simple function to just draw the edge chain as a series of vertex points
void display_surface() {
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
    text("Click anywhere to drop objects!",0.25*width,0.15*height);
}


void delete_leaving_particles() {

  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    if (p.done()) {
      particles.remove(i);
    }
  }  
}
