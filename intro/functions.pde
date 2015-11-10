/* @pjs globalKeyEvents="true"; */

// Planetoids code by Chris Orban
// modified from Daniel Shiffman's Nature of Code 2011 book
// http://www.shiffman.net

// Size of the ship
float r = 12;

boolean showarrows = true;

void setup() {
  int width = 750;
  int height = 500;
  size(width,height);
  smooth();
  x = width/2;
  y = height/2;
}

// Draw the ship and other stuff
void display() { 
    wrapEdges();
    background(255);
    stroke(0);
    strokeWeight(2);
    pushMatrix();
    translate(x,y+r);
    rotate(-theta+PI/2);
    fill(175);
    // A triangle
    beginShape();
    vertex(-r,r);
    vertex(0,-1.5*r);
    vertex(r,r);
    endShape(CLOSE);
    rectMode(CENTER);
    popMatrix();
    fill(0);
    text("left right arrows to turn, tap up arrow to thrust, press H to hide the coordinate system, press U to un-hide",10,10);
    if ( key == 'h') {
    showarrows = false;
    } else if (key == 'u') {
    showarrows = true;
    }
    int tri_width=7;
    if (showarrows) {    
    int x_line=10;
    int y_line=25;
    int line_len=100;
    line(x_line,y_line,x_line,y_line+line_len);
    line(x_line,y_line,x_line+line_len,y_line);
    triangle(x_line-tri_width/2,y_line+line_len,x_line+tri_width/2,y_line+line_len,x_line,y_line+line_len+10);
    triangle(x_line+line_len,y_line-tri_width/2,x_line+line_len,y_line+tri_width/2,x_line+line_len+10,y_line);
    text("+x",x_line+line_len+12,y_line);
    text("+y",x_line,y_line+line_len+25);
    }

    fill(0,0,0); //If more text is written elsewhere make sure the default is black
    stroke(0,0,0); // If more lines are drawn elsewhere make sure the default is black
}


void wrapEdges() {
    float buffer = r*2;
    if (x > width +  buffer) x = -buffer;
    else if (x <    -buffer) x = width+buffer;
    if (y > height + buffer) y = -buffer;
    else if (y <    -buffer) y = height+buffer;
}

