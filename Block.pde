final color empty = color(192);
final color grass = color(78, 154, 6);
final color rocks = color(143, 89, 2);
final color water = color(32, 74, 135);
final color[] Colors = {grass, rocks, water};

final int[] Sizes = {100, 50, 25, 25};
final int[] Steps = {500, 750, 2000};

Block Grass = new Block(0);
Block Rocks = new Block(1);
Block Water = new Block(2);
Block[] Blocks = {Grass, Rocks, Water};

class Block
{
  int t, s;
  int x, y;
  color c;

  Block(int type)
  {
    t = type;
    s = Sizes[t];
    c = Colors[t];
  }

  void init()
  {
    x = int(random(width) / s) * s;
    y = int(random(height) / s) * s;
  }

  void step()
  {
    int d = floor(random(3)) - 1;
    if (random(2) < 1) {
      x += s * d;
      if (x < 0) x += width;
      if (x >= width) x -= width;
    } else {
      y += s * d;
      if (y < 0) y += height;
      if (y >= height) y -= height;
    }
    fill(c);
    rect(x, y, s, s);
  }
}