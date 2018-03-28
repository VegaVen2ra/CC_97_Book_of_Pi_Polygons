// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain

// Book of Pi 1
// https://youtu.be/tbvG9hrJxOU

import processing.pdf.*;

String pi;

void setup() {
  size(850, 1150, PDF, "bookofpi-1million-polygons.pdf");
  PGraphicsPDF pdf = (PGraphicsPDF) g;  // Get the renderer
  pi = loadStrings("pi-1million.txt")[0];

  int cols = 80;
  int rows = 80;

  float w = float(width)/cols;
  float h = float(height)/rows;
  
  int index = 0;
  int pageNum = 1;
  float radius = 0.8 * min(w, h) / 2;
  int margin = 100;

  background(255);
  while(true) {
    for (float y = margin + h / 2; y <= height - margin - h / 2; y += h) {
      for (float x = margin + w / 2; x <= width - margin - w / 2; x += w) {
        String s = "" + pi.charAt(index);
        int digit = int(s);
        float angle = TWO_PI / digit;

        stroke(0);
        noFill();
        
        if (digit == 1) {
          point(x, y);
        } else {
          beginShape();
          for (int k = 0; k < digit; k++) {
            vertex(x + radius * sin((k + 0.5)* angle), y + radius * cos((k + 0.5) * angle));
          }
          endShape(CLOSE);
        }

        index++;
        if (index >= pi.length()) {
          println("Finished");
          return;
        }
      }
    }
    println("Page " + pageNum + " complete!");
    pdf.nextPage();
    pageNum++;
  }
}
