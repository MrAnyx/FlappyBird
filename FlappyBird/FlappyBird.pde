/* -------------------- idée de consigne ------------------- */
/*                                                           */
/* faire apparaitre l'oiseau a une certaine position initial */
/*               changer la vitesse des tubes                */
/*                changer l'image de l'oiseau                */
/*               changer la touche pour sauter               */
/*          changer la couleur du fond (ciel, herbe)         */
/* --------------------------------------------------------- */


float x=75;  //position initial en X de l'oiseau
float y = 2*(600/3);  //position initial en Y de l'oiseau
float speed;  //vitesse de l'oiseau a chaque saut
float angle;  //angle par rapport a l'horizontal vers lequel l'oiseau saute 
float ySpeed;  //vitesse en y de l'oiseau (Newton)
float accel = 0;  //acceleration de l'oiseau pour simuler la gravite (Newton)

PImage bird;  //declaration de l'image de l'oiseau
PImage tube;  //declaration de l'image des tubes

int[] tab_tubeX = new int[2];  //tableau comportant les positions en X des tubes
int[] tab_tubeY = new int[2];  //tableau comportant les positions en Y des tubes

int move_tube = 0;  //vitesse des tubes en X
int score = 0;  //variable utile pour les scores

boolean over = false;  //variable pour la fin de partie

PFont font;


void setup() {
  size(500, 750);  //taille de la fenetre
  font = createFont("Montserrat",50);
  textFont(font);
  textAlign(CENTER, CENTER);  //alignement du texte au centre
  noStroke();  //pas de contours pour les formes

  angle = 90;  //angle du jump
  speed = 12;  //vitesse de l'oiseau pendant les sauts

  bird = loadImage("bird.png");  //importation de l'image de l'oiseau
  tube = loadImage("tube.png");  //importation de l'image de tube

  for (int i = 0; i<2; i++) {//initialisation des deux premiers tubes
    tab_tubeX[i] = i*575/2 + 300;  //initialisation des valeurs en X des tubes
    tab_tubeY[i] = int(random(-550, -350));  //initialisation des valeurs en Y des tubes
  }
}

void draw() {
  if (!over) { //tant que la partie n'est pas perdu
    fill(130, 210, 230);  //couleur du ciel
    rect(0, 0, 500, 750);  //ciel

    ySpeed -= accel; //variation de la valeurs de la vitesse de l'oiseau
    y -= ySpeed;  //variation de la position de l'oiseau

    image(bird, x, y, 60, 50); //affichage de l'oiseau



    for (int j = 0; j<2; j++) {  //boucle qu passe dans tout les tubes
      image(tube, tab_tubeX[j], tab_tubeY[j], 78, 1500);  //affichage des tubes
      tab_tubeX[j] = tab_tubeX[j] - move_tube;  //variation de la position en X des tubes
      if (tab_tubeX[j]<-75) {  //si un tubes arrive a gauche, elle repart a droite
        tab_tubeX[j] = tab_tubeX[j]+570;
        tab_tubeY[j] = int(random(-550, -350));  //lorsque un tube apparait a droite, il change de hauteur
        score++;//le score augmente de 1
      }
    }
    fill(50, 140, 75);  //couleur de l'herbe
    rect(0, 600, 500, 150);  //herbe verte

    for (int j = 0; j<2; j++) {  //test collisions avec les tubes
      if (((x+55 > tab_tubeX[j]) && (y+2 < tab_tubeY[j] + 642) && (x<tab_tubeX[j] + 78)) || ((x+58 > tab_tubeX[j]) && (y+48 > tab_tubeY[j]+843) && (x<tab_tubeX[j]+78))) {
        over = true;  //si l'oiseau touche un tube, c'est perdu
      }
    }
    if (y+50>600 ||y<0) {  //test collisions avec haut et bas
      over = true;  //si l'oiseau touche la bordure haute ou basse
    }

    fill(255);  //blanc
    textSize(50);  //taille du texte pour afficher le score
    text(score, width/2, 55);  //score final

  } else { //si la partie est perdu

    noLoop();  //on stoppe la boucle du programme
    fill(0, 200); //couleur noir en transparence
    rect(0, 0, 500, 750);
    fill(255);
    
    text("Score", 255, 255 );
    text(score, 255, 370);  //affichage du score
    textSize(30);
    text("ESPACE pour recommencer", 250,530);
  }
}
 
void keyPressed() {
  if (key == ' ' && over == false) {  //test si la barre espace est pressée ET que la partie n'est pas perdu
    ySpeed = speed * sin(radians(angle));  //loi de Newton pour la variation en y de l'oiseau
    accel = 0.6;
    move_tube = 2;  //deplacement des tubes
  }
  if (key == ' ' && over == true) {  //test si la barre espace est pressée ET que la partie est perdu
    loop();  //on recommence a boucler le programme
    x=75;  //on réinitialise les valeurs
    y = 2*(600/3);  //on réinitialise les valeurs
    ySpeed = 0;  //on réinitialise les valeurs
    accel = 0;  //on réinitialise les valeurs
    move_tube = 0;  //on réinitialise les valeurs
    score = 0;  //on réinitialise les valeurs
    over = false;  //on réinitialise les valeurs
    for (int i = 0; i<2; i++) {//initialisation des deux premiers tubes
      tab_tubeX[i] = i*575/2 + 300;  //on réinitialise les valeurs
      tab_tubeY[i] = int(random(-550, -350));  //on réinitialise les valeurs
    }
  }
}