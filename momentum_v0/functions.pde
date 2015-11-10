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
    wrapEdges();
    wrapBlobEdges();
    background(255);
    ellipseMode(RADIUS);
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

    // Draw velocity arrow for the blob
    if ( ((vx_blob != 0) || (vy_blob != 0)) && showarrows) {
    line(x_blob,y_blob,x_blob+v_scaling*vx_blob,y_blob+v_scaling*vy_blob);
    float vel_angle = -atan2(vy_blob,vx_blob);
    fill(255,0,0); // makes the triangle red
    triangle(x_blob+v_scaling*vx_blob+sin(vel_angle)*tri_width/2,y_blob+v_scaling*vy_blob+cos(vel_angle)*tri_width/2,x_blob+v_scaling*vx_blob-sin(vel_angle)*tri_width/2,y_blob+v_scaling*vy_blob-cos(vel_angle)*tri_width/2,x_blob+v_scaling*vx_blob+cos(vel_angle)*10,y_blob+v_scaling*vy_blob-sin(vel_angle)*10);
    }

    // Draw force arrow
    float f_scaling=2.25;
//    float f_scaling=5.0;
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
    text("Force",10,450);
    fill(204,0,204);
    text("Acceleration",10,475);
    }

    fill(0,0,0); //If more text is written elsewhere make sure the default is black
    noFill();
    stroke(0,0,0); // If more lines are drawn elsewhere make sure the default is black

}


void wrapEdges() {
    float buffer = r*2;
    if (x > width +  buffer) x = -buffer;
    else if (x <    -buffer) x = width+buffer;
    if (y > height + buffer) y = -buffer;
    else if (y <    -buffer) y = height+buffer;
}

void wrapBlobEdges() {
    float buffer = r*2;
    if (x_blob > width +  buffer) x_blob = -buffer;
    else if (x_blob <    -buffer) x_blob = width+buffer;
    if (y_blob > height + buffer) y_blob = -buffer;
    else if (y_blob <    -buffer) y_blob = height+buffer;
}

