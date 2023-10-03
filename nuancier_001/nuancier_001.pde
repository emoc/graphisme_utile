/*
  Fabrication d'un nuancier, à partir d'un tableau de couleurs
 
 Quimper, Dour Ru, 20231003 / emoc, pierre@lesporteslogiques.net
 Processing 4.0b2 @ kirin / Debian Stretch 9.5
 
 Les PDF sont créés à 72 dpi, pour un A4 : 595 x 842
 */

// paramètres du script
boolean CREATE_PDF = true;

import processing.pdf.*;

// fonctions de dates pour l'export d'images de log
import java.util.Date;
import java.text.SimpleDateFormat;
String SKETCH_NAME = getClass().getSimpleName();

// Tableau de couleurs
color[] colors = {
  #5D12D2, #B931FC, #FF6AC2, #FFE5E5, #362FD9, #1AACAC, #2E97A7, #6499E9, #9EDDFF,
  #A6F6FF, #BEFFF7, #5B0888, #713ABE, #9D76C1, #E5CFF7, #27005D, #9400FF, #AED2FF,
  #0E21A0, #4D2DB7, #9D44C0, #793FDF, #7091F5, #97FFF4, #614BC3, #33BBC5, #85E6C5,
  #C8FFE0, #6F61C0, #A084E8, #8BE8E5, #6528F7, #A076F9, #6527BE, #9681EB, #45CFDD  };
int nb_colors;
int index_colors = 0;



void setup() {
  size(595, 842);
  nb_colors = colors.length;
  println("nb colors : " + nb_colors);
  noLoop();
  beginRecord(PDF, "nuancier.pdf");
}

void draw() {

  // Combien de lignes et colonnes ? (c'est surement possible de faire mieux)
  float nb1 = sqrt((float)nb_colors);
  float colonnes = ceil(nb1 * width / height);
  float lignes = ceil(nb1 * height / width);
  println("nb1 : " + nb1 + " / colonnes : " + colonnes + " / lignes : " + lignes);

  for (int col = 0; col < colonnes; col++) {
    for (int lig = 0; lig < lignes; lig++) {
      index_colors = int(lig * colonnes + col);
      if (index_colors < colors.length) { // Afin de ne pas dépasser le max de couleurs
        float x = width / colonnes * col;
        float y = height / lignes * lig;
        noStroke();
        fill(colors[index_colors]);
        rect(x, y, width / colonnes, height / lignes);
        textAlign(CENTER, CENTER);
        if (brightness(colors[index_colors]) > 150) fill(0);
        else fill(255);
        textSize(width / 30);
        String hx = "#" + hex(colors[index_colors], 6);
        text(hx, x + width / colonnes / 2, y + height / lignes / 2);
      }
    }
  }
  endRecord();
}

void keyPressed() {
  if (key == 's') {
    Date now = new Date();
    SimpleDateFormat formater = new SimpleDateFormat("yyyyMMdd_HHmmss");
    System.out.println(formater.format(now));
    saveFrame(SKETCH_NAME + "_" + formater.format(now) + ".png");
  }
}
