final int Width = 1000;
final int Hight = 1000;

void setup()
{
  size(1000, 1000, P2D);
  ellipseMode(CORNER);
  rectMode(CORNER);
  noStroke();
  mkworld();
  mkanime();
  mkgame();
}

int score;
int ti, tf;
PImage World;
Player Pixel;
boolean GameOver;
ArrayList<Shoot> Shoots = new ArrayList<Shoot>();
ArrayList<Animal> Animals = new ArrayList<Animal>();

void draw()
{
  if (ti == -1) {
    mkworld();
    mkanime();
    mkgame();
  }
  image(World, 0, 0);
  player(); 
  shoots();
  animals();
  if (Animals.size() == 0) {
    gameover();
  }
}

void keyPressed()
{
  if (key == BACKSPACE) {
    ti = -1;
    redraw();
    return;
  }
  if (!GameOver)
    switch (key) {
    case ENTER:
    case RETURN:
      ti = millis();
      loop();
      break;
    case 'a': 
      Pixel.move('a'); 
      break;
    case 'd': 
      Pixel.move('d'); 
      break;
    case 's': 
      Pixel.move('s'); 
      break;
    case 'w': 
      Pixel.move('w'); 
      break;
    case '4': 
      Pixel.shoot(4); 
      break;
    case '6': 
      Pixel.shoot(6); 
      break;
    case '2': 
      Pixel.shoot(2); 
      break;
    case '8': 
      Pixel.shoot(8); 
      break;
    case '5':
      Pixel.shoot(5);
      break;
    default: 
      break;
    }
}

void mkworld()
{
  background(empty);
  for (int b = 0; b < Blocks.length; b++) {
    Blocks[b].init();
    for (int s = 0; s < Steps[b]; s++)
      Blocks[b].step();
  }
  save("world.tif");
  World = loadImage("world.tif");
}

void mkanime()
{
  Animals.clear();
  for (int i = 0; i < 1; i++)
    Animals.add(new Fox());
  for (int i = 0; i < 2; i++)
    Animals.add(new Deer());
  for (int i = 0; i < 3; i++)
    Animals.add(new Rabit());
  for (int i = 0; i < 3; i++)
    Animals.add(new Bird());
  for (int i = 0; i < 5; i++)
    Animals.add(new Fish());
}

void mkgame()
{
  noLoop();
  score = 0;
  Shoots.clear();
  Pixel = new Player();
  GameOver = false;
}

void player()
{
  if (Pixel.x < 0 && Pixel.y < 0) {
    Pixel.init();
  } else {
    Pixel.show();
    if (pixel(Pixel.x, Pixel.y) == empty)
      gameover();
  }
} 

void shoots()
{
  for (int s = Shoots.size() - 1; s >= 0; s--) {
    Shoot shoot = Shoots.get(s);
    shoot.move();
    shoot.show();
    if (shoot.dd > Pixel.shooting) {
      Shoots.remove(s); 
      continue;
    }
    if (pixel(shoot.x, shoot.y) == empty) {
      Shoots.remove(s); 
      continue;
    }
    if (shoot.x < 0 || shoot.x >= Width
      || shoot.y < 0 || shoot.y >= Hight) {
      Shoots.remove(s); 
      continue;
    }
    for (int a = Animals.size() - 1; a >= 0; a--) {
      Animal animal = Animals.get(a);
      if (shoot.x >= animal.x && shoot.x < animal.x+animal.size
        && shoot.y >= animal.y && shoot.y < animal.y+animal.size) {
        animal.lives -= 1;
        Shoots.remove(s);
      }
      if (animal.lives == 0) {
        score += animal.value;
        switch (animal.type) {
        case 'R': 
          Pixel.shooting *= 2; 
          break;
        case 'F': 
          Pixel.swiming = true;
          break;
        case 'D': 
          Pixel.climbing = true;
          break;
        default: 
          break;
        }
        Animals.remove(a);
      }
    }
  }
}

void animals()
{
  for (int a = Animals.size() - 1; a >= 0; a--) {
    Animal animal = Animals.get(a);
    if (frameCount % animal.update == 0)
      animal.move();
    animal.show();
    if (animal.x < 0 || animal.x >= Width
      || animal.y < 0 || animal.y >= Hight) {
      score -= animal.value;
      Animals.remove(a);
    }
  }
}

color pixel(int x, int y) { return World.get(x, y); }

void gameover()
{
  noLoop();
  tf = millis();
  int dt = (tf - ti) / 1000;
  for (int a = 0; a < Animals.size(); a++) {
    Animal animal = Animals.get(a);
    score -= animal.value;
  }
  fill(empty, 224);
  rect(0, 0, width, height);
  fill(52, 101, 164);
  textAlign(CENTER);
  textSize(96);
  text("Game Over!", 
    0.2*width, 0.2*height, 0.6*width, 0.2*height);
  textSize(64);
  text("Score: "+str(score), 
    0.2*width, 0.4*height, 0.6*width, 0.2*height);
  text("Time: "+str(dt/60)+" min "+str(dt%60)+" sec", 
    0.2*width, 0.6*height, 0.6*width, 0.2*height);
  GameOver = true;
  return;
}