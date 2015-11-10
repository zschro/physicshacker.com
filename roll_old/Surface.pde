// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Surface surface;

// An uneven surface boundary

class Surface {
  // We'll keep track of all of the surface points
 // ArrayList<Vec2> surface;

  Surface() {
//   surface = new ArrayList<Vec2>();

    // This is what box2d uses to put the surface in its world
    ChainShape chain = new ChainShape();

    // Perlin noise argument
 //   float xoff = 0.0;

    // This has to go backwards so that the objects  bounce off the top of the surface
    // This "edgechain" will only work in one direction!
   /*
    for (float x = width+10; x > -10; x -= 5) {

      // Doing some stuff with perlin noise to calculate a surface that points down on one side
      // and up on the other
      float y;
      if (x > width/2) {
        y = 50 + (width - x)*1.1 + map(noise(xoff),0,1,-80,80);
      } 
      else {
        y = 50 + x*1.1 + map(noise(xoff),0,1,-40,40);
      }

      // Store the vertex in screen coordinates
      surface.add(new Vec2(x,y));

      // Move through perlin noise
      // xoff += 0.1;

    }
    */
    
    // Build an array of vertices in Box2D coordinates
    // from the ArrayList we made
    Vec2[] vertices = new Vec2[surface_vector.size()];
    println(surface_vector.size());
    int counter = 0;
      for (int i = 0; i < (vertices.length-1); i++) {
      Vec2 edge = box2d.coordPixelsToWorld(surface_vector.get(i));
      Vec2 edge_next = box2d.coordPixelsToWorld(surface_vector.get(i+1));
      if ((edge.x != edge_next.x) && (edge.y != edge_next.y)) {
      vertices[counter] = edge;
      counter += 1;
//      println("x = ",edge.x,"y = ",edge.y);
      //println("y = ",edge.y);
      }
      }
      
      // Get the endpoint, assume it is unique
      vertices[counter] = box2d.coordPixelsToWorld(surface_vector.get(vertices.length-1));
      counter += 1;
      
//    println(vertices.length);
    println(counter);
    Vec2[] vertices_no_double_count = new Vec2[counter];
    for (int i = 0;i< counter; i++) {
    println("x = ",vertices[i].x,"y = ",vertices[i].y);
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
  void display() {
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
  


}


