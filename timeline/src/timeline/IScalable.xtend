package timeline

import javafx.beans.property.DoubleProperty
import javafx.beans.property.SimpleDoubleProperty

interface IScalable {
	DoubleProperty scaleFactor = new SimpleDoubleProperty(1.0)
}