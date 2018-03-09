class Anime
{
  char type;
  int x, y;
  int size;
  int lives;
  int value;
  int update;
  color kolor;
  color medium;

  Anime(int s, color m)
  {
    size = s;
    medium = m;
    boolean ok = false;
    while (!ok) {
      int xx = int(random(Width-size) / size) * size;
      int yy = int(random(Hight-size) / size) * size;
      color ci = pixel(xx, yy);
      color cf = pixel(xx+size-1, yy+size-1);
      if (medium == black || (ci == medium && cf == medium)) {
        ok = true;
        x = xx;
        y = yy;
      }
    }
  }

  void show()
  {
    fill(kolor);
    rect(x, y, size, size);
  }

  void move()
  {
    int xx = x;
    int yy = y;
    int dd = floor(random(3)) - 1;
    if (random(2) < 1) xx += size * dd;
    else yy += size * dd;
    if (xx >= 0 && xx < Width && yy >= 0 && yy < Hight) {
      color ci = pixel(xx, yy);
      color cf = pixel(xx+size-1, yy+size-1);
      if (ci == medium && cf == medium) {
        x = xx;
        y = yy;
      }
    } else {
      x = xx;
      y = yy;
    }
  }
}