
class Threading {
   public static void main(String[] args) {

      // lambda Expressive Thread
      Runnable r = () -> System.out.println("Runnable Calling");
      new Thread(r).start();

      // Normal Thread
      // Runnable r1 = new Runnable() {
      // public void run() {
      // System.out.println("Runnable Calling 2");
      // }
      // };
      // new Thread(r1).start();
   
   }
}
