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
    int xx = x;
    int yy = y;
    int dd = floor(random(3)) - 1;
    if (random(2) < 1) xx += size * dd;
    else yy += size * dd;
    if (xx < 0) xx += Width;
    if (yy < 0) yy += Hight;
    if (xx >= Width) xx -= Width;
    if (yy >= Hight) yy -= Hight;
    if (pixel(xx, yy) == grass) {
      x = xx;
      y = yy;
    }
  }
}