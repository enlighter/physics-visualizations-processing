package controlP5;

import java.util.Iterator;
import java.util.LinkedHashMap;
import processing.core.PApplet;

/**
 * Use charts to display float array data as line chart, yet experimental, but see the
 * ControlP5chart example for more details.
 * 
 * @example controllers/ControlP5chart
 */
public class Chart extends Controller<Chart> {

	public final static int LINE = 0;
	public final static int BAR = 1;
	public final static int BAR_CENTERED = 2;
	public final static int HISTOGRAM = 3;
	public final static int PIE = 4;
	public final static int AREA = 5;

	private LinkedHashMap<String, ChartDataSet> _myDataSet;

	private float resolution = 1;

	private float strokeWeight = 1;

	private float _myMin = 0;

	private float _myMax = 1;

	protected Chart(ControlP5 theControlP5, ControllerGroup<?> theParent, String theName, float theX, float theY, int theWidth, int theHeight) {
		super(theControlP5, theParent, theName, theX, theY, theWidth, theHeight);
		setRange(0, theHeight);
		_myDataSet = new LinkedHashMap<String, ChartDataSet>();
	}

	public Chart setRange(float theMin, float theMax) {
		_myMin = theMin;
		_myMax = theMax;
		return this;
	}

	public Chart setColors(String theSetIndex, int... theColors) {
		getDataSet().get(theSetIndex).setColors(theColors);
		return this;
	}

	public Chart addData(ChartData theItem) {
		return addData(getFirstDataSetIndex(), theItem);
	}

	private String getFirstDataSetIndex() {
		return getDataSet().keySet().iterator().next();
	}

	private String getLastDataSetIndex() {
		Iterator<String> it = getDataSet().keySet().iterator();
		String last = null;
		while (it.hasNext()) {
			last = it.next();
		}
		return last;
	}

	public Chart addData(String theSetIndex, ChartData theItem) {
		getDataSet(theSetIndex).add(theItem);
		return this;
	}

	public Chart addData(float theValue) {
		ChartData cdi = new ChartData(theValue);
		getDataSet(getFirstDataSetIndex()).add(cdi);
		return this;
	}

	public Chart addData(String theSetIndex, float theValue) {
		ChartData cdi = new ChartData(theValue);
		getDataSet(theSetIndex).add(cdi);
		return this;
	}

	public Chart addData(ChartDataSet theChartData, float theValue) {
		ChartData cdi = new ChartData(theValue);
		theChartData.add(cdi);
		return this;
	}

	public Chart push(float theValue) {
		return push(getFirstDataSetIndex(), theValue);
	}

	public Chart push(String theSetIndex, float theValue) {
		if (getDataSet(theSetIndex).size() > (width / resolution)) {
			removeLast(theSetIndex);
		}
		return addFirst(theSetIndex, theValue);
	}

	public Chart addFirst(float theValue) {
		return addFirst(getFirstDataSetIndex(), theValue);
	}

	public Chart addFirst(String theSetIndex, float theValue) {
		ChartData cdi = new ChartData(theValue);
		getDataSet(theSetIndex).add(0, cdi);
		return this;
	}

	public Chart removeLast() {
		return removeLast(getFirstDataSetIndex());
	}

	public Chart removeLast(String theSetIndex) {
		return removeData(getDataSet(theSetIndex).size() - 1);
	}

	public Chart removeData(ChartData theItem) {
		removeData(getFirstDataSetIndex(), theItem);
		return this;
	}

	public Chart removeData(String theSetIndex, ChartData theItem) {
		getDataSet(theSetIndex).remove(theItem);
		return this;
	}

	public Chart removeData(int theItemIndex) {
		removeData(getFirstDataSetIndex(), theItemIndex);
		return this;
	}

	public Chart removeData(String theSetIndex, int theItemIndex) {
		if (getDataSet(theSetIndex).size() < 1) {
			return this;
		}
		getDataSet(theSetIndex).remove(theItemIndex);
		return this;
	}

	public Chart setData(int theItemIndex, ChartData theItem) {
		getDataSet(getFirstDataSetIndex()).set(theItemIndex, theItem);
		return this;
	}

	public Chart setData(String theSetItem, int theItemIndex, ChartData theItem) {
		getDataSet(theSetItem).set(theItemIndex, theItem);
		return this;
	}

	public Chart addDataSet(String theName) {
		getDataSet().put(theName, new ChartDataSet(theName));
		return this;
	}

	public Chart setDataSet(ChartDataSet theItems) {
		setDataSet(getFirstDataSetIndex(), theItems);
		return this;
	}

	public Chart setDataSet(String theSetIndex, ChartDataSet theChartData) {
		getDataSet().put(theSetIndex, theChartData);
		return this;
	}

