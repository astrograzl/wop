class Fox extends Animal
{
  Fox()
  {
    super(25, grass);
    type = 'X';
    lives = 3;
    value = 20;
    update = 15;
    kolor = color(239, 42, 41, 192);
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
    if (xx < 0) xx += ww;
    if (yy < 0) yy += ww;
    if (xx >= ww) xx -= ww;
    if (yy >= ww) yy -= ww;
    if (pixel(xx, yy) == grass) {
      x = xx;
      y = yy;
    }
  }
}