interface Calculator {
    int operation(int a, int b);
}

class LEEg {
    public static void main(String[] args) {
        Calculator c = (a, b) -> a + b;
        Calculator c1 = (a, b) -> a * b;
        Calculator c2 = (a, b) -> a % b;
        System.out.printf("SUM IS %d", c.operation(3, 4));
        System.out.printf("Multiplication of %d", c1.operation(3, 4));
        System.out.printf("Mod is ", c2.operation(3, 4));
    }
}