	public Chart removeDataSet(String theIndex) {
		getDataSet().remove(theIndex);
		return this;
	}

	public Chart setData(float... theValues) {
		setData(getFirstDataSetIndex(), theValues);
		return this;
	}

	public Chart setData(String theSetIndex, float... theValues) {
		if (getDataSet().get(theSetIndex).size() != theValues.length) {
			getDataSet().get(theSetIndex).clear();
			for (int i = 0; i < theValues.length; i++) {
				getDataSet().get(theSetIndex).add(new ChartData(0));
			}
		}
		int n = 0;
		resolution = (float) width / (getDataSet().get(theSetIndex).size() - 1);
		for (float f : theValues) {
			getDataSet().get(theSetIndex).get(n++).setValue(f);
		}
		return this;
	}

	public Chart updateData(float... theValues) {
		return setData(theValues);
	}

	public Chart updateData(String theSetIndex, float... theValues) {
		return setData(theSetIndex, theValues);
	}

	public LinkedHashMap<String, ChartDataSet> getDataSet() {
		return _myDataSet;
	}

	public ChartDataSet getDataSet(String theIndex) {
		return getDataSet().get(theIndex);
	}

	public float[] getValuesFrom(String theIndex) {
		return getDataSet(theIndex).getValues();
	}

	public ChartData getData(String theIndex, int theItemIndex) {
		return getDataSet(theIndex).get(theItemIndex);
	}

	public int size() {
		return getDataSet().size();
	}

	@Override
	public void onEnter() {
	}

	@Override
	public void onLeave() {
	}

	@Override
	public Chart setValue(float theValue) {
		// TODO Auto-generated method stub
		return this;
	}

	public Chart setStrokeWeight(float theWeight) {
		strokeWeight = theWeight;
		for (ChartDataSet c : getDataSet().values()) {
			c.setStrokeWeight(theWeight);
		}
		return this;
	}

	public float getStrokeWeight() {
		return strokeWeight;
	}

	/**
	 * ?
	 * 
	 * @param theValue
	 * @return
	 */
	public Chart setResolution(int theValue) {
		resolution = theValue;
		return this;
	}

	public int getResolution() {
		return (int) resolution;
	}

	/**
	 * @exclude
	 */
	@Override
	@ControlP5.Invisible
	public Chart updateDisplayMode(int theMode) {
		return updateViewMode(theMode);
	}

	/**
	 * @exclude
	 */
	@ControlP5.Invisible
	public Chart updateViewMode(int theMode) {
		_myDisplayMode = theMode;
		switch (theMode) {
		case (DEFAULT):
			_myControllerView = new ChartViewPie();
			break;
		case (IMAGE):
			// _myDisplay = new ChartImageDisplay();
			break;
		case (SPRITE):
			// _myDisplay = new ChartSpriteDisplay();
			break;
		case (CUSTOM):
		default:
			break;
		}
		return this;
	}

	public class ChartViewBar implements ControllerView<Chart> {

		public void display(PApplet theApplet, Chart theController) {
			theApplet.pushStyle();
			theApplet.fill(getColor().getBackground());
			theApplet.rect(0, 0, getWidth(), getHeight());
			theApplet.noStroke();

			Iterator<String> it = getDataSet().keySet().iterator();
			String index = null;
			float o = 0;
			while (it.hasNext()) {
				index = it.next();
				float s = getDataSet(index).size();
				for (int i = 0; i < s; i++) {
					theApplet.fill(getDataSet(index).getColor(i));
					float ww = ((width / s));
					float hh = PApplet.map(getDataSet(index).get(i).getValue(), _myMin, _myMax, 0, getHeight());
					theApplet.rect(o + i * ww, getHeight(), (ww / getDataSet().size()), -PApplet.min(getHeight(), PApplet.max(0, hh)));
				}
				o += ((width / s)) / getDataSet().size();
			}
			theApplet.popStyle();
		}
	}

	public class ChartViewBarCentered implements ControllerView<Chart> {

		public void display(PApplet theApplet, Chart theController) {
			theApplet.pushStyle();
			theApplet.fill(getColor().getBackground());
			theApplet.rect(0, 0, getWidth(), getHeight());
			theApplet.noStroke();

			Iterator<String> it = getDataSet().keySet().iterator();
			String index = null;
			float o = 0;
			int n = 4;
			int off = (getDataSet().size() - 1) * n;
			while (it.hasNext()) {
				index = it.next();
				int s = getDataSet(index).size();
				float step = (float) width / (float) (s);
				float ww = step - (width % step);
				ww -= 1;
				ww = PApplet.max(1, ww);

				for (int i = 0; i < s; i++) {
					theApplet.fill(getDataSet(index).getColor(i));
					ww = ((width / s) * 0.5f);
					float hh = PApplet.map(getDataSet(index).get(i).getValue(), _myMin, _myMax, 0, getHeight());
					theApplet.rect(-off / 2 + o + i * ((width / s)) + ww / 2, getHeight(), ww, -PApplet.min(getHeight(), PApplet.max(0, hh)));
				}
				o += n;
			}
			theApplet.popStyle();
		}
	}

