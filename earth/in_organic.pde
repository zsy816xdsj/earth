class in_organic extends earth{
  in_organic(float x,float y){
    super(x,y);
  }
}

class rock extends in_organic{
  rock(float s,float x,float y){
    super(x,y);
    Width = s;
    Height = s;
 }
}

class lake extends in_organic{
  lake(float w,float h,float x,float y){
    super(x,y);
    Width = w;
    Height = h;
  }
}

class weather extends in_organic{
  int ran;
  int w_h;
  int w_w;
  int neighbours;
  int[][] weather_grid;
  int[][] weather_grid_buffer;
  //int WHICH_WEATHER;
  weather(float x,float y){
    super(x,y);
    w_w = int(width/step_max);
    w_h = int(height/step_max);
    Width = width;
    Height = step_max;
    weather_grid = new int[int(width/step_max)][int(height/step_max)];
    weather_grid_buffer = new int[int(width/step_max)][int(height/step_max)];
    for (int w_y = 0; w_y<w_h; w_y++) {
      for (int w_x = 0; w_x<w_w; w_x++) {
       int state = int(random(3));
        if (probabilityOfRainAtStart == state) { 
          weather_grid[w_x][w_y] = 1;
        }else if(probabilityOfBlackAtStart == state){
          weather_grid[w_x][w_y]= 2;
        }else{
          weather_grid[w_x][w_y] = 0;
        }
      }
    }
  }
  void show(){
    for(int y = 0;y < w_h;y++){
      for(int x = 0;x < w_w;x++){
        if(weather_grid[x][y]%3 == 1){
          image(RAIN_IMG,step_max*x,step_max*y);
        }else if(weather_grid[x][y]%3 == 2){
          fill(0,120);
          rect(step_max*x,step_max*y,50,50);
        }//else if(weather_grid[j][i]%4 == 3){
        //  image(LIG_IMG,step_max*j,step_max*i);
        //}
      }
      //for i in range(){}
    }
  }
  
  void update(){
    for (int y=0;y<w_h;y++) {
      for (int x=0;x<w_w;x++) {
        weather_grid_buffer[x][y] = weather_grid[x][y];
      }
    }
    for(int y = 0;y < w_h;y++){
      for(int x = 0;x < w_w;x++){
        neighbours = 0;
        for (int xx=x-1; xx<=x+1;xx++){
          for (int yy=y-1; yy<=y+1;yy++){
            if (((xx>=0)&&(xx<w_w))&&((yy>=0)&&(yy<w_h))) { 
              if (!((xx==y)&&(yy==x))) { 
                if (weather_grid_buffer[xx][yy]==weather_grid_buffer[x][y]){
                  neighbours ++;
                }
              }
            }
          }
        }
        if(neighbours>=5){
          ran = int(random(10));
          if(ran  == 0){
            weather_grid[x][y] ++;
          }
        }else if(neighbours<=2){
          ran = int(random(10));
          if(ran == 0){
            weather_grid[x][y] --;
          }
        }
      }
    }
    noTint();
  }
}
