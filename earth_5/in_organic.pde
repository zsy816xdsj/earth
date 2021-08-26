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
