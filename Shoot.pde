class Shoot
{
  int x, y;
  int dx, dy;
  int dd = 0;
  final int s = 3;
  final color c = color(238, 238, 236);

  Shoot(int x0, int y0, int dx0, int dy0)
  {
    x = x0 + Pixel.s / 2;
    y = y0 + Pixel.s / 2;
    dx = dx0;
    dy = dy0;
  }

  void move()
  {
    x += s * dx;
    y += s * dy;
    dd += s;
  }

  void show()
  {
    fill(c);
    rect(x, y, s, s);
  }
}