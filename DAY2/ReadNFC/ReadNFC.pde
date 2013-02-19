import android.content.Intent;
import android.os.Bundle;
import ketai.net.nfc.*;

String nfcText = "";
KetaiNFC ketaiNFC;

void setup()
{   
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(36);
  nfcText = "";
}

void draw() {

  background(78, 93, 75);
  if(nfcText != "") {
    text("We just read:" + nfcText, width/2, height/2);
  }
}

void onNFCEvent(String txt) {
  nfcText = txt;
}