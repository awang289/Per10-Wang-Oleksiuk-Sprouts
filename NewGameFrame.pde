import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.lang.Integer;
public class NewGameFrame extends JFrame implements ActionListener {
  JButton exit;
  JComboBox<Integer> startNumber;
  public NewGameFrame() {
    setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    getContentPane().setLayout(new BoxLayout(getContentPane(), BoxLayout.Y_AXIS));    
    Integer[] options = {
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
    };
    startNumber = new JComboBox<Integer>(options);
    add(new JLabel("Please select the number of dots to start with:"));
    add(startNumber);
    startNumber.setAlignmentX(Component.CENTER_ALIGNMENT);
    this.setSize(400, 400);
    startNumber.setMaximumSize(new Dimension(200, 20));
    exit = new JButton("Start Game");
    exit.setActionCommand("submit");
    exit.addActionListener(this);
    add(exit);
    setVisible(true);
    pack();
  }
  void actionPerformed(ActionEvent e) {

    setStartNumber( ((Integer) startNumber.getSelectedItem()).intValue());
    setup();
    pullThePlug();
  }

  void pullThePlug() {
    WindowEvent wev = new WindowEvent(this, WindowEvent.WINDOW_CLOSING);
    Toolkit.getDefaultToolkit().getSystemEventQueue().postEvent(wev);
  }
}

