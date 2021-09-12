abstract class organism extends earth{
  int life;
  organism(float x,float y){
    super(x,y);
  }
}


abstract class animal extends organism{
  PVector velocity;
  PVector acceleration;
  float topspeed;
  int some_a;
  int energy;
  int thirthty;
  boolean onTheWayToFood;
  boolean onTheWayToDrink;
  boolean onTheWayToMate;
  earth water = null;
  earth enemy = null;
  earth food = null;
  earth mate = null;
  
  
  
  animal(float s,float x,float y){
    super(x,y);
    Width = s;
    Height = s;
    energy = int(random(1200,1350));
    life = int(random(700,900));
    thirthty = int(random(1200,1350));
    velocity = new PVector(0,0);
    onTheWayToFood = false;
    onTheWayToDrink = false;
    onTheWayToMate = false;
    //m = 0;
  }



  void moveto(earth des){
    //if(energy <= 700){
    //  topspeed = 2.5;
    //}else{
    //  topspeed = 5;
    //}
    if(!(des==null)){
      if(dist(pos.x,pos.y,des.pos.x,des.pos.y)>20){
         acceleration =  PVector.sub(des.pos,pos);
         acceleration.setMag(2);
         //text(str(d),position.x,position.y+50);
         velocity.add(acceleration);
         velocity.limit(topspeed);
         pos.add(velocity);
      }
    }
  }
 
  boolean indanger(){
    if(enemy ==null){
      return false;

    }else if{
      if(dist(pos.x,pos.y,enemy.pos.x,enemy.pos.y) <= 100){
        return true;
      }else{
        return false;
    }
    }
 }
 
 void moveaway(earth des){
   if(!(des==null)){
     if(dist(pos.x,pos.y,des.pos.x,des.pos.y)>20){
      //if(energy <= 700){
      //  topspeed = 2.5;
      //}else{
      //  topspeed = 4.9;
      //}
         acceleration =  PVector.sub(pos,des.pos);
         acceleration.setMag(2);
         //text(str(d),position.x,position.y+50);
         velocity.add(acceleration);
         velocity.limit(topspeed);
         pos.add(velocity);
     }
   }
 }
 
 
 
 earth finding_the_Nearest(ArrayList<earth> List){
   float distance;
   int i = 0;
   int min = 0;
   float d = 10000;
   if(List.size()>0){
     for (earth part:List){
       distance =  dist(pos.x,pos.y,part.pos.x,part.pos.y);
       if(distance < d){
         d = distance;
         min = i;
       }
       i++;
     }
     earth result = List.get(min);
     return(result);
   }else{
     return(null);
   }
 }



 void drinking(earth target){
   if(dist(pos.x,pos.y,target.pos.x,target.pos.y) <= 20){
     thirthty = thirthty+200;
     onTheWayToDrink = false;
   }
 }
 
 
 void timeisgoing(){
   life--;
   energy--;
   thirthty--;
 }
 
 
 void eating(earth target){
   if(dist(pos.x,pos.y,target.pos.x,target.pos.y) <= 20){
     energy = energy+100;
     onTheWayToFood = false;
     target.be_eaten();
   }
 }
 void reproduceing(earth target){
   if(dist(pos.x,pos.y,target.pos.x,target.pos.y) <= 20){
     onTheWayToMate = false;
     h_animal.add(new herbivore(random(step_min,step_max),random(pos.x-step_max,pos.x+step_max),random(pos.y-step_max,pos.y+step_max)));
   }
 }
}


class herbivore extends animal{
  herbivore(float s,float x,float y){
    super(s,x,y);
    topspeed = 4;
  }
  void update(){
    timeisgoing();
    if(life <= 0){
        h_animal.remove(this);
      }else{
        if(energy <= 0){
          h_animal.remove(this);
        }else{
          if(thirthty <= 0){
            h_animal.remove(this);
          }else{
            enemy = finding_the_Nearest(p_animal);
            if(indanger()){
                moveaway(enemy);
            }else{
              if(thirthty<=1200){
                if(onTheWayToDrink){
                  moveto(water);
                  drinking(water);
                }else{
                  water = finding_the_Nearest(lake);
                  if(dist(water.pos.x,water.pos.y,enemy.pos.x,enemy.pos.y)<=20){
                    for(int i = 0;i<=100;i++){
                      moveaway(water);
                      water = finding_the_Nearest(lake);
                    }
                  }
                  onTheWayToDrink = true;
                  onTheWayToFood = false;
                }
              }
              if(!onTheWayToDrink){
                if(energy<=1200){
                  if(onTheWayToFood){
                    moveto(food);
                    eating(food);
                  }else{
                    food = finding_the_Nearest(p_plant);
                    onTheWayToFood = true;
                  }
                }
                if(!onTheWayToFood){
                  if(life<=400){
                    some_a = int(random(0,200));
                    if(some_a==0){
                      if(onTheWayToMate){
                        moveto(mate);
                        reproduceing(mate);
                      }else{
                        mate = finding_the_Nearest(h_animal);
                        onTheWayToMate = true;
                      }
                    } 
                  }
                }
              }
            }
          }
        }
      }
      text(energy,pos.x,pos.y);
      text(thirthty,pos.x,pos.y+10);
      text(life,pos.x,pos.y+20);     
   }
}




class preditor extends animal{
  preditor(float s,float x,float y){
    super(s,x,y);
    topspeed = 5;
  }
  void update(){
    timeisgoing();
    if(life <= 0){
        p_animal.remove(this);
      }else{
        if(energy <= 0){
          p_animal.remove(this);
        }else{
          if(thirthty <= 0){
            p_animal.remove(this);
          }else{
            if(thirthty<=1200&&lake.size()>0){
              if(onTheWayToDrink){
                moveto(water);
                drinking(water);
              }else{
                water = finding_the_Nearest(lake);
                onTheWayToDrink = true;
                onTheWayToFood = false;
              }
            }
            if(energy<=1200&&p_plant.size()>0&&!onTheWayToDrink){
              if(onTheWayToFood){
                moveto(food);
                eating(food);
              }else{
                food = finding_the_Nearest(h_animal);
                onTheWayToFood = true;
              }
            }
            if(life<=400&&h_animal.size()>0&&!onTheWayToDrink&&!onTheWayToFood){
              some_a = int(random(0,200));
              if(some_a==0){
                if(onTheWayToMate){
                  moveto(mate);
                  reproduceing(mate);
                }else{
                  mate = finding_the_Nearest(p_animal);
                  onTheWayToMate = true;
                }
              } 
            }
          }
        }
      }
      text(energy,pos.x,pos.y);
      text(thirthty,pos.x,pos.y+10);
      text(life,pos.x,pos.y+20);     
   }
}
