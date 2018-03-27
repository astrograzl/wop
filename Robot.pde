class Robot extends Player
{
  String hash = "";
  char[] steps = {'a', 's', 'd', 'w', '0', 
    'A', 'S', 'D', 'W', '0'};
  int back = 0;
  int diff = 0;

  void update()
  {
    int m = int(random(10));
    int s = int(random(10));
    move(steps[m]);
    shoot(s);
    show();
    hash += steps[m] + str(s);
    if (frameCount % 32 == 1)
      saveFrame("../snapshot.png");
    if (frameCount % 32 == 0) {
      diff = score - back;
      File snap = new File("snapshot.png");
      snap.renameTo(new File(
        "genom/"+form(frameCount-32, 6, false)+
        "_"+hash+
        "_"+form(diff, 5, true)+
        ".png"));
      back = score;
      hash = "";
    }
  }

  String form(int number, int bold, boolean sign)
  { // format number to zero aligned string with sign
    String word = str(abs(number));
    String text;
    if (sign)
      if (number < 0) text = "-";
      else text = "+";
    else text = "";
    for (int l = word.length(); l < bold; l++)
      text += "0";
    text += word;
    return text;
  }
}
