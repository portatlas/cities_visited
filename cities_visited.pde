//libraries
import processing.pdf.*;

//global variables
PShape baseMap;
String csv[];
String myData[][];
PFont f;


//setup
void setup() {
  size(1000, 500);
  noLoop();
  f = createFont("Avenir-Medium", 12);
  baseMap = loadShape("WorldMap.svg");
  csv = loadStrings("citiesgrid.csv");
  myData = new String[csv.length][6];
  for (int i = 0; i < csv.length; i++) {
    myData[i] = csv[i].split(",");    
  }
}

//draw
void draw() {
  beginRecord(PDF, "cities_visited.pdf");

  shape(baseMap, 0 , 0, width, height);
  noStroke();


  for (int i = 0; i < myData.length; i++) {
    fill(144, 195, 212, 255);
    textMode(MODEL);
    noStroke();
    float graphLong = map(float(myData[i][3]), -180, 180, 0, width);
    float graphLat = map(float(myData[i][4]), 90, -90, 0, height);
    float markerSize = 10*sqrt(float(myData[i][2]))/PI;
    ellipse(graphLong, graphLat, markerSize, markerSize);
    
    if (i < 5) {
      fill(0);
      textFont(f);
      text(myData[i][0], graphLong + markerSize + 5, graphLat + 4);
      noFill();
      stroke(0);
      line(graphLong + markerSize/2, graphLat, graphLong + markerSize, graphLat);
      
    }
  }
  endRecord();
  println("PDF Saved!");
  
}