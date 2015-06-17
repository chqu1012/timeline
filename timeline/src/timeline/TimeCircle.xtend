package timeline

import javafx.beans.binding.NumberBinding
import javafx.beans.binding.ObjectBinding
import javafx.beans.binding.When
import javafx.beans.property.BooleanProperty
import javafx.beans.property.SimpleBooleanProperty
import javafx.scene.paint.Color
import javafx.scene.shape.Circle

class TimeCircle extends Circle implements IScalable{

	BooleanProperty isSelected = new SimpleBooleanProperty(false)
	BooleanProperty isHovered = new SimpleBooleanProperty(false)
	BooleanProperty isClicked = new SimpleBooleanProperty(false)

    ObjectBinding<Color> selectBinding =new When(isSelected).then(Color::BLUE).otherwise(Color::BLACK)
    ObjectBinding<Color> clickBinding =new When(isClicked).then(Color::RED).otherwise(Color::BLACK)
    NumberBinding sizeBinding =new When(isHovered).then(20).otherwise(5)

	new(double x, double y) {
		centerX = x
		centerY = y

		binding

	    onMouseEntered = [
	    	isSelected.set=true
	    	isHovered.set= true
	    ]
        onMouseExited = [
        	isSelected.set=false
	    	isHovered.set= false
        ]
        onMouseClicked = [
        	isClicked.set = !isClicked.get
        ]
	}

	def binding(){
		fillProperty.bind(selectBinding)
		fillProperty.bind(clickBinding)
		radiusProperty.bind(sizeBinding)
	}

}