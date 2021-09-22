float step_max  = 50;//we devided it into many square,each of the square was 100*100
float step_min  = 25;
int time = 1000;
int probabilityOfRainAtStart = 1;
int probabilityOfBlackAtStart =2;
abstract class earth{
  PVector pos;//every thing have a position
  float Width,Height;
  earth(float x,float y){//what did the thing needs
    pos = new PVector(x,y);
  }
  void show(PImage image){
    image(image,pos.x,pos.y,Width,Height);//show them!
  }
  void update(){}
  void be_eaten(){}
}
ArrayList<earth> rock;
ArrayList<earth> lake;
ArrayList<earth> p_plant;
ArrayList<earth> p_animal;
ArrayList<earth> h_animal;
PImage WATER_IMG;
PImage STONE_IMG;
PImage HERB_IMG;
PImage PRED_IMG;
PImage PINE_IMG;
PImage BLAC_IMG;
PImage RAIN_IMG;
PImage CLOU_IMG;
PImage[] WEA_IMG;
weather Weather;
void setup(){
  noStroke();
  h_animal = new ArrayList<earth>();
  p_animal = new ArrayList<earth>();
  rock = new ArrayList<earth>();
  p_plant = new ArrayList<earth>();
  lake = new ArrayList<earth>();
  
  size(1900,900);
  background(#00EC00);
  WATER_IMG = loadImage("water.png");
  STONE_IMG = loadImage("rock.png");
  HERB_IMG = loadImage("giraffe.png");
  PRED_IMG = loadImage("lion.png");
  PINE_IMG = loadImage("tree.png");
  RAIN_IMG = loadImage("raining.png");
  WEA_IMG = new PImage[3];
  Weather = new weather(0,0);
  WEA_IMG[0] = RAIN_IMG;
  WEA_IMG[1] = BLAC_IMG;
  int WhichThingToCreate = 0;
  //setup the lifes and all things
  for(int i = 0;i < height/step_max;i++){
    for(int j = 0;j < width/step_max;j++){
      WhichThingToCreate = int(random(13));
      if(WhichThingToCreate == 1||WhichThingToCreate == 2){//change this to have more rocks
        rock.add(new rock(random(step_min,step_max),random(j*step_max-step_max/2,j*step_max+step_max/2),random(i*step_max-step_max/2,i*step_max+step_max/2)));
      }
      else if(WhichThingToCreate == 4){//change this to have more lakes
        lake.add(new lake(random(step_min,step_max),random(step_min,step_max),random(j*step_max-step_max/2,j*step_max+step_max/2),random(i*step_max-step_max/2,i*step_max+step_max/2)));
      }
      else if(WhichThingToCreate == 5||WhichThingToCreate == 6||WhichThingToCreate == 11){//change this to have more giraffes
        h_animal.add(new herbivore(random(step_min,step_max),random(j*step_max-step_max/2,j*step_max+step_max/2),random(i*step_max-step_max/2,i*step_max+step_max/2)));
      }
      else if(WhichThingToCreate == 8||WhichThingToCreate == 9){//change this to have more pine_trees
        p_plant.add(new pine(random(step_min,step_max),random(j*step_max-step_max/2,j*step_max+step_max/2),random(i*step_max-step_max/2,i*step_max+step_max/2)));
      }
      else if(WhichThingToCreate == 10){//change this to have more lions
        p_animal.add(new preditor(random(step_min,step_max),random(j*step_max-step_max/2,j*step_max+step_max/2),random(i*step_max-step_max/2,i*step_max+step_max/2)));
      }
      
    }
  }
}
void draw(){
  time++;
  background(#00EC00);
  for (int i = rock.size()-1;i >= 0; i--) {
    earth part = rock.get(i);
    part.show(STONE_IMG);
  }
  for (int i = lake.size()-1;i >= 0; i--) {
    lake.get(i).show(WATER_IMG);
  }
  for (int i = p_plant.size()-1;i >= 0; i--) {
    earth part = p_plant.get(i);
    part.show(PINE_IMG);
    part.update();
  }
  for (int i = h_animal.size()-1;i >= 0; i--) {
    earth part = h_animal.get(i);
    part.show(HERB_IMG);
    part.update();
  }
  for (int i = p_animal.size()-1;i >= 0; i--) {
    earth part = p_animal.get(i);
    part.show(PRED_IMG);
    part.update();
  }
  Weather.show();
  if(time>=5){
    Weather.update();
    time = 0;
  }
}
