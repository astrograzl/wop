class Animal
{
  char type;
  int x, y;
  int size;
  int lives;
  int value;
  int update;
  color kolor;
  color medium;

  Animal(int s, color m)
  {
    size = s;
    medium = m;
    loadPixels();
    boolean ok = false;
    while (!ok) {
      int ww = int(sqrt(pixels.length));
      int xx = int(random(ww-size) / size) * size;
      int yy = int(random(ww-size) / size) * size;
      color ci = pixel(xx, yy);
      color cf = pixel(xx+size-1, yy+size-1);
      if (medium == empty || (ci == medium && cf == medium)) {
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
    loadPixels();
    int xx = x;
    int yy = y;
    int dd = floor(random(3)) - 1;
    int ww = int(sqrt(pixels.length));
    if (random(2) < 1) xx += size * dd;
    else yy += size * dd;
    if (xx >= 0 && xx < ww && yy >= 0 && yy < ww) {      
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