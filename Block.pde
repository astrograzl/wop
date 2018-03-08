final color empty = color(192);
final color grass = color(78, 154, 6);
final color trees = color(143, 89, 2);
final color water = color(32, 74, 135);
final color[] Colors = {grass, trees, water};

final int[] Sizes = {100, 50, 25};
final int[] Steps = {500, 750, 2000};

Block Grass = new Block(0);
Block Trees = new Block(1);
Block Water = new Block(2);
Block[] Blocks = {Grass, Trees, Water};

class Block
{
  int type;
  int size;
  int x, y;
  color kolor;

  Block(int t)
  {
    type = t;
    size = Sizes[type];
    kolor = Colors[type];
  }

  void init()
  {
    x = int(random(Width) / size) * size;
    y = int(random(Hight) / size) * size;
  }

  void step()
  {
    int dd = floor(random(3)) - 1;
    if (random(2) < 1) {
      x += size * dd;
      if (x < 0) x += Width;
      if (x >= Width) x -= Width;
    } else {
      y += size * dd;
      if (y < 0) y += Hight;
      if (y >= Hight) y -= Hight;
    }
    fill(kolor);
    rect(x, y, size, size);
  }
}