	public class ChartViewLine implements ControllerView<Chart> {

		public void display(PApplet theApplet, Chart theController) {

			theApplet.pushStyle();
			theApplet.fill(getColor().getBackground());
			theApplet.rect(0, 0, getWidth(), getHeight());
			theApplet.noFill();
			Iterator<String> it = getDataSet().keySet().iterator();
			String index = null;
			while (it.hasNext()) {
				index = it.next();
				theApplet.stroke(getDataSet(index).getColor(0));
				theApplet.strokeWeight(getDataSet(index).getStrokeWeight());

				theApplet.beginShape();
				float res = ((float) getWidth()) / (getDataSet(index).size() - 1);
				for (int i = 0; i < getDataSet(index).size(); i++) {
					float hh = PApplet.map(getDataSet(index).get(i).getValue(), _myMin, _myMax, getHeight(), 0);
					theApplet.vertex(i * res, PApplet.min(getHeight(), PApplet.max(0, hh)));
				}
				theApplet.endShape();
			}
			theApplet.noStroke();
			theApplet.popStyle();
		}
	}

	public class ChartViewArea implements ControllerView<Chart> {

		public void display(PApplet theApplet, Chart theController) {

			theApplet.pushStyle();
			theApplet.fill(getColor().getBackground());
			theApplet.rect(0, 0, getWidth(), getHeight());
			theApplet.noStroke();

			Iterator<String> it = getDataSet().keySet().iterator();
			String index = null;
			while (it.hasNext()) {
				index = it.next();
				float res = ((float) getWidth()) / (getDataSet(index).size() - 1);

				theApplet.fill(getDataSet(index).getColor(0));
				theApplet.beginShape();
				theApplet.vertex(0, getHeight());

				for (int i = 0; i < getDataSet(index).size(); i++) {
					float hh = PApplet.map(getDataSet(index).get(i).getValue(), _myMin, _myMax, getHeight(), 0);
					theApplet.vertex(i * res, PApplet.min(getHeight(), PApplet.max(0, hh)));
				}
				theApplet.vertex(getWidth(), getHeight());
				theApplet.endShape(PApplet.CLOSE);
			}
			theApplet.noStroke();
			theApplet.popStyle();
		}
	}

	public class ChartViewPie implements ControllerView<Chart> {

		public void display(PApplet theApplet, Chart theController) {
			theApplet.pushStyle();
			theApplet.pushMatrix();

			Iterator<String> it = getDataSet().keySet().iterator();
			String index = null;
			while (it.hasNext()) {
				index = it.next();
				float total = 0;
				for (int i = 0; i < getDataSet(index).size(); i++) {
					total += getDataSet(index).get(i).getValue();
				}

				float segment = TWO_PI / total;
				float angle = -HALF_PI;

				theApplet.noStroke();
				for (int i = 0; i < getDataSet(index).size(); i++) {
					theApplet.fill(getDataSet(index).getColor(i));
					float nextAngle = angle + getDataSet(index).get(i).getValue() * segment;

					// a tiny offset to even out render artifacts when in smooth() mode.
					float a = PApplet.max(0, PApplet.map(getWidth(), 0, 200, 0.05f, 0.01f));

					theApplet.arc(0, 0, getWidth(), getHeight(), angle - a, nextAngle);
					angle = nextAngle;
				}
				theApplet.translate(0, (getHeight() + 10));
			}
			theApplet.popMatrix();
			theApplet.popStyle();
		}
	}

	public Chart setView(int theType) {
		switch (theType) {
		case (PIE):
			setView(new ChartViewPie());
			break;
		case (LINE):
			setView(new ChartViewLine());
			break;
		case (BAR):
			setView(new ChartViewBar());
			break;
		case (BAR_CENTERED):
			setView(new ChartViewBarCentered());
			break;
		case (AREA):
			setView(new ChartViewArea());
			break;
		default:
			System.out.println("Sorry, this ChartView does not exist");
			break;
		}
		return this;
	}

	@Override
	public String getInfo() {
		return "type:\tChart\n" + super.toString();
	}

	@Override
	public String toString() {
		return super.toString() + " [ " + getValue() + " ]" + " Chart " + "(" + this.getClass().getSuperclass() + ")";
	}

}

/*
 * NOTES what is the difference in meaning between chart and graph
 * http://answers.yahoo.com/question/index?qid=20090101193325AA3mgMl
 */
