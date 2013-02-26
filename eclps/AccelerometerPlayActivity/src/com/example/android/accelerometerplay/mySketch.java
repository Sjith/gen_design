package com.example.android.accelerometerplay;
import processing.core.PApplet;
import android.app.Activity;

public class mySketch extends PApplet {

    public void setup() {
    	size(1280,900);
    	background(255);
    }

    public void draw() {
    	stroke(0);
        if (mousePressed) {
          line(mouseX,mouseY,pmouseX,pmouseY);
          
        }
    }

    public static void main(String[] args) {
        PApplet.main(new String[] {mySketch.class.getName()});
    }
}