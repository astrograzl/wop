final int Epoch = 2048;
final int Width = 1500;
final int Hight = 1000;

void setup()
{
  size(1500, 1015, P2D);
  ellipseMode(CORNER);
  rectMode(CORNER);
  frameRate(360);
  noStroke();
  newLevel();
}

int time;
int score;
PImage World;
Player Pixel;
IntDict Level = new IntDict();
IntDict Total = new IntDict();
ArrayList<Shoot> Shoots = new ArrayList<Shoot>();
ArrayList<Anime> Animes = new ArrayList<Anime>();

void keyPressed()
{
  switch (key) {
  case BACKSPACE:
    endLevel();
    noLoop();
    redraw();
    return;
  case ENTER:
  case RETURN:
    loop();
    break;
  case 'q':
    exit();
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
  case '0':
    break;
  default:
    break;
  }
}

void draw()
{
  image(World, 0, 0);
  shoots();
  animes();
  proces();
  player();
  if (frameCount % Epoch == 0)
    endLevel();
}

void newLevel()
{
  Level.clear();
  Animes.clear();
  Shoots.clear();
  Total.increment("W");
  background(empty);
  //for (int b = 0; b < Blocks.length; b++) {
  //  Blocks[b].init();
  //  for (int s = 0; s < Steps[b]; s++)
  //    Blocks[b].step();
  //}
  //save("world.tif");
  //World = loadImage("world.tif");
  World = loadImage("myworld.tif");
  for (int x = 0; x < 1; x++)
    Animes.add(new Fox());
  for (int b = 0; b < 3; b++)
    Animes.add(new Bird());
  for (int d = 0; d < 5; d++)
    Animes.add(new Deer());
  for (int r = 0; r < 10; r++)
    Animes.add(new Rabit());
  for (int f = 0; f < 15; f++)
    Animes.add(new Fish());
  if (Total.get("W", 0) > 10)
    for (int g = 0; g < 3; g++)
      Animes.add(new Frog());
  Pixel = new Robot();
}

void player()
{
  if (Total.get("R", 0) >= 25) Pixel.shooting = max(Width, Hight);
  if (Total.get("D", 0) >= 20) Pixel.climbing = true;
  if (Total.get("F", 0) >= 50) Pixel.swiming = true;
  if (Total.get("B", 0) >= 30) Pixel.flying = true;
  if (Level.get("D", 0) >= 3) Pixel.climbing = true;
  if (Level.get("F", 0) >= 5) Pixel.swiming = true;
  Pixel.update();
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
          Animes.remove(a);
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
            endGame();
            return;
          default:
            break;
          }
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

void proces()
{
  fill(color(rabit, 96));
  rect(000, Hight, 10*25, 10);
  fill(color(rabit));
  rect(000, Hight, 10*min(Total.get("R", 0), 25), 10);
  fill(color(fish, 96));
  rect(250, Hight, 10*50, 10);
  fill(color(fish));
  rect(250, Hight, 10*min(Total.get("F", 0), 50), 10);
  fill(color(deer, 96));
  rect(750, Hight, 10*20, 10);
  fill(color(deer));
  rect(750, Hight, 10*min(Total.get("D", 0), 20), 10);
  fill(color(bird, 96));
  rect(950, Hight, 10*30, 10);
  fill(color(bird));
  rect(950, Hight, 10*min(Total.get("B", 0), 30), 10);
  fill(color(255, 96));
  rect(1250, Hight, 10*20, 10);
  fill(color(255));
  rect(1250, Hight, 10*min(Total.get("W", 0), 20), 10);
  fill(color(fox, 96));
  rect(1450, Hight, 10*5, 10);
  fill(color(fox));
  rect(1450, Hight, 10*min(Total.get("X", 0), 5), 10);
  fill(color(245, 121, 0, 96));
  rect(0, Hight+10, Width, 5);
  fill(color(245, 121, 0));
  rect(0, Hight+10, frameCount%Epoch*float(Width)/float(Epoch), 5);
}

void endLevel()
{
  for (Anime anime : Animes)
    score -= anime.value;
  if (Total.get("W", 0) == 20) endGame();
  else newLevel();
}

void endGame()
{
  int time = millis() / 1000;
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
  text("Time: "+str(time/60)+" min "+str(time%60)+" sec",
    0.2*width, 0.6*height, 0.6*width, 0.2*height);
  saveFrame("GameOver.png");
  exit();
}

color pixel(int x, int y) {
  return World.get(x, y);
}
