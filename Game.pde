final int Milenium = 40000;
final int Epoch = 2000;

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

int today;
int score;
PImage World;
Player Pixel;
Robot Ghost;
boolean reset;
IntDict Level = new IntDict();
IntDict Total = new IntDict();
ArrayList<Shoot> Shoots = new ArrayList<Shoot>();
ArrayList<Anime> Animes = new ArrayList<Anime>();

void draw()
{
  if (reset)
    if (Total.get("W", 0) == 20) {
      gameover();
      return;
    } else reset();
  image(World, 0, 0);
  animes();
  player();
  shoots();
  progress();
  saveFrame("static/#######.png");
  if (frameCount % Epoch == 0) reset = true;
  if (frameCount == Milenium) gameover();
  println(frameCount);
}

void keyPressed()
{
  switch (key) {
  case BACKSPACE:
    reset = true;
    redraw();
    return;
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
  case '1':
    Pixel.shoot(1);
    break;
  case '2':
    Pixel.shoot(2);
    break;
  case '3':
    Pixel.shoot(3);
    break;
  case '4':
    Pixel.shoot(4);
    break;
  case '5':
    Pixel.shoot(5);
    break;
  case '6':
    Pixel.shoot(6);
    break;
  case '7':
    Pixel.shoot(7);
    break;
  case '8':
    Pixel.shoot(8);
    break;
  case '9':
    Pixel.shoot(9);
    break;
  default:
    break;
  }
}

void reset()
{
  reset = false;
  for (Anime anime : Animes)
    score -= anime.value;
  mkworld();
  mkanime();
  mkgame();
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
  World = loadImage("myworld.tif");
  Total.increment("W");
}

void mkanime()
{
  Animes.clear();
  for (int i = 0; i < 1; i++)
    Animes.add(new Fox());
  for (int i = 0; i < 3; i++)
    Animes.add(new Bird());
  for (int i = 0; i < 5; i++)
    Animes.add(new Deer());
  for (int i = 0; i < 10; i++)
    Animes.add(new Rabit());
  for (int i = 0; i < 15; i++)
    Animes.add(new Fish());
  if (Total.get("W", 0) > 10)
    for (int g = 0; g < 3; g++)
      Animes.add(new Frog());
}

void mkgame()
{
  //noLoop();
  Level.clear();
  Shoots.clear();
  Pixel = new Player();
  Ghost = new Robot(Pixel);
  if (Total.get("W", 0) == 1) today = millis();
}

void player()
{
  if (Pixel.x < 0 && Pixel.y < 0) {
    Pixel.init();
    if (Total.get("R", 0) >= 25) Pixel.shooting = max(Width, Hight);
    if (Total.get("D", 0) >= 20) Pixel.climbing = true;
    if (Total.get("F", 0) >= 50) Pixel.swiming = true;
    if (Total.get("B", 0) >= 30) Pixel.flying = true;
  } else {
    if (Level.get("D", 0) >= 3) Pixel.climbing = true;
    if (Level.get("F", 0) >= 5) Pixel.swiming = true;
    Pixel.show();
  }
  Ghost.update();
}

void shoots()
{
  boolean frog = false;
  for (int s = Shoots.size() - 1; s >= 0; s--) {
    Shoot shoot = Shoots.get(s);
    shoot.move();
    shoot.show();
    if (shoot.dd > Pixel.shooting) {
      Shoots.remove(s);
      continue;
    }
    if (pixel(shoot.x, shoot.y) == empty) {
      for (Anime anime : Animes)
        if (anime.type == 'G'
          && anime.x == Pixel.x
          && anime.y == Pixel.y) {
          frog = true;
          break;
        }
      if (!frog) {
        Shoots.remove(s);
        continue;
      }
    }
    if (shoot.x < 0 || shoot.x >= Width
      || shoot.y < 0 || shoot.y >= Hight) {
      Shoots.remove(s);
      continue;
    }
    for (int a = Animes.size() - 1; a >= 0; a--) {
      Anime anime = Animes.get(a);
      if (shoot.x >= anime.x && shoot.x < anime.x+anime.size
        && shoot.y >= anime.y && shoot.y < anime.y+anime.size) {
        if (anime.type == 'X') Total.increment("X");
        Shoots.remove(s);
        anime.lives -= 1;
        if (anime.lives == 0) {
          score += anime.value;
          switch (anime.type) {
          case 'R':
            Pixel.shooting *= 2;
            Total.increment("R");
            break;
          case 'F':
            Level.increment("F");
            Total.increment("F");
            break;
          case 'D':
            Level.increment("D");
            Total.increment("D");
            break;
          case 'B':
            Total.increment("B");
            break;
          case 'X':
            gameover();
            return;
          default:
            break;
          }
          Animes.remove(a);
        }
        break;
      }
    }
  }
}

void animes()
{
  Anime Fox = Animes.get(0);
  for (int a = Animes.size() - 1; a >= 0; a--) {
    Anime anime = Animes.get(a);
    if (anime.type == 'R'
      && anime.x == Fox.x
      && anime.y == Fox.y) {
      score += anime.value;
      Animes.remove(a);
      continue;
    }
    if (frameCount % anime.update == 0)
      if (anime.type == 'G')
        for (int g = 0; g < 100; g++)
          anime.move();
      else anime.move();
    if (anime.x < 0 || anime.x >= Width
      || anime.y < 0 || anime.y >= Hight) {
      score -= anime.value;
      Animes.remove(a);
    } else anime.show();
  }
}

void progress()
{
  fill(color(rabit, 96));
  rect(000, Hight, 10*25, 15);
  fill(color(rabit));
  rect(000, Hight, 10*min(Total.get("R", 0), 25), 15);
  fill(color(fish, 96));
  rect(250, Hight, 10*50, 15);
  fill(color(252, 234, 79));
  rect(250, Hight, 10*min(Total.get("F", 0), 50), 15);
  fill(color(deer, 96));
  rect(750, Hight, 10*20, 15);
  fill(color(deer));
  rect(750, Hight, 10*min(Total.get("D", 0), 20), 15);
  fill(color(bird, 96));
  rect(950, Hight, 10*30, 15);
  fill(color(bird));
  rect(950, Hight, 10*min(Total.get("B", 0), 30), 15);
  fill(color(255, 96));
  rect(1250, Hight, 10*20, 15);
  fill(color(255));
  rect(1250, Hight, 10*min(Total.get("W", 0), 20), 15);
  fill(color(fox, 96));
  rect(1450, Hight, 10*5, 15);
  fill(color(fox));
  rect(1450, Hight, 10*min(Total.get("X", 0), 5), 15);
}

color pixel(int x, int y) {
  return World.get(x, y);
}

void gameover()
{
  //noLoop();
  reset = true;
  int dt = (millis() - today) / 1000;
  Pixel = new Player();
  player();
  for (Anime anime : Animes) score -= anime.value;
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
  text("Score: "+str(score)+"  Level: "+str(Total.get("W")), 
    0.2*width, 0.4*height, 0.6*width, 0.2*height);
  text("Time: "+str(dt/60)+" min "+str(dt%60)+" sec", 
    0.2*width, 0.6*height, 0.6*width, 0.2*height);
  saveFrame("static/0x#######.png");
  Animes.clear();
  Total.clear();
  score = 0;
  exit();
  return;
}
