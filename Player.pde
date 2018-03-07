class Player
{
  int x = -99;
  int y = -99;
  final int s = 25;
  final color c = color(245, 121, 0);
  boolean swiming = false;
  boolean climbing = false;
  boolean flying = false;
  int shooting = 75;

  void init()
  {
    loadPixels();
    boolean ok = false;
    while (!ok) {
      int ww = int(sqrt(pixels.length));
      int xx = int(random(ww-s) / s) * s;
      int yy = int(random(ww-s) / s) * s;
      color ci = pixels[xx+yy*ww];
      color cf = pixels[xx+s-1+(yy+s-1)*ww];
      if (ci == grass && cf == grass) {
        ok = true;
        x = xx;
        y = yy;
      }
    }
  }

  void show()
  {
    fill(c);
    rect(x, y, s, s);
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
    color ci = pixels[xx+yy*ww];
    color cf = pixels[xx+s-1+(yy+s-1)*ww];
    if (ci == empty && cf == empty) exit();
    if ((ci == grass && cf == grass)
      || (ci == water && cf == water && swiming)
      || (ci == rocks && cf == rocks && climbing)) {
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