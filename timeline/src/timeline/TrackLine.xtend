package timeline

import javafx.scene.paint.Color
import javafx.scene.shape.Line

class TrackLine extends Line {

	new(double x1, double y1, double x2, double y2) {
		super(x1, y1, x2, y2)
		strokeWidth = 0.3
		stroke = Color::BLUE
	}

}