final color frog = color(117, 80, 123);

class Frog extends Anime
{
  Frog()
  {
    super(25, empty);
    type = 'G';
    lives = 8;
    value = 100;
    update = 200;
    kolor = color(frog, 192);
  }
}