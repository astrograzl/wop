final color bird = color(46, 52, 54);

class Bird extends Animal
{
  Bird()
  {
    super(50, empty);
    type = 'B';
    lives = 1;
    value = 10;
    update = 50;
    kolor = color(bird, 192);
  }

  void show()
  {
    fill(kolor);
    ellipse(x, y, size, size);
  }

  void move()
  {
    int dd = floor(random(3)) - 1;
    if (random(2) < 1) x += size * dd;
    else y += size * dd;
    if (x < 0) x += Width;
    if (y < 0) y += Hight;
    if (x >= Width) x -= Width;
    if (y >= Hight) y -= Hight;
  }
}
