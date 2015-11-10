/* @pjs globalKeyEvents="true"; */
/* @pjs pauseOnBlur="true"; */

// Planetoids code by Chris Orban

// Some code in this file is from LGPL licenced code 
// that accompanied Daniel Shiffman's Nature of Code 2011 book
// http://www.shiffman.net

// Size of the ship
float r = 12;

boolean showarrows = true;

// Draw the ship and other stuff
void display() { 
//    wrapEdges();
    background(255);
    stroke(0);
    strokeWeight(2);
    pushMatrix();
    translate(x,y);
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
    text("left right arrows to turn, tap up arrow to thrust, press H to hide the arrows, press U to un-hide",10,10);

  float dx_blob = x - x_blob;
  float dy_blob = y - y_blob;
  if( (sqrt(dx_blob*dx_blob + dy_blob*dy_blob) < radius_blob/3) ) {
  deltaVx += deltaVx_blob;
  }

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

    // Draw velocity arrow
    float v_scaling=1.0;
    stroke(255,0,0); // makes the line red
    strokeWeight(3); // makes the line thicker

    if ( ((vx != 0) || (vy != 0)) && showarrows) {
    line(x,y,x+v_scaling*vx,y+v_scaling*vy);
    float vel_angle = -atan2(vy,vx);
    fill(255,0,0); // makes the triangle red
    triangle(x+v_scaling*vx+sin(vel_angle)*tri_width/2,y+v_scaling*vy+cos(vel_angle)*tri_width/2,x+v_scaling*vx-sin(vel_angle)*tri_width/2,y+v_scaling*vy-cos(vel_angle)*tri_width/2,x+v_scaling*vx+cos(vel_angle)*10,y+v_scaling*vy-sin(vel_angle)*10);
    }

    // Draw force arrow
//    float f_scaling=2.25;
    float f_scaling=5.0;
    float Fx = mass*deltaVx/dt;
    float Fy = mass*deltaVy/dt;
    float f_angle = -atan2(Fy,Fx);

    if (((Fx != 0) || (Fy != 0)) && showarrows) {
//    if (((Fx != 0) || (Fy != 0)) && 0 ) {
    stroke(0,0,255); // makes the line blue
    line(x,y,x+f_scaling*Fx,y+f_scaling*Fy);
    fill(0,0,255); // makes the triangle blue
    triangle(x+f_scaling*Fx+sin(f_angle)*tri_width/2,y+f_scaling*Fy+cos(f_angle)*tri_width/2,x+f_scaling*Fx-sin(f_angle)*tri_width/2,y+f_scaling*Fy-cos(f_angle)*tri_width/2,x+f_scaling*Fx+cos(f_angle)*10,y+f_scaling*Fy-sin(f_angle)*10);
    }

    float a_scaling=f_scaling;
    float ax = deltaVx/dt;
    float ay = deltaVy/dt;
    if (((ax != 0) || (ay != 0)) && showarrows) {
    stroke(204,0,204); // makes the line purple
    line(x,y,x+a_scaling*ax,y+a_scaling*ay);
    fill(204,0,204); // makes the triangle purple
    triangle(x+a_scaling*ax+sin(f_angle)*tri_width/2,y+a_scaling*ay+cos(f_angle)*tri_width/2,x+a_scaling*ax-sin(f_angle)*tri_width/2,y+a_scaling*ay-cos(f_angle)*tri_width/2,x+a_scaling*ax+cos(f_angle)*10,y+a_scaling*ay-sin(f_angle)*10);
    }

    if (showarrows) {
    textSize(20);
    fill(255,0,0);
    text("Velocity",10,425);
    fill(0,0,255);
    text("Net Force",10,450);
    fill(204,0,204);
    text("Acceleration",10,475);
    }

//    fill(0,0,0); //If more text is written elsewhere make sure the default is black
//    fill(255,255,255);
    noFill();
    stroke(0,0,0); // If more lines are drawn elsewhere make sure the default is black

    //Draw the spring
    float string_width = 30;
    int Nwraps = 9;
    for (int i = 1; i<(Nwraps-1); i++) {
    float xplot =  (i-1)*x_blob/(Nwraps-1);
    float xnext = (i-0)*x_blob/(Nwraps-1);
    if( i%2 == 0) { // i is even
      line(xplot,y_blob-string_width/2,xnext,y_blob+string_width/2);
      } else {  // i is odd
        line(xplot,y_blob+string_width/2,xnext,y_blob-string_width/2);
      }
    }
    
    // Draw the last spring segment
    int i = Nwraps-1;
    float xplot =  (i-1)*x_blob/(Nwraps-1);
    float xnext = (i-0)*x_blob/(Nwraps-1);
    if (Nwraps%2 == 0) {
    line(xplot,y_blob+string_width/2,xnext,y_blob); 
    } else {
    line(xplot,y_blob-string_width/2,xnext,y_blob);
    }

    // indicate relaxed length of the spring
    stroke(34,177,76);
    line(Lrelaxed,y_blob+string_width,Lrelaxed,y_blob+3*string_width);
    line(1,y_blob+2*string_width,Lrelaxed,y_blob+2*string_width);
    line(1,y_blob+string_width,0,y_blob+3*string_width);
    fill(34,177,76);
    text("relaxed length",0.25*Lrelaxed,y_blob+3*string_width);
    point(Lrelaxed,y_blob);
    
    fill(0,0,0);
    noFill();
    stroke(0,0,0);

}


void wrapEdges() {
    float buffer = r*2;
    if (x > width +  buffer) x = -buffer;
    else if (x <    -buffer) x = width+buffer;
    if (y > height + buffer) y = -buffer;
    else if (y <    -buffer) y = height+buffer;
}

