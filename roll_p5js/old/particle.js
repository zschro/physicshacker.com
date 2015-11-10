// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


//modified by Savva Madar about 15%. Basically just changing squares to circles and adding random color

// Constructor
function Particle(x, y, r) {

  var myColor = color(parseInt(100+random()*155),parseInt(100+random()*155),parseInt(100+random()*155));
  // Define a body
  var bd = new box2d.b2BodyDef();
  var myRadius = r;
  
  bd.type = box2d.b2BodyType.b2_dynamicBody;
  bd.position = scaleToWorld(x,y);

  // Define a fixture
  var fd = new box2d.b2FixtureDef();
  // Fixture holds shape
  fd.shape = new box2d.b2CircleShape(myRadius);
  
  // Some physics
  fd.density = 1.0;
  fd.friction = 0.05;
  fd.restitution = 0.3;
 
  // Create the body
  this.body = world.CreateBody(bd);
  // Attach the fixture
  this.body.CreateFixture(fd);

  // Some additional stuff
  this.body.SetLinearVelocity(new box2d.b2Vec2(0, 0));
  this.body.SetAngularVelocity(0);

  // This function removes the particle from the box2d world
  this.killBody = function() {
    world.DestroyBody(this.body);
  }
  
  

  // Is the particle ready for deletion?
  this.done = function() {
    // Let's find the screen position of the particle
    var pos = scaleToPixels(this.body.GetPosition());
    // Is it off the bottom of the screen?
	//console.log("is "+pos.y+" > "+(height+this.r*3));
	//I do 3 to make sure it's off screen before killing it
    if (pos.y > height+myRadius*3) {
      this.killBody();
      return true;
    }
    return false;
  }

  // Drawing the particle
  this.display = function() {
    // Get the body's position
    var pos = scaleToPixels(this.body.GetPosition());
    // Get its angle of rotation
	var a = this.body.GetAngle();
    push();
    translate(pos.x,pos.y);
    rotate(a);
    //    fill(myColor);
    fill(175);
    stroke(0);
    strokeWeight(1);
    ellipse(0,0,r*20,r*20);
    // Let's add a line so we can see the rotation
    line(0,0,r*10,0);
    pop();
  }
}