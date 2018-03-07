void setup()
{
  size(1000, 1000, P2D);
  background(empty);
  noStroke();
  mkworld();
}

int Score;
int ti, tf;
int B, D, F, R;
PImage World;
Player Pixel;
ArrayList<Deer> Deers = new ArrayList<Deer>();
ArrayList<Fish> Fishs = new ArrayList<Fish>();
ArrayList<Bird> Birds = new ArrayList<Bird>();
ArrayList<Rabit> Rabits = new ArrayList<Rabit>();
ArrayList<Shoot> Shoots = new ArrayList<Shoot>();

boolean GameOver = false;
boolean loop = true;

void draw()
{
  if (ti == -1) mkworld();
  image(World, 0, 0);
  player(); 
  shoots();
  rabits();
  deers(); 
  fishs(); 
  birds();
  if (GameOver) {
    tf = millis();
    int dt = (tf - ti) / 1000;
    print("Game Over! ");
    print("Score:", Score, "/ 132 ");
    println("Time:", dt / 60, "min", dt % 60, "sec");
    loop = false;
    noLoop();
    return;
  }
  if (B + D + F + R == 0) {
    Shoots.clear();
    GameOver = true;
  }
}

void keyPressed()
{
  if (key == BACKSPACE) {
    ti = -1;
    loop = true;
    loop();
    return;
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
  Score = 0;
  Birds.clear(); 
  B = 3;
  Deers.clear(); 
  D = 2;
  Fishs.clear(); 
  F = 5;
  Rabits.clear();
  R = 3;
  Shoots.clear();
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
    if (shoot.x < 0 || shoot.x > width
      || shoot.y < 0 || shoot.y > height)
      Shoots.remove(s);
  }
}

void rabits()
{
  while (Rabits.size() < R)
    Rabits.add(new Rabit());
  for (int r = 0; r < Rabits.size(); r++) {
    Rabit rabit = Rabits.get(r);
    if (frameCount % 3 == 0)
      rabit.move();
    rabit.show();
    if (rabit.x < 0 || rabit.x >= width
      || rabit.y < 0 || rabit.y >= height) {
      Rabits.remove(r);
      Score -= 5;
      R--;
    }
    for (int s = 0; s < Shoots.size(); s++) {
      Shoot shoot = Shoots.get(s);
      if (shoot.x >= rabit.x && shoot.x < rabit.x+rabit.s
        && shoot.y >= rabit.y && shoot.y < rabit.y+rabit.s) {
        Pixel.shooting *= 2;
        Shoots.remove(s);
        Rabits.remove(r);
        Score += 5;
        R--;
      }
    }
  }
}

void deers()
{
  while (Deers.size() < D)
    Deers.add(new Deer());
  for (int d = 0; d < Deers.size(); d++) {
    Deer deer = Deers.get(d);
    if (frameCount % 100 == 0)
      deer.move();
    deer.show();
    if (deer.x < 0 || deer.x >= width
      || deer.y < 0 || deer.y >= height) {
      Deers.remove(d);
      Score -= 15;
      D--;
    }
    for (int s = 0; s < Shoots.size(); s++) {
      Shoot shoot = Shoots.get(s);
      if (shoot.x >= deer.x && shoot.x < deer.x+deer.s
        && shoot.y >= deer.y && shoot.y < deer.y+deer.s) {
        Pixel.climbing = true;
        Shoots.remove(s);
        Deers.remove(d);
        Score += 15;
        D--;
      }
    }
  }
}

void fishs()
{
  while (Fishs.size() < F)
    Fishs.add(new Fish());
  for (int f = 0; f < Fishs.size(); f++) {
    Fish fish = Fishs.get(f);
    if (frameCount % 50 == 0)
      fish.move();
    fish.show();
    if (fish.x < 0 || fish.x >= width
      || fish.y < 0 || fish.y >= height) {
      Fishs.remove(f);
      Score -= 5;
      F--;
    }
    for (int s = 0; s < Shoots.size(); s++) {
      Shoot shoot = Shoots.get(s);
      if (shoot.x >= fish.x && shoot.x < fish.x+fish.s
        && shoot.y >= fish.y && shoot.y < fish.y+fish.s) {
        Pixel.swiming = true;
        Shoots.remove(s);
        Fishs.remove(f);
        Score += 5;
        F--;
      }
    }
  }
}

void birds()
{
  while (Birds.size() < B)
    Birds.add(new Bird());
  for (int b = 0; b < Birds.size(); b++) {
    Bird bird = Birds.get(b);
    if (frameCount % 5 == 0)
      bird.move();
    bird.show();
    if (bird.x < 0 || bird.x >= width
      || bird.y < 0 || bird.y >= height)
      Birds.remove(b);
    for (int s = 0; s < Shoots.size(); s++) {
      Shoot shoot = Shoots.get(s);
      if (shoot.x >= bird.x && shoot.x < bird.x+bird.sx
        && shoot.y >= bird.y && shoot.y < bird.y+bird.sy) {
        Shoots.remove(s);
        Birds.remove(b);
        Score += 25;
        B--;
      }
    }
  }
}