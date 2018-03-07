class Bird
{
  int x, y;
  int sx, sy;
  final int a = 25;
  final int b = 75;
  final color c = color(46, 52, 54, 192);

  Bird()
  {
    if (random(2) < 1) {
      sx = a;
      sy = b;
    } else {
      sx = b;
      sy = a;
    }
    x = int(random(width) / a) * a;
    y = int(random(height) / a) * a;
  }

  void show()
  {
    fill(c);
    rect(x, y, sx, sy);
  }

  void move()
  {
    int d = floor(random(3)) - 1;
    if (random(2) < 1) x += a * d;
    else y += a * d;
  }
}