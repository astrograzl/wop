final int Width = 1500;
final int Hight = 1000;

void setup()
{
  size(1500, 1015, P2D);
  ellipseMode(CORNER);
  rectMode(CORNER);
  noStroke();
  mkworld();
  mkanime();
  mkgame();
}

int score;
PImage World;
Player Pixel;
boolean reset;
boolean GameOver;
IntDict Scores = new IntDict();
ArrayList<Shoot> Shoots = new ArrayList<Shoot>();
ArrayList<Animal> Animals = new ArrayList<Animal>();

void draw()
{
  if (reset) {
    reset = false;
    mkworld();
    mkanime();
    mkgame();
  }
  image(World, 0, 0);
  player();
  shoots();
  animals();
  progress();
}

void keyPressed()
{
  if (key == BACKSPACE) {
    reset = true;
    redraw();
    return;
  }
  if (!GameOver)
    switch (key) {
    case ENTER:
    case RETURN:
      loop();
      break;
    case 'a':
      Pixel.move('a');
      break;
    case 'A':
      Pixel.move('A');
      break;
    case 'd':
      Pixel.move('d');
      break;
    case 'D':
      Pixel.move('D');
      break;
    case 's':
      Pixel.move('s');
      break;
    case 'S':
      Pixel.move('S');
      break;
    case 'w':
      Pixel.move('w');
      break;
    case 'W':
      Pixel.move('W');
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
  Scores.increment("W");
}

void mkanime()
{
  for (Animal animal : Animals)
    score -= animal.value;
  Scores.remove("X");
  Animals.clear();
  for (int i = 0; i < 1; i++)
    Animals.add(new Fox());
  for (int i = 0; i < 3; i++)
    Animals.add(new Bird());
  for (int i = 0; i < 5; i++)
    Animals.add(new Deer());
  for (int i = 0; i < 10; i++)
    Animals.add(new Rabit());
  for (int i = 0; i < 15; i++)
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
    if (Scores.get("R", 0) >= 25) Pixel.shooting = max(Width, Hight);
    if (Scores.get("D", 0) >= 20) Pixel.climbing = true;
    if (Scores.get("F", 0) >= 50) Pixel.swiming = true;
    if (Scores.get("B", 0) >= 30) Pixel.flying = true;
  } else {
    Pixel.show();
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
        if (animal.type == 'X') Scores.increment("X");
        animal.lives -= 1;
        Shoots.remove(s);
        if (animal.lives == 0) {
          score += animal.value;
          switch (animal.type) {
          case 'R':
            Pixel.shooting *= 2;
            Scores.increment("R");
            break;
          case 'F':
            Scores.increment("F");
            break;
          case 'D':
            Scores.increment("D");
            break;
          case 'B':
            Scores.increment("B");
            break;
          case 'X':
            gameover();
            return;
          default:
            break;
          }
          Animals.remove(a);
        }
        break;
      }
    }
  }
}

void animals()
{
  if (Animals.isEmpty()) return;
  Animal Fox = Animals.get(0);
  for (int a = Animals.size() - 1; a >= 0; a--) {
    Animal animal = Animals.get(a);
    if (animal.type == 'R'
      && animal.x == Fox.x
      && animal.y == Fox.y) {
      score += animal.value;
      Animals.remove(a);
      continue;
    }
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

void progress()
{
  fill(color(rabit, 96));
  rect(000, Hight, 10*25, 15);
  fill(color(rabit));
  rect(000, Hight, 10*min(Scores.get("R", 0), 25), 15);
  fill(color(fish, 96));
  rect(250, Hight, 10*50, 15);
  fill(color(252, 234, 79));
  rect(250, Hight, 10*min(Scores.get("F", 0), 50), 15);
  fill(color(deer, 96));
  rect(750, Hight, 10*20, 15);
  fill(color(deer));
  rect(750, Hight, 10*min(Scores.get("D", 0), 20), 15);
  fill(color(bird, 96));
  rect(950, Hight, 10*30, 15);
  fill(color(bird));
  rect(950, Hight, 10*min(Scores.get("B", 0), 30), 15);
  fill(color(255, 96));
  rect(1250, Hight, 10*20, 15);
  fill(color(255));
  rect(1250, Hight, 10*min(Scores.get("W", 0), 20), 15);
  fill(color(fox, 96));
  rect(1450, Hight, 10*5, 15);
  fill(color(fox));
  rect(1450, Hight, 10*min(Scores.get("X", 0), 5), 15);
  if (Scores.get("W", 0) == 20) gameover();
}

color pixel(int x, int y) {
  return World.get(x, y);
}

void gameover()
{
  noLoop();
  int dt = millis() / 1000;
  for (Animal animal : Animals) score -= animal.value;
  if (Pixel.shooting >= max(Width, Hight)) score += 100;
  if (Pixel.climbing) score += 100;
  if (Pixel.swiming) score += 100;
  if (Pixel.flying) score += 100;
  fill(empty, 224);
  rect(0, 0, width, height);
  fill(52, 101, 192);
  textAlign(CENTER);
  textSize(96);
  text("Game Over!", 
    0.2*width, 0.2*height, 0.6*width, 0.2*height);
  textSize(64);
  text("Score: "+str(score)+" Level: "+str(Scores.get("W")), 
    0.2*width, 0.4*height, 0.6*width, 0.2*height);
  text("Time: "+str(dt/60)+" min "+str(dt%60)+" sec", 
    0.2*width, 0.6*height, 0.6*width, 0.2*height);
  GameOver = true;
  Animals.clear();
  Scores.clear();
  return;
}