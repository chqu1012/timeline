package timeline

import javafx.application.Application
import javafx.beans.binding.ObjectBinding
import javafx.beans.binding.When
import javafx.beans.property.SimpleBooleanProperty
import javafx.scene.Group
import javafx.scene.Scene
import javafx.scene.paint.Color
import javafx.scene.shape.Circle
import javafx.scene.shape.Line
import javafx.scene.shape.Shape
import javafx.stage.Stage
import javafx.scene.control.Label
import javafx.scene.input.MouseButton

class Timeline extends Application {

	val isSelected = new SimpleBooleanProperty(false)

	val ObjectBinding<Color> binding =new When(isSelected).then(Color::MAGENTA).otherwise(Color::BLACK)

	var isClicked = true

	override void start(Stage primaryStage) {
		val group = new Group

		val x1 = 0
		val x2 = 800+50
		val y = 600/2

		val line = new Line(x1,y,x2,y)
		line.strokeWidth = 2
		line.hoverEffect

		val vLine = new Line(0, 0 ,0, 600)
		vLine.strokeWidth = 0.3
		vLine.stroke = Color::BLUE

		val hLine = new Line(x1, 0 ,x2, 0)
		hLine.strokeWidth = 0.3
		hLine.stroke = Color::BLUE

		group.children += line
		group.children += vLine
		group.children += hLine

		var year = 2010
		for(i:0..800){
			if(i%20==0){
				val circle = new Circle(3)
				circle.centerX = i
				circle.centerY = 600/2
				circle.hoverEffect
				circle.onMouseClicked = [ e |
					isClicked = !isClicked
					if(isClicked){
						if(e.button==MouseButton::PRIMARY)
							circle.radius = circle.radius * 2
						else
							circle.radius = circle.radius * 0.5
					}
				]
				group.children += circle

				if(i%50==0){
					val label = new Label(year+'')
					label.layoutX = i
					label.layoutY = 300 +10
					year++
					group.children += label
				}
			}
		}

		val scene = new Scene(group)
		primaryStage.scene = scene

		scene.onMouseMoved = [e|
			vLine.translateX = e.x
			hLine.translateY = e.y
		]

		primaryStage.show

	}

	def void hoverEffect(Shape shape){
		shape.fillProperty.bind(binding)
		shape.strokeProperty.bind(binding)
	    shape.onMouseEntered = [ isSelected.set=true]
        shape.onMouseExited = [ isSelected.set=false]
	}

	def static void main(String[] args) {
		launch(args)
	}

}
