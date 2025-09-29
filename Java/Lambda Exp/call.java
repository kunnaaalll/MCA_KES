import java.util.concurrent.*;

class call {
    Callable r = () -> System.out.println("Function Called!");
    new Callable(r);
}