class plants extends organism{
  plants(float s,float x,float y){
    super(x,y);
    Width = s;
    Height = s;
  }
  void be_eaten(){
    life = life-10;
  }
}


class pine extends plants{
  pine(float s,float x,float y){
    super(s,x,y);
    life = 1000;
  }
  void update(){
    text(life,pos.x,pos.y);
    Width = Width+0.01;
    Height = Height+0.01;
    life--;
    if(life <= 0){
      p_plant.remove(this);
    }
    if(life <= 450){
      int sometree = int(random(0,500));
      if(sometree == 0){
        p_plant.add(new plants(random(step_min,step_max),random(pos.x-step_max,pos.x+step_max),random(pos.y-step_max,pos.y+step_max)));
      }
    }
  }
}
