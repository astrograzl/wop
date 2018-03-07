class Player
{
  int x = -99;
  int y = -99;
  final int s = 25;
  final color c = color(255);
  boolean swiming = false;
  boolean climbing = false;
  int shooting = 75;

  void init()
  {
    loadPixels();
    boolean ok = false;
    while (!ok) {
      int ww = int(sqrt(pixels.length));
      int xx = int(random(ww-s) / s) * s;
      int yy = int(random(ww-s) / s) * s;
      if (pixel(xx, yy) == grass) {
        ok = true;
        x = xx;
        y = yy;
      }
    }
  }

  void show()
  {
    fill(c);
    pushMatrix();
    translate(x+s/2, y+s/2);
    rotate(QUARTER_PI);
    rectMode(CENTER);
    rect(0, 0, s, s);
    rectMode(CORNER);
    popMatrix();
  }

  void move(char mm)
  {
    int xx = x;
    int yy = y;
    switch (mm) {
    case 'a': 
      xx -= s;  
      break;
    case 'd': 
      xx += s; 
      break;
    case 's':
      yy += s; 
      break;
    case 'w': 
      yy -= s; 
      break;
    default: 
      break;
    }
    loadPixels();
    int ww = int(sqrt(pixels.length));
    if (xx < 0) xx += ww;
    if (yy < 0) yy += ww;
    if (xx >= ww) xx -= ww;
    if (yy >= ww) yy -= ww;
    color cc = pixel(xx, yy);
    if ((cc == grass || cc == empty)
      || (cc == water && swiming)
      || (cc == rocks && climbing)) {
      x = xx;
      y = yy;
    }
  }

  void shoot(int sh)
  {
    if (sh == 5 && Shoots.size() <= 4) {
      shoot(4);
      shoot(6);
      shoot(2);
      shoot(8);
    }
    if (Shoots.size() == 8) return;
    else Score -= 1;
    switch (sh) {
    case 4:
      Shoots.add(new Shoot(x, y, -1, 0)); 
      break;
    case 6: 
      Shoots.add(new Shoot(x, y, 1, 0)); 
      break;
    case 2: 
      Shoots.add(new Shoot(x, y, 0, 1)); 
      break;
    case 8: 
      Shoots.add(new Shoot(x, y, 0, -1)); 
      break;
    default: 
      break;
    }
  }
}