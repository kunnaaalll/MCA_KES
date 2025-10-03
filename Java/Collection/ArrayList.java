import java.util.ArrayList;

class ArrayList1 {
    public static void main(String[] p) {
        ArrayList<String> a = new ArrayList<>();
        a.add("A");
        a.add("B");
        a.add("C");
        a.add("D");
        a.add("E");
        a.add("F");
        System.out.println(a.size());
        a.forEach(System.out::println);
        for (String h : a) {
            System.out.println(h);
        }
        a.set(4, "new 4th");
        for (int i = 0; i < a.size(); i++) {
            System.out.println(a.get(i));
        }
    }
}

class Student {
    private String name;
    private int marks1, marks2, marks3;
    private String course;
    private double percent;

    public String getName() {
        return name;
    }

    public int getMarks1() {
        return marks1;
    }

    public int getMarks2() {
        return marks2;
    }

    public int getMarks3() {
        return marks3;
    }

    Student(String name, int marks1, int marks2, int marks3) {
        this.name = name;
        this.marks1 = marks1;
        this.marks2 = marks2;
        this.marks3 = marks3;
    }
}

class Demo {
    public static void main(String[] args) {
        ArrayList<Student> student_Collection = new ArrayList<>();
        student_Collection.add(new Student("Kunal", 20, 30, 40));
        student_Collection.add(new Student("ABC", 20, 30, 40));
        student_Collection.add(new Student("DEF", 20, 30, 40));
        student_Collection.add(new Student("GHI", 20, 30, 40));
        student_Collection.add(new Student("JKL", 20, 30, 40));
        student_Collection.add(new Student("MNO", 20, 30, 40));
        for (Student s : student_Collection) {
            System.out.printf("%-20s| %-5d| %-5d| %-5d| \n", s.getName(), s.getMarks1(), s.getMarks2(), s.getMarks3());
        }
    }
}