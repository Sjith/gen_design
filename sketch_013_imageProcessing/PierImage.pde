class PierImage extends PImage {

  static final int GREY=0;
  static final int RED=1;
  static final int GREEN=2;
  static final int BLUE=3;
  PImage img;
  
  

  public PierImage(String str)
  {
    img=loadImage(str);
  }
  public PierImage(PImage pimg)
  {
    img=pimg;
  }

  int[] hist(int var)
  {
     int[] hist = new int[256];
    switch(var) {
    case GREY:

     
      for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          int bright = int(brightness(img.pixels[j*img.width+i]));
          hist[bright]++;
        }
      }
      

    case RED:
    for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          int bright = int(red(img.pixels[j*img.width+i]));
          hist[bright]++;
        }
      }
      break;
    case GREEN:
    for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          int bright = int(green(img.pixels[j*img.width+i]));
          hist[bright]++;
        }
      }
      break;
    case BLUE:
    for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          int bright = int(blue(img.pixels[j*img.width+i]));
          hist[bright]++;
        }
      }
      break;
    default:
      println("end");
      saveFrame();
      exit();
      break;
    }
    
  return hist;
  }
  
    int[][] globalHist(int[][] gI){
        gI=new int[5][256];
    
      for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          int b=int(brightness(img.pixels[j*img.width+i]));
          gI[0][b]++;
          int r=int(red(img.pixels[j*img.width+i]));
          gI[1][r]++;
          int g=int(green(img.pixels[j*img.width+i]));
          gI[2][g]++;
          int bl=int(blue(img.pixels[j*img.width+i]));
          gI[3][b]++;
          if(gI[4][0]<gI[0][b])
          {
            gI[4][0]=gI[0][b];
          }
           if(gI[4][1]<gI[1][r])
          {
            gI[4][1]=gI[1][r];
          }
           if(gI[4][2]<gI[2][g])
          {
            gI[4][2]=gI[2][g];
          }
           if(gI[4][3]<gI[3][bl])
          {
            gI[4][3]=gI[3][bl];
          }
          
        }
      }
      
      return gI;
    
  }
  
  
  void printHist(int x1,int y1,int w1,int h1,int[] data,int max)
  {
    int[] hist=data;
    int histMax=max;
   
    
    histMax = max(hist);
    
    for (int i = 0; i <w1; i ++) {
      int which = int(map(i, 0, w1, 0, 255));
      int y = int(map(hist[which], 0, histMax, 0, h1));
     
      line(x1+i, y1+h1, x1+i, y1+h1-y);
    }
  }
  PImage getImg()
  {
    return img;
  }
}

