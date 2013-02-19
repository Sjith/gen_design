import android.content.Intent;
import android.os.Bundle;

import ketai.net.nfc.*;

String writeStatus = "";
KetaiNFC ketaiNFC;

void setup()
{
  // this just says what you'll do as soon as a tag shows up
  String d = "Writing tag at: " + month()+"/"+day()+"/"+year()+" "+hour()+":"+minute()+":"+second();
  ketaiNFC.write(d);
}

void draw() { }

void mousePressed()
{
  String d = "Writing tag at: " + month()+"/"+day()+"/"+year()+" "+hour()+":"+minute()+":"+second();
  ketaiNFC.write(d);
}

void onNFCWrite(boolean result, String message)
{
  if (result)
    println("SUCCESS writing tag!");
  else
    println("ERROR " + message);
}

//Press any key to cancel write
void keyPressed()
{
  ketaiNFC.cancelWrite();
}