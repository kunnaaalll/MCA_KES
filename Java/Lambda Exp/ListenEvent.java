import javax.swing.*;
import java.awt.*;

class ListenEvent extends JFrame {
    JButton jb;

    ListenEvent() {
        setVisible(true);
        jb = new JButton("click me");
        setLayout(new FlowLayout());
        add(jb);
        jb.addActionListener((e) -> System.out.println("Button Clicked"));

    }

    public static void main(String[] args) {
        new ListenEvent();
    }
}
