class Shoot
{
  int x, y;
  int dx, dy;
  int dd = 0;
  final int size = 3;
  final color kolor = color(238, 238, 236);

  Shoot(int x0, int y0, int dx0, int dy0)
  {
    x = x0 + Pixel.size / 2;
    y = y0 + Pixel.size / 2;
    dx = dx0;
    dy = dy0;
  }

  void move()
  {
    x += size * dx;
    y += size * dy;
    dd += size;
  }

  void show()
  {
    fill(kolor);
    rect(x, y, size, size);
  }
}