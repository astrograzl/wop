class Robot extends Player {
  
  Player human;
  char[] steps = {'a', 's', 'd', 'w',   //   and
                  'A', 'S', 'D', 'W'};  //  jumps
  Robot(Player player)
  {
    human = player;
  }
  
  void update()
  {
    int m = int(random(8));
    int s = int(random(1, 10));
    human.move(steps[m]);
    human.shoot(s);
  }
}
