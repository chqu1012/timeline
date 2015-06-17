package timeline

import javafx.application.Application
import javafx.stage.Stage
import javafx.scene.control.Label
import javafx.scene.Scene
import javafx.scene.shape.Line
import javafx.scene.Group

class TimeLineApplication extends Application{

	override start(Stage primaryStage) throws Exception {
		val group = new Group

		val x1 = 0
		val x2 = 800+50
		val y = 100

		val line = new Line(x1,y,x2,y)
		line.strokeWidth = 4

		val vLine = new TrackLine(0, 0 ,0, 600)
		val hLine = new TrackLine(x1, 0 ,x2, 0)
		group.children += #[line,vLine,hLine]

		var year = 2010
		for(i:1..800){
			if(i%50==0){
				group.children += new TimeCircle(i, 100)

				if(i%2==0){
					val label = new Label(year+'')
					label.layoutX = i
					label.layoutY = 60
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

	def static void main(String[] args) {
		launch(args)
	}
}