import processing.core.PApplet;

public class MySketch extends PApplet {
	boolean b = true;
	ExampleDispatcher myDispatcher;

	public void setup() {
		size(400, 200);
		background(255);
		myDispatcher = new ExampleDispatcher();
		myDispatcher.setListener(this);

		// myDispatcher.dispatchWithArguments();
		// myDispatcher.dispatchAddOneToNumber();
	}

	public void handleBasicEvent() {
		println("A basic event!");
	}

	public void draw() {
		stroke(0);
		if (mousePressed) {
			line(mouseX, mouseY, pmouseX, pmouseY);
			if (b) {
				myDispatcher.dispatchBasic();

				b = false;
			}

		} else {
			if (!b) {
				myDispatcher.dispatchAddOneToNumber();
				//myDispatcher.dispatchWithArguments();
				b = true;
			}

		}
	}

	// arguments will get passed from myDispatcher.
	public void handleEventWithArgs(int arg1, float arg2) {
		println("arg1 is :: " + arg1 + " and arg2 is" + arg2);
	}

	// an example of communicating between the two.
	public int addOne(int num) {
		return num + 1;
	}

	public static void main(String[] args) {
		PApplet.main(new String[] { MySketch.class.getName() });
	}
}
