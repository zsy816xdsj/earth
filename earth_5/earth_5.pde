float step_max  = 100;//we devided it into many square,each of the square was 100*100
float step_min  = 50;
abstract class earth{
  PVector pos;//every thing have a position
  float Width,Height;
  earth(float x,float y){//what did the thing needs
    pos = new PVector(x,y);
  }
  void show(PImage image){
    image(image,pos.x,pos.y,Width,Height);
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

void setup(){
  h_animal = new ArrayList<earth>();
  p_animal = new ArrayList<earth>();
  rock = new ArrayList<earth>();
  p_plant = new ArrayList<earth>();
  lake = new ArrayList<earth>();
  size(1900,900);
  background(#00EC00);
  WATER_IMG = loadImage("w.png");
  STONE_IMG = loadImage("Rock-illustration-PNG.png");
  HERB_IMG = loadImage("R-C.png");
  PRED_IMG = loadImage("lion_PNG572.png");
  PINE_IMG = loadImage("tree_plane_01a_g1.png");
  int WhichThingToCreate = 0;
  for(int i = 0;i < height/step_max;i++){
    for(int j = 0;j < width/step_max;j++){
      WhichThingToCreate = int(random(0,6));
      if(WhichThingToCreate == 1){
        rock.add(new rock(random(step_min,step_max),random(j*step_max-step_max/2,j*step_max+step_max/2),random(i*step_max-step_max/2,i*step_max+step_max/2)));
      }
      else if(WhichThingToCreate == 2){
        lake.add(new lake(random(step_min,step_max),random(step_min,step_max),random(j*step_max-step_max/2,j*step_max+step_max/2),random(i*step_max-step_max/2,i*step_max+step_max/2)));
      }
      else if(WhichThingToCreate == 3){
        h_animal.add(new herbivore(random(step_min,step_max),random(j*step_max-step_max/2,j*step_max+step_max/2),random(i*step_max-step_max/2,i*step_max+step_max/2)));
      }
      else if(WhichThingToCreate == 4){
        p_plant.add(new pine(random(step_min,step_max),random(j*step_max-step_max/2,j*step_max+step_max/2),random(i*step_max-step_max/2,i*step_max+step_max/2)));
      }
      else if(WhichThingToCreate == 5){
        p_animal.add(new preditor(random(step_min,step_max),random(j*step_max-step_max/2,j*step_max+step_max/2),random(i*step_max-step_max/2,i*step_max+step_max/2)));
      }
    }
  }
}
void draw(){
  background(#00EC00);
  println(p_plant.size());
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
}
