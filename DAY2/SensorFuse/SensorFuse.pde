import ketai.sensors.*;
import android.content.Context;
import android.hardware.SensorManager;

float[] orientation = new float[3];
float[] values = new float[3];
float[] R = new float[16];
float[] I = new float[9];

KetaiSensor sensor;
float[] accelerometer = new float[3];
float[] magneticField = new float[3];
float[] gyro = new float[3];

SensorManager sensorManager;

void setup()
{
  
  sensorManager = (SensorManager) getApplicationContext().getSystemService(Context.SENSOR_SERVICE);
  
  sensor = new KetaiSensor(this);
  sensor.start();
  
  orientation(LANDSCAPE);
  textSize(36);
}

void draw()
{
  text("oriengtation: \n" + 
    "x: " + nfp(orientation[0], 1, 3) + "\n" +
    "y: " + nfp(orientation[1], 1, 3) + "\n" +
    "z: " + nfp(orientation[2], 1, 3), 0, 0, width, height);
}

void onAccelerometerEvent(float x, float y, float z, long time, int accuracy)
{
  accelerometer[0] = x;
  accelerometer[1] = y;
  accelerometer[2] = z;
}

void onMagneticFieldEvent(float x, float y, float z, long time, int accuracy)
{
  magneticField[0] = x;
  magneticField[1] = y;
  magneticField[2] = z;
  
}

void onOrientationEvent(float x, float y, float z)
{
  gyro[0] = x;
  gyro[1] = y;
  gyro[2] = z;
  
}
