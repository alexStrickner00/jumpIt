import java.net.*;
import java.io.*;

public class NetworkConnection extends Thread {

  private Socket socket;
  private BufferedReader reader;
  private PrintWriter writer;
  private ArrayList<Player> players;
  private Game hostGame;

  public NetworkConnection(Socket socket) {
    this.socket = socket;
    try {
      reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
      writer = new PrintWriter(socket.getOutputStream());
    } 
    catch(IOException e) {
      e.printStackTrace();
    }
  }

  public void setPlayers(ArrayList<Player> players) {
    this.players = players;
  }

  public void setGame(Game game) {
    this.hostGame = game;
  }

  @Override
    public void run() {
    while (socket.isConnected()) {
      String input = waitForCommand();
      handleCommand(input);
    }
  }
  public String waitForCommand() {
    String input = null;
    try {
      while ((input = reader.readLine()) == null);
    } 
    catch(IOException e) {
      e.printStackTrace();
    }
    return input;
  }

  public void handleCommand(String input) {
    String[] args = input.split("_");
    switch(args[0].trim()) {

    case "status":
      status(Integer.parseInt(args[1]));
      break;
    case "m":     
      move(Integer.parseInt(args[1]), args[2]);
      break;
    case "ap":
      addPlayers(Integer.parseInt(args[1]));
      break;
    case "sg":
      this.hostGame.startGame();
      break;
    case "eg":
      this.hostGame.end();
      break;
    case "rg":
      this.hostGame.restartGame();
      break;
    }
  }

  public void move(int id, String direction) {
    Player pl = null;
    for (Player p : players) {
      if (p.getId() == id) {
        pl = p;
        break;
      }
    }

    if (pl == null)
      return;

    switch (direction.charAt(0)) {
    case 'l': 
      pl.left();
      break;
    case 'r': 
      pl.right();
      break;
    default:
      break;
    }
  }

  private void addPlayers(int count) {
    for (int i = 0; i < count; i++) {
      int id = game.addPlayer();
      writer.printf("np_%d\n", id);
    }
    writer.flush();
  }

  private void status(int playerid) {
    Player player = players.get(playerid);
    double vy = player.getVy();
    double xDist = game.getWorld().getNextPlatform(player).getX();
    double fitness = player.getHighest();
    writer.printf( "%d_%f_%f_%f\n", playerid, vy, xDist, fitness);
    writer.flush();
  }

  void sendEndStats() {
    for (Player p : players) {
      writer.printf("pstats_%d_%.0f\n", p.getId(), p.getHighest());
    }
    writer.flush();
  }
}
