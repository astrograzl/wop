class Fish
{
  int x, y;
  final int s = 25;
  final color c = color(252, 234, 79, 192);

  Fish()
  {
    loadPixels();
    boolean ok = false;
    while (!ok) {
      int ww = int(sqrt(pixels.length));
      int xx = int(random(ww-s) / s) * s;
      int yy = int(random(ww-s) / s) * s;
      color ci = pixels[xx+yy*ww];
      color cf = pixels[xx+s-1+(yy+s-1)*ww];
      if (ci == water && cf == water) {
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

  void move()
  {
    int xx = x;
    int yy = y;
    int d = floor(random(3)) - 1;
    int ww = int(sqrt(pixels.length));
    if (random(2) < 1) xx += s * d;
    else yy += s * d;
    if (xx >= 0 && xx < ww && yy >= 0 && yy < ww) {
      loadPixels();
      color ci = pixels[xx+y*ww];
      color cf = pixels[xx+s-1+(yy+s-1)*ww];
      if (ci == water && cf == water) {
        x = xx;
        y = yy;
      }
    }
  }
}