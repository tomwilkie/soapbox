// Legality box
Height = 800;
Width = 1500;
Length = 2500;

OpeningLength = 1250;    // Length of the opening
OpeningWidthBack = 1000; // Width of the opening at our shoulders
OpeningWidthFront = 800; // Width of the opening at out knees/hands
BaseWidth = 800;         // Where out bum is
BaseLength = 350;        // Offset from back at base
NoseWidth = 400;         // Where our feet are
NoseHeight = 200;        // Height of the nose

RideHeight = 50;

CubePoints = [
  [ BaseLength,    (Width - BaseWidth) / 2, 0 ],          //0
  [ Length,        (Width - NoseWidth) / 2, 0 ],          //1
  [ Length,        (Width + NoseWidth) / 2, 0 ],          //2
  [ BaseLength,    (Width + BaseWidth) / 2, 0 ],          //3
  [ 0,             (Width - OpeningWidthBack) / 2, Height ],     //4
  [ OpeningLength, (Width - OpeningWidthFront) / 2,     Height ],     //5
  [ Length,        (Width - NoseWidth) / 2, NoseHeight ], //6
  [ Length,        (Width + NoseWidth) / 2, NoseHeight ], //7
  [ OpeningLength, (Width + OpeningWidthFront) / 2, Height ],     //8
  [ 0,             (Width + OpeningWidthBack) / 2, Height ],     //9
];
  
CubeFaces = [
  [0,1,2,3],   // bottom
  [1,2,7,6],   // front
  [2,3,9,8,7], // right
  [0,3,9,4],   // back
  [0,1,6,5,4], // left
  [5,6,7,8],   // front
];
 
translate([0,-Width/2,RideHeight]) {
    polyhedron( CubePoints, CubeFaces );
}

WheelThickness = 30;
WheelRadius = 350;
RearWheelCenter = [WheelRadius, (Width/2) - WheelThickness, WheelRadius];
FrontWheelCenter = [Length-WheelRadius, (Width/2) - WheelThickness, WheelRadius];
HubHeight = 150;

module wheel() {
    rotate([90,0,0]) {
        cylinder(h = WheelThickness, r = WheelRadius);
    }
}

    module beam(from, to, r) {
        vector = [to[0] - from[0], to[1] - from[1], to[2] - from[2]];
        distance = sqrt(pow(vector[0], 2) +	pow(vector[1], 2) +	pow(vector[2], 2));
        echo(distance);
        
        translate(vector/2 + from)
        //rotation of XoY plane by the Z axis with the angle of the [p1 p2] line projection with the X axis on the XoY plane
        rotate([0, 0, atan2(vector[1], vector[0])]) //rotation
        //rotation of ZoX plane by the y axis with the angle given by the z coordinate and the sqrt(x^2 + y^2)) point in the XoY plane
        rotate([0, atan2(sqrt(pow(vector[0], 2)+pow(vector[1], 2)),vector[2]), 0])
        cylinder(h = distance, r = r, center = true);
    } 

module dup() {
    children(); 
    mirror([0,1,0]) children(); 
}

dup() {
    translate([WheelRadius,        Width / 2, WheelRadius]) { wheel(); }
    translate([Length-WheelRadius, Width / 2, WheelRadius]) { wheel(); }
    
    // Rear lower whishbone
    beam(RearWheelCenter - [0,0,HubHeight], [WheelRadius, BaseWidth / 2, RideHeight], 10);
    beam(RearWheelCenter - [0,0,HubHeight], [WheelRadius * 2, BaseWidth / 2 - 50, RideHeight], 10);
    
    // Rear upper whishbone
    beam(RearWheelCenter, [WheelRadius, BaseWidth / 2, RideHeight + HubHeight], 10);
    beam(RearWheelCenter, [WheelRadius * 2, BaseWidth / 2 - 50, RideHeight + HubHeight], 10);
    
    // Front lower whishbone
    beam(FrontWheelCenter - [0,0,HubHeight], [Length-WheelRadius, NoseWidth / 2, RideHeight], 10);
    beam(FrontWheelCenter - [0,0,HubHeight], [Length-WheelRadius * 2, NoseWidth / 2, RideHeight], 10);
    
    // Front upper whishbone
    beam(FrontWheelCenter, [Length-WheelRadius, NoseWidth / 2, RideHeight + HubHeight], 10);
    beam(FrontWheelCenter, [Length-WheelRadius * 2, NoseWidth / 2, RideHeight + HubHeight], 10);
}
    
    