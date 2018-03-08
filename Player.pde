class Player
{
  int x = -99;
  int y = -99;
  final int size = 25;
  final color kolor = color(255);
  boolean flying = false;
  boolean swiming = false;
  boolean climbing = false;
  int shooting;

  void init()
  {
    shooting = 75;
    boolean ok = false;
    while (!ok) {
      int xx = int(random(Width-size) / size) * size;
      int yy = int(random(Hight-size) / size) * size;
      if (pixel(xx, yy) == grass) {
        ok = true;
        x = xx;
        y = yy;
      }
    }
  }

  void show()
  {
    fill(kolor);
    pushMatrix();
    translate(x+size/2, y+size/2);
    rotate(QUARTER_PI);
    rectMode(CENTER);
    rect(0, 0, size, size);
    rectMode(CORNER);
    popMatrix();
  }

  void move(char mm)
  {
    int xx = x;
    int yy = y;
    switch (mm) {
    case 'a':
      xx -= size;
      break;
    case 'A':
      xx -= 5 * size;
      break;
    case 'd':
      xx += size;
      break;
    case 'D':
      xx += 5 * size;
      break;
    case 's':
      yy += size;
      break;
    case 'S':
      yy += 5 * size;
      break;
    case 'w':
      yy -= size;
      break;
    case 'W':
      yy -= 5 * size;
      break;
    default:
      break;
    }
    if (xx < 0) xx += Width;
    if (yy < 0) yy += Hight;
    if (xx >= Width) xx -= Width;
    if (yy >= Hight) yy -= Hight;
    color cc = pixel(xx, yy);
    if ((cc == grass)
      || (cc == empty && flying)
      || (cc == water && swiming)
      || (cc == trees && climbing)) {
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
      return;
    }
    if (Shoots.size() == 8) return;
    else score -= 1;
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
