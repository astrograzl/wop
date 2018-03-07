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

int Score;
int ti, tf;
PImage World;
Player Pixel;
ArrayList<Shoot> Shoots = new ArrayList<Shoot>();
ArrayList<Animal> Animals = new ArrayList<Animal>();
boolean GameOver = false;
boolean loop = true;

void draw()
{
  if (ti == -1) {
    mkworld();
    mkanime();
    mkgame();
  }
  image(World, 0, 0);
  animals();
  player(); 
  shoots();
  if (Animals.size() == 0) {
    gameover();
  }
}

void keyPressed()
{
  if (key == BACKSPACE) {
    ti = -1;
    redraw();
  } else if (!GameOver && (key == RETURN || key == ENTER)) {
    loop = true;
    loop();
    return;
  }
  if (loop)
    switch (key) {
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
  loadPixels();
  World = loadImage("world.tif");
  updatePixels();
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
  Score = 0;
  Pixel = new Player();
  GameOver = false;
  ti = millis();
  loop = false;
  noLoop();
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
  for (int s = 0; s < Shoots.size(); s++) {
    Shoot shoot = Shoots.get(s);
    shoot.move();
    shoot.show();
    if (shoot.dd > Pixel.shooting)
      Shoots.remove(s);
    if (pixel(shoot.x, shoot.y) == empty)
      Shoots.remove(s);
    if (shoot.x < 0 || shoot.x > width
      || shoot.y < 0 || shoot.y > height)
      Shoots.remove(s);
    for (int a = 0; a < Animals.size(); a++) {
      Animal animal = Animals.get(a);
      if (shoot.x >= animal.x && shoot.x < animal.x+animal.size
        && shoot.y >= animal.y && shoot.y < animal.y+animal.size) {
        animal.lives -= 1;
        Shoots.remove(s);
      }
      if (animal.lives == 0) {
        Score += animal.value;
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
  for (int a = 0; a < Animals.size(); a++) {
    Animal animal = Animals.get(a);
    if (frameCount % animal.update == 0)
      animal.move();
    animal.show();
    if (animal.x < 0 || animal.x >= width
      || animal.y < 0 || animal.y >= height) {
      Score -= animal.value;
      Animals.remove(a);
    }
  }
}

color pixel(int x, int y)
{
  return World.get(x, y);
}

void gameover()
{
  tf = millis();
  int dt = (tf - ti) / 1000;
  for (int a = 0; a < Animals.size(); a++) {
    Animal animal = Animals.get(a);
    Score -= animal.value;
  }
  Shoots.clear();
  print("Game Over! ");
  print("Score:", Score);
  println(" Time:", dt / 60, "min", dt % 60, "sec");
  loop = false;
  noLoop();
  fill(empty, 192);
  rect(0, 0, width, height);
  GameOver = true;
  return;
}