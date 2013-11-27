import processing.serial.*;

Serial serialPort;
int serialValue;
int xPos = 1;
int[] yPos;

float data; 

void setup () {
  size(400, 300);
  println(Serial.list());
  serialPort = new Serial(this, Serial.list()[1], 9600);
  serialPort.bufferUntil('\n');
  
  background(0);
  yPos = new int[width];
}

void draw () {
  background(0);
  stroke(255, 255, 0, 120);
  
  for (int i = 0; i < width; i += 50)
    line(i, 0, i, height);
  for (int i = 0; i < height; i += 50)
    line(0, i, width, i);
  
  stroke(255, 0, 0);
  strokeWeight(1);
  int yPosPrev= 0, xPosPrev = 0;
  
  println(data);
  
  //Arraywert nach links verschieben
  for (int x = 1; x < width; x++)
    yPos[x-1] = yPos[x];
    
  //Anhängen des neuen Wertes
  yPos[width-1] = serialValue;
  
  for (int x = 0; x < width; x++) {
    if (x > 0)
      line(xPosPrev, yPosPrev, x, yPos[x]);
    
    xPosPrev = x;
    yPosPrev = yPos[x];
  }
}

void serialEvent (Serial serialPort) {
  String portStream = serialPort.readString();
  data = float(portStream);
  //println(data);
  serialValue = height - (int) map(data, 0, 1023, 0, height);
}
