// Legality box
Height = 800;
Width = 1500;
Length = 2500;

OpeningLength = 1250;    // Length of the opening
OpeningWidthBack = 1000; // Width of the opening at our shoulders
OpeningWidthFront = 800; // Width of the opening at out knees/hands
BaseWidth = 800;         // Where out bum is
BaseLength = 400;        // Offset from back at base
NoseWidth = 400;         // Where our feet are
NoseHeight = 200;        // Height of the nose

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
  
polyhedron( CubePoints, CubeFaces );