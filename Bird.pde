class Bird extends Animal
{
  Bird()
  {
    super(50, empty);
    type = 'B';
    lives = 1;
    value = 15;
    update = 10;
    kolor = color(46, 52, 54, 192);
  }

  void show()
  {
    fill(kolor);
    ellipse(x, y, size, size);
  }

  void move()
  {
    loadPixels();
    int dd = floor(random(3)) - 1;
    int ww = int(sqrt(pixels.length));
    if (random(2) < 1) x += size * dd;
    else y += size * dd;
    if (x < 0) x += ww;
    if (y < 0) y += ww;
    if (x >= ww) x -= ww;
    if (y >= ww) y -= ww;
  }
}