import javax.swing.*;
import java.awt.*;
public class NewGameFrame extends JFrame {
  public NewGameFrame(){
     getContentPane().setLayout(new BoxLayout(getContentPane(), BoxLayout.Y_AXIS));    
     String[] options = {"1", "2", "3","4","5","6","7","8","9","10", "11", "12","13","14","15"};
     JComboBox petList = new JComboBox(options);
     add(new JLabel("Please select the number of dots to start with:"));
     add(petList);
     petList.setAlignmentX(Component.CENTER_ALIGNMENT);
     this.setSize(400,400);
     petList.setMaximumSize(new Dimension(200,20));
     JButton exit = new JButton("Start Game");

     add(exit);
     setVisible(true);
  }
}
     
