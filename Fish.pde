final color fish = color(252, 234, 79);

class Fish extends Anime
{
  Fish()
  {
    super(25, water);
    type = 'F';
    lives = 2;
    value = 15;
    update = 50;
    kolor = color(fish, 192);
  }
}