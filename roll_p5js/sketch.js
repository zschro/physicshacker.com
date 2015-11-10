// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

//modified by Savva Madar by about a lot.

var particle_radius = 0.6;
var world;
var isDrawing = true;
var mouseX=0;
var mouseY=0;
var isMouseDownRight = false;
var isMouseDownLeft = false;
var isMouseDownMiddle = false;
// A list we'll use to track fixed objects
var boundaries = [];
// A list for all of our particles
var particles = [];
var checkClick = false;
var checkClick2 = false;
var alt=0;

var updatedFrames = 0;

var altZX;
var altZY;

var altOX;
var altOY;

var oldMouseX=0;
var oldMouseY=0;

function setup() {
	document.addEventListener("mousedown", mouseDown, true);
	document.addEventListener("mouseup", mouseUp, true);
	document.addEventListener("mousemove", mouseMove, true);
	document.addEventListener("keydown", finishDrawing, true);
	createCanvas(640,360);
	// Initialize box2d physics and create the world
	world = createWorld(new box2d.b2Vec2(0, -9.8));
	background(255);
}


function mouseUp(e){
		if(e.button == 2){
			isMouseDownRight=false;
		}
		if(e.button == 1){
			isMouseDownMiddle=false;
		}
		if(e.button == 0){
			isMouseDownLeft=false;
			alt=0;
		}
}

function finishDrawing(e){
	if(e.keyCode == 32){
		if(isDrawing == true){
			isDrawing = false;
			alt=99;
		}
		else{
			if(checkClick == true){
				checkClick = false;
				isDrawing = false;
				for (var i = particles.length-1; i >= 0; i--) {
					particles[i].killBody();
					particles.splice(i,1);
				}
			}
		}
	}
}

//we want these to always update so it always gives us the most current mouse x and y position
//if we only update them after we click a ball may spawn to the last mouseX and mouseY position rather than the
//most current one
var sigChange=true;
function mouseMove(e){
	mouseX = (e.clientX - canvas.offsetLeft);
	mouseY = (e.clientY - canvas.offsetTop);
    if(((mouseX<oldMouseX*0.995) || (mouseX>oldMouseX*1.005))||((mouseY<oldMouseY*0.995) || (mouseY>oldMouseY*1.005))){
		sigChange=true;
	}
	if(sigChange==true){
		oldMouseX = mouseX;
		oldMouseY = mouseY;
	}
}

function mouseDown(e) {
	if(e.button == 2){
		isMouseDownRight=true;
	}
	if(e.button == 1){
		isMouseDownMiddle=true;
	}
	if(e.button == 0){	
		alt=0;
		isMouseDownLeft=true;
	}
}

//chains dont work with box2dweb so I had to come up with a different solution to drawing the play area
//this solution basically makes a bunch of rectangles based on your mouse position.
function create_surface() {
	if(alt==1){
		altOX = mouseX;
		altOY = mouseY;
	}
	else if(alt==2){
		//the alt==3 part just reduces the amount of boundries in half.
		//for example if alt == 2 that would be 100% accuracy more or less)
		//alt == 3 is about 75% accurate but with 50% of the boundaries 
		// you would have needed to render if it was at alt==1
		//alt ==4 is about 50% accurate but with 25% of the boundaries
		// of alt==2
		//alt == 1 doesnt work because alt==1 is the initial state
		//alt == 2 is the most fluid
		//alt == 3 is a way to have god accuracy while minimizng lag
		//anything above that looks choppy and probably not worht
		//sacrificying smoothness and accuracy for less lag
        alt=1;
		altZX = mouseX;
		altZY = mouseY;
		//spawn the thing
		var myB = new Boundary(altZX,altZY,altOX,altOY);
		if(myB==null){
			alt=2;
		}
		else{
			boundaries.push(myB);
		}
		altOX = altZX;
		altOY = altZY;
	}
}

function draw() {
	background(255);
	if(isDrawing == false){
		fill(0);
		textSize(20);
		if(checkClick == false){
			text("Click anywhere to drop objects!",0.29*width,0.1*height);
		}
		else{
			text("Press SPACE to reset particles.",0.28*width,0.1*height);
		}
		if(isMouseDownLeft == true){
			var b = new Particle(mouseX,mouseY,particle_radius);
			particles.push(b);
			checkClick=true;
		}
	}
	else{
		fill(0);
		textSize(20);
		if(checkClick2 == false){
			text("Click the screen to define the surface",0.25*width,0.1*height);
		}
		else{
			text("Press SPACEBAR when finished",0.28*width,0.1*height);
		}
		if(isMouseDownLeft == true){
			checkClick2=true;
			if(sigChange==true){
				alt++;
			}
			create_surface();
		}
	}
	// We must always step through time!
	var timeStep = 1.0/30;
	// 2nd and 3rd arguments are velocity and position iterations
	world.Step(timeStep,1,1);
	// Display all the boundaries
	for (var i = 0; i < boundaries.length; i++) {
		boundaries[i].display();
	}
	// Delete & Display all the particles
	for (var i = particles.length-1; i >= 0; i--) {
		particles[i].display();
		if (particles[i].done()==true) {
			particles.splice(i,1);
		}
	}
	sigChange=false;
}




