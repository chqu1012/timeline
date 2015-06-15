package timeline;

import com.google.common.base.Objects;
import javafx.application.Application;
import javafx.beans.binding.ObjectBinding;
import javafx.beans.binding.When;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.collections.ObservableList;
import javafx.event.EventHandler;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.input.MouseButton;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;
import javafx.scene.paint.Paint;
import javafx.scene.shape.Circle;
import javafx.scene.shape.Line;
import javafx.scene.shape.Shape;
import javafx.stage.Stage;
import org.eclipse.xtext.xbase.lib.IntegerRange;

@SuppressWarnings("all")
public class Timeline extends Application {
  private final SimpleBooleanProperty isSelected = new SimpleBooleanProperty(false);
  
  private final ObjectBinding<Color> binding = new When(this.isSelected).<Color>then(Color.MAGENTA).otherwise(Color.BLACK);
  
  private boolean isClicked = true;
  
  @Override
  public void start(final Stage primaryStage) {
    final Group group = new Group();
    final int x1 = 0;
    final int x2 = (800 + 50);
    final int y = (600 / 2);
    final Line line = new Line(x1, y, x2, y);
    line.setStrokeWidth(2);
    this.hoverEffect(line);
    final Line vLine = new Line(0, 0, 0, 600);
    vLine.setStrokeWidth(0.3);
    vLine.setStroke(Color.BLUE);
    final Line hLine = new Line(x1, 0, x2, 0);
    hLine.setStrokeWidth(0.3);
    hLine.setStroke(Color.BLUE);
    ObservableList<Node> _children = group.getChildren();
    _children.add(line);
    ObservableList<Node> _children_1 = group.getChildren();
    _children_1.add(vLine);
    ObservableList<Node> _children_2 = group.getChildren();
    _children_2.add(hLine);
    int year = 2010;
    IntegerRange _upTo = new IntegerRange(0, 800);
    for (final Integer i : _upTo) {
      if ((((i).intValue() % 20) == 0)) {
        final Circle circle = new Circle(3);
        circle.setCenterX((i).intValue());
        circle.setCenterY((600 / 2));
        this.hoverEffect(circle);
        final EventHandler<MouseEvent> _function = (MouseEvent e) -> {
          this.isClicked = (!this.isClicked);
          if (this.isClicked) {
            MouseButton _button = e.getButton();
            boolean _equals = Objects.equal(_button, MouseButton.PRIMARY);
            if (_equals) {
              double _radius = circle.getRadius();
              double _multiply = (_radius * 2);
              circle.setRadius(_multiply);
            } else {
              double _radius_1 = circle.getRadius();
              double _multiply_1 = (_radius_1 * 0.5);
              circle.setRadius(_multiply_1);
            }
          }
        };
        circle.setOnMouseClicked(_function);
        ObservableList<Node> _children_3 = group.getChildren();
        _children_3.add(circle);
        if ((((i).intValue() % 50) == 0)) {
          String _plus = (Integer.valueOf(year) + "");
          final Label label = new Label(_plus);
          label.setLayoutX((i).intValue());
          label.setLayoutY((300 + 10));
          year++;
          ObservableList<Node> _children_4 = group.getChildren();
          _children_4.add(label);
        }
      }
    }
    final Scene scene = new Scene(group);
    primaryStage.setScene(scene);
    final EventHandler<MouseEvent> _function_1 = (MouseEvent e) -> {
      double _x = e.getX();
      vLine.setTranslateX(_x);
      double _y = e.getY();
      hLine.setTranslateY(_y);
    };
    scene.setOnMouseMoved(_function_1);
    primaryStage.show();
  }
  
  public void hoverEffect(final Shape shape) {
    ObjectProperty<Paint> _fillProperty = shape.fillProperty();
    _fillProperty.bind(this.binding);
    ObjectProperty<Paint> _strokeProperty = shape.strokeProperty();
    _strokeProperty.bind(this.binding);
    final EventHandler<MouseEvent> _function = (MouseEvent it) -> {
      this.isSelected.set(true);
    };
    shape.setOnMouseEntered(_function);
    final EventHandler<MouseEvent> _function_1 = (MouseEvent it) -> {
      this.isSelected.set(false);
    };
    shape.setOnMouseExited(_function_1);
  }
  
  public static void main(final String[] args) {
    Application.launch(args);
  }
}
